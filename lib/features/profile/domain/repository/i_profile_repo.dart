import 'package:in_between/core/domain/user_entity.dart';

abstract class IProfileRepo {
  Future<void> updateEmail(UserEntity email);
  Future<void> updateMobileNum(UserEntity mobileNum);
  Future<void> updatePass(UserEntity pass);
}
