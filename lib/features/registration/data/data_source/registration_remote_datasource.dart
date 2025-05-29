import 'dart:async';

import 'package:in_between/core/web_socket/web_socket.dart';
import 'package:in_between/features/home/data/models/game_history_model.dart';
import 'package:uuid/uuid.dart';
import 'package:in_between/core/error/server_exception.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';
import 'package:in_between/features/registration/data/model/wallet_model.dart';

abstract interface class RegisterRemoteDataSource {
  Future<UserModel?> addNewUser({required UserModel newUser});
  Future<bool> checkUserExistence({required UserModel newUser});
  Future<WalletModel> createUserWallet({required String userId});
  Future<GameHistoryModel> createGameHistory({required String userId});
}

class RegistrationRemoteDatasourceImpl implements RegisterRemoteDataSource {
  final WebSocketService _webSocket;

  RegistrationRemoteDatasourceImpl(this._webSocket);

  @override
  Future<UserModel?> addNewUser({required UserModel newUser}) async {
    try {
      _webSocket.send({'type': 'register_user', 'user': newUser.toJson()});
      return newUser;
    } catch (e) {
      print("ERROR: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<bool> checkUserExistence({required UserModel newUser}) async {
    final completer = Completer<bool>();
    late final StreamSubscription subscription;

    subscription = _webSocket.stream.listen((data) {
      if (data['type'] == 'check_user_existence_data') {
        final exists = data['userExist'] == true;
        completer.complete(exists);
        subscription.cancel();
      }
    });

    _webSocket.send({'type': 'check_user_existence', 'user': newUser.toJson()});

    return completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        subscription.cancel();
        return false;
      },
    );
  }

  @override
  Future<WalletModel> createUserWallet({required String userId}) async {
    final wallet = WalletModel(
      walletId: const Uuid().v4(),
      userId: userId,
      balance: 0.0,
    );

    try {
      _webSocket.send({'type': 'user_wallet', 'user_wallet': wallet.toJson()});
      return wallet;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<GameHistoryModel> createGameHistory({required String userId}) async {
    final gameHistory = GameHistoryModel(
      gameHistoryId: Uuid().v4(),
      userId: userId,
      gameList: [],
    );

    try {
      _webSocket.send({
        'type': 'user_game_history',
        'game_history': gameHistory.toJson(),
      });
      return gameHistory;
    } catch (e) {
      print(("SERVER: ${e.toString()}"));
      throw ServerException(message: e.toString());
    }
  }
}
