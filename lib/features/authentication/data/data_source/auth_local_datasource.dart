import 'package:hive/hive.dart';
import 'package:in_between/core/model/user_model.dart';

class AuthenticationLocalDatasource {
  final Box<UserModel> authBox = Hive.box<UserModel>('userBox');

  Iterable<UserModel> getUsers() {
    return authBox.values;
  }
}
