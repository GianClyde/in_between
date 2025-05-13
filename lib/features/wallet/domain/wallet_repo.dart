import 'package:hive_flutter/adapters.dart';
import 'package:in_between/core/model/user_model.dart';

class WalletRepo {
  final Box<UserModel> registrationBox = Hive.box<UserModel>('registrationBox');

  double getCurrentCredit(String username) {
    final user = registrationBox.values.firstWhere(
      (user) => user.username == username,
    );
    return user.credits;
  }

  //update username to id
  Future updateCredit(String username, double newCredit) async {
    final user = registrationBox.values.firstWhere(
      (user) => user.username == username,
    );
    user.credits = newCredit;
    user.save();
  }
}
