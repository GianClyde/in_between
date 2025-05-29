import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/registration/domain/repository/i_reg_repo.dart';

class AddNewUserUseCase {
  final IRegistrationRepo iRegistrationRepo;
  AddNewUserUseCase(this.iRegistrationRepo);

  Future<Either<Failure, UserEntity?>> execute(UserEntity user) async {
    final newUserResult = await iRegistrationRepo.addUser(user);

    return await newUserResult.fold((failure) => left(failure), (
      newUser,
    ) async {
      if (newUser == null) {
        return left(Failure(message: 'User creation failed'));
      }

      // Create wallet
      final walletResult = await iRegistrationRepo.createUserWallet(
        userId: newUser.userId,
      );

      return await walletResult.fold((failure) => left(failure), (_) async {
        //Create game history
        final gameHistoryResult = await iRegistrationRepo.createGameHistory(
          userId: newUser.userId,
        );

        return gameHistoryResult.fold(
          (failure) => left(failure),
          (_) => right(newUser), // Return new user if all succeeded
        );
      });
    });
  }
}
