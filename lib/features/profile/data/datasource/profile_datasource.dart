import 'package:hive/hive.dart';
import 'package:in_between/core/model/user_model.dart';

class ProfileDatasource {
  final Box<UserModel> profileBox = Hive.box<UserModel>('userBox');

  Future<void> updateEmail(UserModel email) async {
    await profileBox.put(email.username, email);
  }

  Future<void> updateMobileNum(UserModel mobile) async {
    await profileBox.put(mobile.username, mobile);
  }

  Future<void> updatePass(UserModel password) async {
    await profileBox.put(password.username, password);
  }
}
