import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';

class UpdateCreditUsecase {
  final IWalletRepo iWalletRepo;
  UpdateCreditUsecase(this.iWalletRepo);

  Future<void> execute(UserEntity credit) {
    return iWalletRepo.updateCredit(credit);
  }
}
