import 'package:in_between/core/domain/user_entity.dart';

abstract class IWalletRepo {
  Future<void> updateCredit(UserEntity credit);
}
