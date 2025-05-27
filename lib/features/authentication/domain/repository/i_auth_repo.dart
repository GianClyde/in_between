import 'package:in_between/features/registration/data/model/user_model.dart';

abstract class IAuthenticationRepo {
  // Future<UserEntity?> getUser(String username, String password);
  // Future<bool> isValid(String username, String password);
  Future<UserModel?> getUser(String username, String password);
}
