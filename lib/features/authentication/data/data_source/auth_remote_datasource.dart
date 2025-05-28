import 'dart:async';

import 'package:in_between/core/web_socket/web_socket.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel?> getUser({
    required String username,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final WebSocketService _webSocket;

  AuthRemoteDataSourceImpl(this._webSocket);

  @override
  Future<UserModel?> getUser({
    required String username,
    required String password,
  }) async {
    final completer = Completer<UserModel?>();
    late final StreamSubscription subscription;

    subscription = _webSocket.stream.listen((message) {
      print("USER: request received ");
      try {
        final data = message;

        if (data['type'] == 'user_data') {
          final user = data['user'];
          print("USER: request contains ${user} ");

          if (user != null &&
              (user['username'].toString().trim() == username.trim() &&
                  user['password'].toString().trim() == password.trim())) {
            final userModel = UserModel(
              userId: user['userId'],
              username: user['username'],
              password: user['password'],
              name: user['name'],
              mobile: user['mobile'],
              bdate: user['bdate'],
              credits: user['credits'] ?? 0.0,
            );

            completer.complete(userModel);
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

    _webSocket.send({'type': 'get_user', 'username': username});

    return completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        subscription.cancel();
        return null;
      },
    );
  }
}
