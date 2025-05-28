import 'package:in_between/features/registration/data/model/wallet_model.dart';

abstract interface class HomeRemoteDatasource {
  Future<WalletModel?> getUserWallet({required String userId});
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  @override
  Future<WalletModel?> getUserWallet({required String userId}) {
    // TODO: implement getUserWallet
    throw UnimplementedError();
  }
}
