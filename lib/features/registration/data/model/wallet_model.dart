import 'dart:convert';
import 'package:in_between/features/registration/domain/entity/wallet_entity.dart';

class WalletModel extends Wallet {
  WalletModel({
    required super.walletId,
    required super.userId,
    required super.balance,
  });

  Map<String, dynamic> toMap() {
    return {'walletId': walletId, 'userId': userId, 'balance': balance};
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      walletId: map['walletId'] as String,
      userId: map['userId'] as String,
      balance: map['balance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));

  Wallet toEntity() {
    return Wallet(walletId: walletId, userId: userId, balance: balance);
  }
}
