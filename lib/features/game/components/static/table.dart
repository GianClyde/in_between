import 'dart:async';

import 'package:flame/components.dart';
import 'package:in_between_game/features/game/my_game.dart';

class Table extends SpriteComponent with HasGameReference<MyGame> {
  Table({required super.position}) : super(anchor: Anchor.center, priority: 1);

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite("gametable.png");

    final screenSize = game.size;
    size = Vector2(screenSize.x * 0.9 + 30, screenSize.y + 40);

    return super.onLoad();
  }
}
