import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/home/domain/repository/user_wallet_repository.dart';
import 'package:in_between/features/registration/domain/entity/wallet_entity.dart';

class GetUserWalletUsecase {
  final UserWalletRepository userWalletRepository;

  GetUserWalletUsecase({required this.userWalletRepository});

  Future<Either<Failure, Wallet?>> execute({required String userId}) async {
    return await userWalletRepository.getUserWallet(userId: userId);
  }
}
