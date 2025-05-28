import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';

import 'package:in_between/features/registration/domain/entity/wallet_entity.dart';

abstract class IRegistrationRepo {
  Future<Either<Failure, UserEntity?>> addUser(UserEntity user);
  Future<bool> userExists(String username);
  Future<Either<Failure, Wallet?>> createUserWallet({required String userId});
  // Future<UserEntity?> getUser(String username);

  //update parang dito din
}
