import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/home/data/datasource/home_remote_datasource.dart';
import 'package:in_between/features/home/domain/repository/user_wallet_repository.dart';
import 'package:in_between/features/registration/domain/entity/wallet_entity.dart';

class UserWalletRepositoryImp implements UserWalletRepository {
  final HomeRemoteDatasource homeRemoteDatasource;

  UserWalletRepositoryImp({required this.homeRemoteDatasource});
  @override
  Future<Either<Failure, Wallet?>> getUserWallet({
    required String userId,
  }) async {
    try {
      final userWallet = await homeRemoteDatasource.getUserWallet(
        userId: userId,
      );
      if (userWallet == null) {
        return left(Failure(message: "No Walet Fount"));
      }
      return right(userWallet);
    } catch (e) {
      return left(Failure(message: "An Error Has Occured: ${e.toString()}"));
    }
  }
}
