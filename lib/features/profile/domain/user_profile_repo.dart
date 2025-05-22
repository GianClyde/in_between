import 'package:hive_flutter/adapters.dart';
import 'package:in_between/core/model/user_model.dart';

class UserProfileRepo {
  final Box<UserModel> userBox = Hive.box<UserModel>('userBox');

  Iterable<UserModel> getUsers() {
    return userBox.values;
  }
}
