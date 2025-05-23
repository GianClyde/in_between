import 'package:flame/components.dart';
import 'package:flame/timer.dart';
import 'package:flutter/material.dart';
import 'package:in_between_game/features/game/my_game.dart';

class EmptyDeckOverlay extends PositionComponent with HasGameReference<MyGame> {
  late TextComponent textLabel;
  late TextComponent potLabel;

  String _potValue = "0";
  late Timer _timer;

  EmptyDeckOverlay({super.position, super.size, super.priority}) {
    _timer = Timer(
      5.0,
      onTick: () async {
        game.deckManager.resetDeck();
        print(
          "CARD COUNT: ${game.deckManager.getDrawnCount()} out of ${game.deckManager.getDeckSize()}",
        );

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
        // activePlayer.gameCard1!.startFlip();
        // activePlayer.gameCard2!.startFlip();
        game.gameTimer.reset();
        game.gameTimer.start();
      },
      autoStart: true,
    );
  }

  @override
  Future<void> onLoad() async {
    game.hasShownOverlay = true;
    final overlayBackground = RectangleComponent(
      size: size,
      position: Vector2.zero(),
      priority: 19,
      paint: Paint()..color = Colors.black.withOpacity(0.6),
    );
    add(overlayBackground);

    textLabel = TextComponent(
      text: "Round Over",
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

    add(textLabel);

    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }

  void _removeOverlay() {
    removeFromParent();
  }

  void updatePotLabel(int newPotValue) {
    _potValue = "$newPotValue";
    potLabel.text = _potValue;
  }
}
