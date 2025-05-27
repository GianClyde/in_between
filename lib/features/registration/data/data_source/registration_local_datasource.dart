import 'package:hive/hive.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/model/user_model.dart';

class RegistrationLocalDatasource {
  final Box<UserModel> regBox = Hive.box<UserModel>('userBox');
  // final Box<UserModel> regBox;
  // RegistrationLocalDatasource(this.regBox);

  Future<void> addNewUser(UserEntity user) async {
    await regBox.put(user.username, UserModel.fromEntity(user));
    // return user;
  }

  Iterable<UserModel> getUsers() {
    return regBox.values;
  }
}
