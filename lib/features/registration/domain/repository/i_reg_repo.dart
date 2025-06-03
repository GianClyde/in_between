import 'package:in_between/core/domain/user_entity.dart';

abstract class IRegistrationRepo {
  Future<void> addUser(UserEntity user);
  Future<bool> userExists(String username);
  // Future<bool> userLegalAge(String bdate);
}
