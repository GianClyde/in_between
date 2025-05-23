import 'package:flame/components.dart';
import 'package:flame/timer.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:in_between_game/features/game/my_game.dart';

class WinOverlay extends PositionComponent with HasGameReference<MyGame> {
  late TextComponent textLabel;
  late Timer _timer;
  late String result;
  late String lottiePath;

  final bool isWinner;
  final bool hasFolded;
  WinOverlay({
    this.hasFolded = false,
    required this.isWinner,
    super.position,
    super.size,
    super.priority,
  }) {
    _timer = Timer(
      5.0,
      onTick: () {
        game.hasShownOverlay = false;
        _removeOverlay();
      },
      autoStart: true,
    );
    if (hasFolded) {
      result = "FOLDED";
      lottiePath = "assets/lottie/cards_win.json";
    } else {
      if (isWinner) {
        result = "WIN";
        lottiePath = "assets/lottie/cards_win.json";
      } else {
        result = "LOSE";
        lottiePath = "assets/lottie/confetti.json";
      }
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final overlayBackground = RectangleComponent(
      size: size,
      position: Vector2.zero(),
      priority: 19,
      paint: Paint()..color = Colors.black.withOpacity(0.6),
    );
    add(overlayBackground);

    textLabel = TextComponent(
      priority: 25,
      text: result,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2),
    );

    final asset = Lottie.asset(lottiePath);
    final animation = await loadLottie(asset);
    final lottie = LottieComponent(
      priority: 24,
      anchor: Anchor.center,
      animation,
      size: Vector2(300, 300),
      position: Vector2(size.x / 2, size.y / 2 - 40),
      repeating: false,
      duration: 2.5,
      fit: BoxFit.contain,
    );
    add(lottie);
    add(textLabel);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }

  void _removeOverlay() {
    removeFromParent();
  }
}
