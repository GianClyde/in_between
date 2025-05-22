import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/wallet/data/datasource/wallet_local_datasource.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';

class WalletImpRepo implements IWalletRepo {
  final WalletLocalDatasource walletLocalDataSource;
  WalletImpRepo(this.walletLocalDataSource);

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
}
