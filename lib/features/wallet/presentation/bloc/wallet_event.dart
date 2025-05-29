part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

class CashIn extends WalletEvent {
  // final String username;
  final UserEntity user;
  final double inputedCredit;

  CashIn(this.user, this.inputedCredit);
}

class CashOut extends WalletEvent {
  final String username;
  final double credit;

  CashOut(this.username, this.credit);
}

class IncompleteField extends WalletEvent {}

final class DepositWallet extends WalletEvent {
  final String userWalletId;
  final double depositAmount;

  DepositWallet({required this.userWalletId, required this.depositAmount});
}
