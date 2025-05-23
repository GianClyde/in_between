import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';

class PlayerTurnArrow extends SpriteComponent {
  final int playerIndex;
  PlayerTurnArrow({
    super.size,
    super.position,
    super.scale,
    required this.playerIndex,
  });

  @override
  FutureOr<void> onLoad() async {
    final arrowSprite = await Flame.images.load('player_arrow.png');
    sprite = Sprite(arrowSprite);
    size = Vector2(25, 25);
    position = _calculateArrowPosition(playerIndex);
    priority = 15;

    _addBounceEffect();
    return super.onLoad();
  }

  void _addBounceEffect() {
    final moveUp = MoveByEffect(
      Vector2(0, -5),
      EffectController(duration: 0.4, reverseDuration: 0.4, infinite: true),
    );
    add(moveUp);
  }

  void show() {
    opacity = 1.0;
  }

  Vector2 _calculateArrowPosition(int index) {
    if (index == 2) return Vector2(size.x + 5, size.y - 100);
    if (index == 3 || index == 4) return Vector2(size.x + 5, size.y - 75);
    if (index == 5) return Vector2(size.x + 5, size.y - 100);
    return Vector2(size.x, size.y - 70);
  }
}
