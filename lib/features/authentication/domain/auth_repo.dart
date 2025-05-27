import 'package:hive/hive.dart';
import 'package:in_between/features/registration/data/model/user_model.dart' show UserModel;


class Authrepo {
  final Box<UserModel> registrationBox = Hive.box<UserModel>('registrationBox');

  List<UserModel> getUsers() {
    return registrationBox.values.toList();
  }

  bool isValid(String username, String password) {
    return registrationBox.values.any(
      (user) => user.username == username && user.password == password,
    );
  }
}
