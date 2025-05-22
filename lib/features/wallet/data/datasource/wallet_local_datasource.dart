import 'package:hive/hive.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/model/user_model.dart';

class WalletLocalDatasource {
  // final credit = context.watch<UserCubit>().state;
  final Box<UserModel> walletBox = Hive.box<UserModel>('userBox');

  Future<void> updateCredit(UserEntity credit) async {
    await walletBox.put(credit.username, UserModel.fromEntity(credit));
  }

  Future<UserModel?> getCredit(UserEntity credit) async {
    return walletBox.get(credit.credits);
  }
}
