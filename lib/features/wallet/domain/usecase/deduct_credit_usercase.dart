import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';

class DeductCreditUsercase {
  final IWalletRepo iWalletRepo;
  DeductCreditUsercase(this.iWalletRepo);

  Future<void> execute(UserEntity credit) async {
    // return await iWalletRepo.deductCredit(credit);
  }
}
