import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/core/error/server_exception.dart';
import 'package:in_between/features/registration/data/data_source/registration_local_datasource.dart';
import 'package:in_between/features/registration/data/data_source/registration_remote_datasource.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';
import 'package:in_between/features/registration/domain/repository/i_reg_repo.dart';
import 'package:uuid/uuid.dart';

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
  Future<Either<Failure, UserModel?>> addUser(UserEntity user) async {
    //await localDatasource.addNewUser(user);
    final newUser = UserModel(
      userId: Uuid().v4(),
      username: user.username,
      password: user.password,
      name: user.name,
      mobile: user.mobile,
      bdate: user.bdate,
      credits: user.credits,
    );

    try {
      final bool doesUserExist = await registerRemoteDataSource
          .checkUserExistence(newUser: newUser);
      // final bool doesUserExist = false;
      final UserModel? user = await registerRemoteDataSource.addNewUser(
        newUser: newUser,
      );

      if (doesUserExist) {
        return left(Failure(message: "User already exists"));
      } else {
        return right(user);
      }
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
