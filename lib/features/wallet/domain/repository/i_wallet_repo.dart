import 'package:in_between/core/domain/user_entity.dart';

abstract class IWalletRepo {
  Future<int> addCredit(String usrname, int credit);
  Future<int> deductCredit(String usrname, int credit);
  Future<void> updateCredit(UserEntity credit);
}
