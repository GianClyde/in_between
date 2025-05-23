import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:in_between_game/features/game/models/user.dart';

class PlayerText extends PositionComponent {
  late TextComponent userName;
  late TextComponent walletBalance;
  late int walletBalValUpdateable;

  final int walletBalanceVal;

  final User user;

  // final double textAngle;

  PlayerText({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
    required this.user,
    required this.walletBalanceVal,
    // required this.textAngle,
  }) {
    walletBalValUpdateable = walletBalanceVal;
  }
  @override
  FutureOr<void> onLoad() {
    userName = TextComponent(
      text: user.userName,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x / 2 + 40, size.y / 2 - 20),
    );

    walletBalance = TextComponent(
      //angle: textAngle,
      text: "PHP $walletBalValUpdateable",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x / 2 + 40, size.y / 2 - 5),
    );

    add(walletBalance);
    add(userName);

    return super.onLoad();
  }

  void updateWalletBalance(int newWalletBalance) {
    walletBalValUpdateable = newWalletBalance;
    walletBalance.text = "PHP $walletBalValUpdateable";
  }
}
