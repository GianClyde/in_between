import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/features/wallet/data/datasource/wallet_local_datasource.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';

class WalletImpRepo implements IWalletRepo {
  final WalletLocalDatasource walletLocalDataSource;
  WalletImpRepo(this.walletLocalDataSource);

  @override
  Future<void> updateCredit(UserEntity credit) {
    final toModel = UserModel.fromEntity(credit);
    return walletLocalDataSource.updateCredit(toModel);
  }
}
