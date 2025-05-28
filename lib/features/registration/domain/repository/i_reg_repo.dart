import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';

abstract class IRegistrationRepo {
  Future<Either<Failure, UserModel?>> addUser(UserEntity user);
  Future<bool> userExists(String username);
  // Future<UserEntity?> getUser(String username);

  //update parang dito din
}
