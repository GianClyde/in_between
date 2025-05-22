import 'package:in_between/core/domain/user_entity.dart';

abstract class IAuthenticationRepo {
  Future<UserEntity?> getUser(String username, String password);
  Future<bool> isValid(String username, String password);
}
