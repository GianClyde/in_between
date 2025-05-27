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
  Future<UserModel?> getUser(String username, String password) async {
    final UserModel? user = await authRemoteDatasource.getUser(
      username: username,
      password: password,
    );

    print("USER repo impl triggered");
    return user;
  }
}

//explain the to entity and factory shit


//after model in every feature, how will i make every feature communicate
//say registration and login models