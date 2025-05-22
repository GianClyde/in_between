import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/authentication/data/data_source/auth_local_datasource.dart';
import 'package:in_between/features/authentication/domain/repository/i_auth_repo.dart';

class AuthenticationRepoImplementation implements IAuthenticationRepo {
  final AuthenticationLocalDatasource localDatasource;
  AuthenticationRepoImplementation(this.localDatasource);

  @override
  Future<UserEntity?> getUser(String username, String password) async {
    var users =  localDatasource.getUsers();
    final matchingUser = users.where(
      (user) => user.username == username && user.password == password,
    ).toList();

    if (matchingUser.isEmpty) return null;
    return matchingUser.first.toEntity();
  }

  @override
  Future<bool> isValid(String username, String password) async {
    return localDatasource.getUsers().any(
      (user) => user.username == username && user.password == password,
    );
  }
}

//explain the to entity and factory shit


//after model in every feature, how will i make every feature communicate
//say registration and login models