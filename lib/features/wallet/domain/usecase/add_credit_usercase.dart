import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';

class AddCreditUsercase {
  final IWalletRepo iWalletRepo;
  AddCreditUsercase(this.iWalletRepo);

  Future<void> execute(UserEntity credit) async {
    // return await iWalletRepo.addCredit(credit);
  }
}
