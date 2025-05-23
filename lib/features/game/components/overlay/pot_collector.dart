import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:in_between_game/features/game/components/holders/money_holder.dart';
import 'package:in_between_game/features/game/my_game.dart';

class PotCollector extends PositionComponent with HasGameReference<MyGame> {
  // late LottieComponent coinFlow;
  late MoneyHolder potHolder;
  final int playerNo;
  final int potValue;
  late List<Vector2> tableCoordinates;

  PotCollector({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
    required this.potValue,
    required this.playerNo,
  });

  @override
  FutureOr<void> onLoad() async {
    final potHolderSprite = await game.loadSprite('holders/pot_bg.png');
    potHolder = MoneyHolder(
      priority: 25,
      fontSize: 12,
      bg: potHolderSprite,
      position: Vector2(size.x / 2 - 80, size.y / 2 - 45),
      size: Vector2(150, 80),
    );
    _createCoinFlow();
    add(potHolder);
    potHolder.updateMoney(potValue);
    return super.onLoad();
  }

  double _calculatePlayerAngle(int index) {
    if (index == 0) return 45 * (3.14159265 / 180);
    if (index == 1) return 315 * (3.14159265 / 180);
    if (index == 2) return 270 * (3.14159265 / 180);
    if (index == 3) return 225 * (3.14159265 / 180);
    if (index == 4) return 135 * (3.14159265 / 180);
    if (index == 5) return 90 * (3.14159265 / 180);
    return 0;
  }

  Future<void> _createCoinFlow() async {
    tableCoordinates = [
      Vector2(330, 260),
      Vector2(510, 260),
      Vector2(530, 220),
      Vector2(505, 165),
      Vector2(340, 165),
      Vector2(310, 220),
    ];
    for (int i = 0; i < playerNo; i++) {
      final asset = Lottie.asset("assets/lottie/coin_flow.json");
      final animation = await loadLottie(asset);
      final coinFlow = LottieComponent(
        priority: 25,
        angle: _calculatePlayerAngle(i),
        anchor: Anchor.center,
        animation,
        size: Vector2(100, 100),
        position: tableCoordinates[i],
        repeating: false,
        duration: 1.5,
        fit: BoxFit.contain,
      );
      print("COORD: ${game.tableCoordinates[i]}");
      add(coinFlow);
    }
  }
}
