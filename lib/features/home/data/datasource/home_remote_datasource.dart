import 'dart:async';

import 'package:in_between/core/web_socket/web_socket.dart';
import 'package:in_between/features/registration/data/model/wallet_model.dart';

abstract interface class HomeRemoteDatasource {
  Future<WalletModel?> getUserWallet({required String userId});
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final WebSocketService _webSocket;

  HomeRemoteDatasourceImpl({required WebSocketService webSocket})
    : _webSocket = webSocket;
  @override
  Future<WalletModel?> getUserWallet({required String userId}) async {
    final completer = Completer<WalletModel?>();
    late final StreamSubscription subscription;

    subscription = _webSocket.stream.listen((message) {
      print("USER: request received ");
      try {
        final data = message;

        if (data['type'] == 'get_user_wallet_result') {
          final wallet = data['user_wallet'];
          print("USER: request contains ${wallet} ");

          if (wallet != null) {
            final walletModel = WalletModel(
              walletId: wallet['walletId'],
              userId: wallet['userId'],
              balance: wallet['balance'],
            );

            completer.complete(walletModel);
            //Todo utilize fromJson sa model
          } else {
            completer.complete(null);
          }

          subscription.cancel();
        } else {
          print("USER: other type");
        }
      } catch (e) {
        if (!completer.isCompleted) {
          completer.completeError("Error decoding server response: $e");
        }
        subscription.cancel();
      }
    });

    _webSocket.send({'type': 'get_user_wallet', 'userId': userId});

    return completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        subscription.cancel();
        return null;
      },
    );
  }
}
