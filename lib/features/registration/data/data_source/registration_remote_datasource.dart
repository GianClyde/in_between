import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:in_between/features/registration/data/model/user_model.dart';

abstract interface class RegisterRemoteDataSource {
  Future<void> addNewUser({required UserModel newUser});
}

class RegistrationRemoteDatasourceImpl implements RegisterRemoteDataSource {
  final WebSocketChannel channel;

  RegistrationRemoteDatasourceImpl({required this.channel});
  @override
  Future<void> addNewUser({required UserModel newUser}) async {
    final data = newUser.toJson();

    try {
      channel.sink.add(data);
    } catch (e) {
      print("ERROR: ${e.toString()}");
    }
  }
}
