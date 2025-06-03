part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

class CashIn extends WalletEvent {
  final UserEntity user;
  final double inputedCredit;

  CashIn(this.user, this.inputedCredit);
}

class CashOut extends WalletEvent {
  final UserEntity user;
  final double inputedCredit;

  CashOut(this.user, this.inputedCredit);
}

class IncompleteField extends WalletEvent {}
