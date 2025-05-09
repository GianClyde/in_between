import 'package:hive_flutter/adapters.dart';
import 'package:in_between/core/model/user_model.dart';

class RegistrationRepo {
  final Box<UserModel> registrationBox = Hive.box<UserModel>('registrationBox');

  List<UserModel> getUsers() {
    return registrationBox.values.toList();
  }

  Future<bool> addUser(UserModel user) async {
    bool userExists = registrationBox.values.any(
      (existing) => existing.username == user.username,
    );
    if (!userExists) {
      await registrationBox.add(user);
      print('Added to box');
      return true;
      // add a state UserAdded to trigger a snakbar to show
    } else {
      print('User Exists');
      return false;

      //add a state UserAlready exists
    }
  }

  // bool isFilled(String username, String password, String name, String mobile, String bdate){

  // }
}
