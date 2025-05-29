import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/registration/data/model/user_model.dart';
import 'package:in_between/features/registration/domain/entity/wallet_entity.dart';

abstract interface class UserWalletRepository {
  Future<Either<Failure, Wallet?>> getUserWallet({required String userId});
}
