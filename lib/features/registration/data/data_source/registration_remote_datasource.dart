import 'dart:async';
import 'dart:convert';

import 'package:in_between/core/error/server_exception.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:in_between/features/registration/data/model/user_model.dart';

abstract interface class RegisterRemoteDataSource {
  Future<UserModel?> addNewUser({required UserModel newUser});
  Future<bool> checkUserExistence({required UserModel newUser});
}

class RegistrationRemoteDatasourceImpl implements RegisterRemoteDataSource {
  final WebSocketChannel channel;

  RegistrationRemoteDatasourceImpl({required this.channel});
  @override
  Future<UserModel?> addNewUser({required UserModel newUser}) async {
    final data = newUser.toJson();

    try {
      channel.sink.add(data);
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

    subscription = channel.stream.listen(
      (message) {
        print("USER: request received ");
        try {
          final data = jsonDecode(message);

          if (data['type'] == 'check_user_existence_data') {
            final userExist = data['userExist'];
            print("USER: does user exist ${userExist} ");

            completer.complete(userExist);

            subscription.cancel();
          } else {
            print("USER: other type");
          }
        } catch (e) {
          if (!completer.isCompleted) {
            print("USER: ${e.toString()}");
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
          completer.complete(false);
        }
      },
      cancelOnError: true,
    );

    try {
      final userData = newUser.toJson();
      final data = {'type': 'check_user_existence', 'user': userData};
      channel.sink.add(data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }

    final completerVal = completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        subscription.cancel();
        print("USER: Timeout waiting for server response");
        return false;
      },
    );
    print("USER: completerVal = $completerVal");
    return completerVal;
  }
}
