import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/core/error/server_exception.dart';
import 'package:in_between/features/home/domain/entity/game_history.dart';
import 'package:in_between/features/registration/data/data_source/registration_local_datasource.dart';
import 'package:in_between/features/registration/data/data_source/registration_remote_datasource.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';
import 'package:in_between/features/registration/domain/entity/wallet_entity.dart';
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
  Future<Either<Failure, UserEntity?>> addUser(UserEntity user) async {
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
      final doesUserExist = await registerRemoteDataSource.checkUserExistence(
        newUser: newUser,
      );

      print("USER EXIT: $doesUserExist");

      if (doesUserExist) {
        return left(Failure(message: "User already exists"));
      }

      final UserModel? createdUser = await registerRemoteDataSource.addNewUser(
        newUser: newUser,
      );

      if (createdUser != null) {
        return right(createdUser.toEntity());
      } else {
        return left(Failure(message: "Failed to create user"));
      }
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Wallet?>> createUserWallet({
    required String userId,
  }) async {
    try {
      final userWallet = await registerRemoteDataSource.createUserWallet(
        userId: userId,
      );
      return right(userWallet);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GameHistory?>> createGameHistory({
    required String userId,
  }) async {
    try {
      final gameHistory = await registerRemoteDataSource.createGameHistory(
        userId: userId,
      );
      return right(gameHistory);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
