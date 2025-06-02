import 'dart:async';

import 'package:in_between/core/web_socket/web_socket.dart';

abstract interface class WalletRemoteDatasource {
  Future<double?> despositToWallet({
    required String userWalletId,
    required double depositAmount,
  });

  Future<double?> withdrawFromWallet({
    required String userWalletId,
    required double withdrawAmount,
  });
}

class WalletLocalDatasourceImpl implements WalletRemoteDatasource {
  final WebSocketService _webSocketService;

  WalletLocalDatasourceImpl({required WebSocketService webSocketService})
    : _webSocketService = webSocketService;
  @override
  Future<double?> despositToWallet({
    required String userWalletId,
    required depositAmount,
  }) async {
    final completer = Completer<double?>();
    late final StreamSubscription subscription;

    subscription = _webSocketService.stream.listen((message) {
      print("USER: request received ");
      try {
        final data = message;

        if (data['type'] == 'get_wallet_balance') {
          final balance = data['balance'];
          print("USER: request contains ${balance} ");

          if (balance != null) {
            completer.complete(balance);
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

    _webSocketService.send({
      'type': 'deposit_wallet',
      'walletId': userWalletId,
      'depositAmount': depositAmount,
    });

    return completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        subscription.cancel();
        return null;
      },
    );
  }

  @override
  Future<double?> withdrawFromWallet({
    required String userWalletId,
    required double withdrawAmount,
  }) async {
    final completer = Completer<double?>();
    late final StreamSubscription subscription;

    subscription = _webSocketService.stream.listen((message) {
      print("USER: request received ");
      try {
        final data = message;

        if (data['type'] == 'get_wallet_balance') {
          final balance = data['balance'];
          print("USER: request contains ${balance} ");

          if (balance != null) {
            completer.complete(balance);
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

    _webSocketService.send({
      'type': 'withdraw_wallet',
      'walletId': userWalletId,
      'depositAmount': withdrawAmount,
    });

    return completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        subscription.cancel();
        return null;
      },
    );
  }
}
