import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';

import 'package:in_between/features/authentication/domain/repository/i_auth_repo.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';

//gets the username and password
class GetUserUsecase {
  final IAuthenticationRepo iAuthRepo;
  GetUserUsecase(this.iAuthRepo);

  Future<Either<Failure, UserModel?>> execute(
    String username,
    String password,
  ) async {
    print("USER usecase triggered");

    final user = await iAuthRepo.getUser(username, password);
    print("USER usecase user contains $user");
    return user;
  }
}
