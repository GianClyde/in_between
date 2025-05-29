import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';

class DepositWalletUsecase {
  final IWalletRepo iWalletRepo;

  DepositWalletUsecase({required this.iWalletRepo});

  Future<Either<Failure, double>> execute({
    required String userWalletId,
    required double depositAmount,
  }) async {
    return await iWalletRepo.despositToWallet(
      userWalletId: userWalletId,
      depositAmount: depositAmount,
    );
  }
}
