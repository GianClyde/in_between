import 'package:hive/hive.dart';
import 'package:in_between/core/model/user_model.dart';

class WalletLocalDatasource {
  final Box<UserModel> walletBox = Hive.box<UserModel>('userBox');

  Future<void> updateCredit(UserModel credit) async {
    await walletBox.put(credit.username, credit);
  }
}
