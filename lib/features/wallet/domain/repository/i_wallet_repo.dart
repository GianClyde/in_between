import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';

abstract class IWalletRepo {
  Future<int> addCredit(String usrname, int credit);
  Future<int> deductCredit(String usrname, int credit);
  Future<void> updateCredit(UserEntity credit);

  //for remote DS
  Future<Either<Failure, double>> despositToWallet({
    required String userWalletId,
    required double depositAmount,
  });

  Future<Either<Failure, double>> withdrawFromWallet({
    required String userWalletId,
    required double withdrawAmount,
  });
}
