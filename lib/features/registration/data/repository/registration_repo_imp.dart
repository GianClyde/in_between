import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/registration/data/data_source/registration_local_datasource.dart';
import 'package:in_between/features/registration/domain/repository/i_reg_repo.dart';

class RegistrationRepoImp implements IRegistrationRepo {
  final RegistrationLocalDatasource localDatasource;
  RegistrationRepoImp(this.localDatasource);

  @override
  Future<bool> userExists(String username) async {
    return localDatasource.getUsers().any(
      (exists) => exists.username == username,
    );
  }

  @override
  Future<void> addUser(UserEntity user) async {
     await localDatasource.addNewUser(user);
  }
}
