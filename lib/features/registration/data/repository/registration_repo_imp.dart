import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/registration/data/data_source/registration_local_datasource.dart';
import 'package:in_between/features/registration/data/data_source/registration_remote_datasource.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';
import 'package:in_between/features/registration/domain/repository/i_reg_repo.dart';

class RegistrationRepoImp implements IRegistrationRepo {
  final RegistrationLocalDatasource localDatasource; // TODO remove later
  final RegisterRemoteDataSource registerRemoteDataSource;
  RegistrationRepoImp({
    required this.localDatasource,
    required this.registerRemoteDataSource,
  });

  @override
  Future<bool> userExists(String username) async {
    return localDatasource.getUsers().any(
      (exists) => exists.username == username,
    );
  }

  @override
  Future<void> addUser(UserEntity user) async {
    //await localDatasource.addNewUser(user);
    final newUser = UserModel(
      username: user.username,
      password: user.password,
      name: user.name,
      mobile: user.mobile,
      bdate: user.bdate,
      credits: user.credits,
    );
    await registerRemoteDataSource.addNewUser(newUser: newUser);
  }
}
