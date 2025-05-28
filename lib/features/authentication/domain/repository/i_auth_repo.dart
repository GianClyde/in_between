import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';

abstract class IAuthenticationRepo {
  // Future<UserEntity?> getUser(String username, String password);
  // Future<bool> isValid(String username, String password);
  Future<Either<Failure, UserModel?>> getUser(String username, String password);
}
