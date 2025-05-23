import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/timer.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:in_between_game/features/game/components/overlay/pot_collector.dart';
import 'package:in_between_game/features/game/my_game.dart';

class EmptyPotOverlay extends PositionComponent with HasGameReference<MyGame> {
  late TextComponent textLabel;
  late TextComponent subLabel;
  late PotCollector potCollector;
  final int potValue;
  //String _potValue = "0";
  late Timer _timer;
  double _elapsedTime = 0.0;
  bool _threeSecondTriggered = false;
  int _popCount = 0;
  EmptyPotOverlay({
    super.position,
    super.size,
    super.priority,
    required this.potValue,
  }) {
    _timer = Timer(
      10.0, // change to five
      onTick: () async {
        _removeOverlay();
        game.hasShownOverlay = false;
        game.hasFolded = false;
        await game.gameFlowManager.switchToNextPlayer();

        game.headerText.updateUserName(game.activePlayer.user.userName);

        await game.card1.updateCard(game.activePlayer.card1!);
        await game.guessCard.updateCard(game.activePlayer.guessCard!);
        await game.card2.updateCard(game.activePlayer.card2!);

        print(
          "CARD COUNT: ${game.deckManager.getDrawnCount()} out of ${game.deckManager.getDeckSize()}",
        );

        game.card1Val = game.activePlayer.card1!;
        game.guessCardVal = game.activePlayer.guessCard!;
        game.card2Val = game.activePlayer.card2!;

        game.card1.startFlip();
        game.card2.startFlip();

        game.gameTimer.reset();
        game.gameTimer.start();
      },
      autoStart: true,
    );
  }

  @override
  Future<void> onLoad() async {
    final overlayBackground = RectangleComponent(
      size: size,
      position: Vector2.zero(),
      priority: 19,
      paint: Paint()..color = Colors.black.withOpacity(0.6),
    );
    add(overlayBackground);

    textLabel = TextComponent(
      priority: 25,
      text: "Pot Empty",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2 - 100),
    );

    subLabel = TextComponent(
      priority: 25,
      text: "Collecting 100 pesos per player...",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2 - 60),
    );

    // final asset = Lottie.asset("assets/lottie/pot_empty.json");
    // final animation = await loadLottie(asset);
    // final lottie = LottieComponent(
    //   priority: 25,
    //   anchor: Anchor.center,
    //   animation,
    //   size: Vector2(200, 200),
    //   position: Vector2(size.x / 2, size.y / 2 + 20),
    //   repeating: true,
    //   duration: 1.5,
    //   fit: BoxFit.contain,
    // );

    potCollector = PotCollector(
      priority: 25,
      anchor: Anchor.center,
      size: Vector2(850, 450),
      position: Vector2(game.size.x / 2, game.size.y / 2),
      potValue: game.pot,
      playerNo: game.playerMaps.keys.length,
    );

    add(potCollector);
    add(textLabel);
    add(subLabel);
    //add(lottie);
    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
    _elapsedTime += dt;

    if (_elapsedTime >= 0.8 && !_threeSecondTriggered) {
      _threeSecondTriggered = true;
      _triggerPopEffect();
    }
  }

  void _triggerPopEffect() {
    final popEffect = ScaleEffect.to(
      Vector2.all(1.1),
      EffectController(
        duration: 0.05,
        alternate: true,
        curve: Curves.easeInOut,
      ),
      onComplete: () {
        _popCount++;
        if (_popCount < 3) {
          Future.delayed(const Duration(milliseconds: 100), _triggerPopEffect);
        }
      },
    );

    potCollector.potHolder.add(popEffect);
  }

  void _removeOverlay() {
    removeFromParent();
  }

  // void updatePotLabel(int newPotValue) {
  //   _potValue = "$newPotValue";
  //   subLabel.text = _potValue;
  // }
}
