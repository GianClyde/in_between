part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeUserWalletFetchedSuccess extends HomeState {
  final Wallet userWallet;

  HomeUserWalletFetchedSuccess({required this.userWallet});
}

final class HomeUserWalletFetchedFailed extends HomeState {
  final String message;

  HomeUserWalletFetchedFailed({required this.message});
}

final class HomeUserWalletFetchedLoading extends HomeState {}
