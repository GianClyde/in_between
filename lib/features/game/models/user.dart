import 'package:in_between_game/features/game/models/wallets.dart';

class User {
  final String id;
  final String userName;
  final Wallet userWallet;
  User({required this.userWallet, required this.id, required this.userName});
}
