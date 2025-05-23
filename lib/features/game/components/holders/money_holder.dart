import 'package:flame/components.dart';

import 'package:flutter/painting.dart';
import 'package:in_between_game/features/game/my_game.dart';

class MoneyHolder extends SpriteComponent with HasGameReference<MyGame> {
  late TextComponent _text;
  final double fontSize;
  int _money = 0;

  MoneyHolder({
    required this.fontSize,
    required Sprite bg,
    required Vector2 position,
    required Vector2 size,
    super.priority,
  }) : super(position: position, size: size, sprite: bg);

  @override
  Future<void> onLoad() async {
    _text = TextComponent(
      text: '\$$_money',
      position: Vector2(50, size.y / 2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          color: const Color(0xFFFFFFFF),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    //add(_background);
    add(_text);
  }

  void updateMoney(int newAmount) {
    _money = newAmount;
    _text.text = '\$$_money';
  }
}
