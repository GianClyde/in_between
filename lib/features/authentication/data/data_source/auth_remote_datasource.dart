import 'dart:async';
import 'dart:convert';

import 'package:in_between/features/registration/data/model/user_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel?> getUser({
    required String username,
    required String password,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDatasource {
  final WebSocketChannel channel;

  AuthRemoteDataSourceImpl({required this.channel});

  @override
  Future<UserModel?> getUser({
    required String username,
    required String password,
  }) async {
    final completer = Completer<UserModel?>();
    late final StreamSubscription subscription;

    try {
      subscription = channel.stream.listen(
        (message) {
          print("USER: request received ");
          try {
            final data = jsonDecode(message);

            if (data['type'] == 'user_data') {
              final user = data['user'];
              print("USER: request contains ${user} ");

              if (user != null &&
                  (user['username'].toString().trim() == username.trim() &&
                      user['password'].toString().trim() == password.trim())) {
                final userModel = UserModel(
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

              //completer.complete(UserModel.fromMap(user));

              // if (user != null &&
              //     user['username'].toString().trim() == username.trim() &&
              //     user['password'].toString().trim() == password.trim()) {
              //   print("USER: user model from map ${UserModel.fromMap(user)}");
              //   print("✅ USER MATCHED: ${user['username']}");
              //   final testser = UserModel(
              //     username: "c",
              //     password: "c",
              //     name: "c",
              //     mobile: "c",
              //     bdate: "c",
              //     credits: 0.0,
              //   );

              //   final userModel = UserModel(
              //     username: user['username'],
              //     password: user['password'],
              //     name: user['name'],
              //     mobile: user['mobile'],
              //     bdate: user['bdate'],
              //     credits: user['credits'] ?? 0.0,
              //   );

              //   //completer.complete(UserModel.fromMap(user));
              //   completer.complete(userModel);
              // } else {
              //   print("❌ USER: mismatch");
              //   completer.complete(null);
              // }

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
        },
        onError: (error) {
          if (!completer.isCompleted) {
            print("USER: completer error $error");
            completer.completeError("WebSocket error: $error");
          }
          subscription.cancel();
        },
        onDone: () {
          if (!completer.isCompleted) {
            completer.complete(null);
          }
        },
        cancelOnError: true,
      );

      final request = jsonEncode({'type': 'get_user', 'username': username});
      channel.sink.add(request);

      print("📤 Sent user fetch request for: $username");

      final completerVal = completer.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          subscription.cancel();
          print("USER: Timeout waiting for server response");
          return null;
        },
      );
      print("USER: completerVal = $completerVal");
      return completerVal;
    } catch (e) {
      print("USER AUTH ERROR: $e");
      return null;
    }
  }
}
