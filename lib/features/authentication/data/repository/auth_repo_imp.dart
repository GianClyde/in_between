import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/authentication/data/data_source/auth_local_datasource.dart';
import 'package:in_between/features/authentication/data/data_source/auth_remote_datasource.dart';
import 'package:in_between/features/authentication/domain/repository/i_auth_repo.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';

class AuthenticationRepoImplementation implements IAuthenticationRepo {
  final AuthenticationLocalDatasource localDatasource;
  final AuthRemoteDatasource authRemoteDatasource;
  AuthenticationRepoImplementation({
    required this.localDatasource,
    required this.authRemoteDatasource,
  });

  @override
  Future<Either<Failure, UserModel?>> getUser(
    String username,
    String password,
  ) async {
    try {
      final UserModel? user = await authRemoteDatasource.getUser(
        username: username,
        password: password,
      );

      if (user != null) {
        print("USER repo impl triggered");
        return right(user);
      } else {
        return left(Failure(message: "No User Found"));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

//explain the to entity and factory shit


//after model in every feature, how will i make every feature communicate
//say registration and login models