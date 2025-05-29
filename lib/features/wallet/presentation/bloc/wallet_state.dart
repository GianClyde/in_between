part of 'wallet_bloc.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

final class CashInSuccess extends WalletState {
  final UserEntity credit;
  CashInSuccess(this.credit);
}

final class CashInFail extends WalletState {}

final class CashOutSuccess extends WalletState {}

final class CashOutFail extends WalletState {}
//di na-add tas successcashout

// new
final class WalletDepositSuccess extends WalletState {
  final double newBalance;

  WalletDepositSuccess({required this.newBalance});
}

final class WalletDepositFailed extends WalletState {
  final String message;

  WalletDepositFailed({required this.message});
}

//shared

final class WalletLoading extends WalletState {}
