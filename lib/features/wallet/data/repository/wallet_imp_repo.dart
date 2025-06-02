import 'package:fpdart/src/either.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/wallet/data/datasource/wallet_local_datasource.dart';
import 'package:in_between/features/wallet/data/datasource/wallet_remote_datasource.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';

class WalletImpRepo implements IWalletRepo {
  final WalletRemoteDatasource walletRemoteDatasource;
  final WalletLocalDatasource walletLocalDataSource;
  WalletImpRepo({
    required this.walletLocalDataSource,
    required this.walletRemoteDatasource,
  });

  @override
  Future<int> addCredit(String username, int credit) async {
    final currentCredit =
        walletLocalDataSource.getCredit(username as UserEntity) as int;

    final newCredit = currentCredit + credit;
    return newCredit;
  }

  @override
  Future<int> deductCredit(String username, int credit) async {
    final currentCredit =
        walletLocalDataSource.getCredit(username as UserEntity) as int;

    final newCredit = currentCredit - credit;
    return newCredit;
  }

  //eto i use updateCredit
  @override
  Future<void> updateCredit(UserEntity credit) {
    return walletLocalDataSource.updateCredit(credit);
  }

  //for remot DS
  @override
  Future<Either<Failure, double>> despositToWallet({
    required String userWalletId,
    required double depositAmount,
  }) async {
    try {
      final walletBalance = await walletRemoteDatasource.despositToWallet(
        userWalletId: userWalletId,
        depositAmount: depositAmount,
      );

      if (walletBalance == null) {
        return left(Failure(message: "No Balance Retrieved"));
      }
      return right(walletBalance);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> withdrawFromWallet({
    required String userWalletId,
    required double withdrawAmount,
  }) async {
    try {
      final walletBalance = await walletRemoteDatasource.withdrawFromWallet(
        userWalletId: userWalletId,
        withdrawAmount: withdrawAmount,
      );

      if (walletBalance == null) {
        return left(Failure(message: "Failed to retrieve balance"));
      }

      return right(walletBalance);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
