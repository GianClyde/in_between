import 'package:hive/hive.dart';
import 'package:in_between/core/model/user_model.dart';

class RegistrationLocalDatasource {
  final Box<UserModel> regBox = Hive.box<UserModel>('userBox');

  Future<void> addNewUser(UserModel user) async {
    await regBox.put(user.username, user);
  }

  Iterable<UserModel> getUsers() {
    return regBox.values;
  }
}
