import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';

class WithdrawWalletUsecase {
  final IWalletRepo iWalletRepo;

  WithdrawWalletUsecase({required this.iWalletRepo});

  Future<Either<Failure, double>> execute({
    required String userWalletId,
    required double withdrawAmount,
  }) async {
    return await iWalletRepo.withdrawFromWallet(
      userWalletId: userWalletId,
      withdrawAmount: withdrawAmount,
    );
  }
}
