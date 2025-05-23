import 'package:flame/components.dart';
import 'package:in_between_game/features/game/components/cards/card_holder.dart';
import 'package:in_between_game/features/game/components/cards/game_card.dart';
import 'package:in_between_game/features/game/components/holders/money_holder.dart';
import 'package:in_between_game/features/game/components/overlay/empty_deck_overlay.dart';
import 'package:in_between_game/features/game/components/overlay/empty_pot_overlay.dart';
import 'package:in_between_game/features/game/components/overlay/header_text.dart';
import 'package:in_between_game/features/game/components/overlay/win_overlay.dart';
import 'package:in_between_game/features/game/components/static/table.dart';

import 'package:in_between_game/features/game/my_game.dart';

class UIManager {
  final MyGame game;
  UIManager({required this.game});

  Future<void> loadUI() async {
    await _createBackground();
    _createTable();
    await _createPotHolder();
    await _createMoneyHolder();
  }

  Future<void> loadUserDependentUI() async {
    await _createHeaderText();
    await _createZoomedCards();
    await _createZoomedCardHolders();
  }

  Future<void> createEmptyPotOverlay() async {
    final existing = game.children.whereType<WinOverlay>().toList();
    for (final overlay in existing) {
      overlay.removeFromParent();
    }

    game.emptyPotOverlay = EmptyPotOverlay(
      potValue: game.pot,
      size: game.size,
      position: Vector2.zero(),
      priority: 20,
    );

    game.add(game.emptyPotOverlay);
  }

  Future<void> createEmptyDeckOverlay() async {
    final existing = game.children.whereType<WinOverlay>().toList();
    for (final overlay in existing) {
      overlay.removeFromParent();
    }
    game.emptyDeckOverlay = EmptyDeckOverlay(
      size: game.size,
      position: Vector2.zero(),
      priority: 20,
    );

    game.add(game.emptyDeckOverlay);
  }

  Future<void> createWinnerOverlay({
    bool hasFolded = false,
    bool deckEmpty = false,
  }) async {
    final existing = game.children.whereType<WinOverlay>().toList();
    for (final overlay in existing) {
      overlay.removeFromParent();
    }

    final winOverlay = WinOverlay(
      size: game.size,
      position: Vector2.zero(),
      priority: 20,
      isWinner: game.isWinner,
      hasFolded: hasFolded,
    );

    game.add(winOverlay);
  }

  Future<void> _createHeaderText() async {
    game.headerText = HeaderText(
      userName: game.activePlayer.user.userName,
      position: Vector2((game.size.x / 2) - 50, 30),
    );
    game.add(game.headerText);
  }

  Future<void> _createZoomedCards() async {
    game.card1 = GameCard(
      size: Vector2(70, 90),
      card: game.activePlayer.card1!,
    );
    game.guessCard = GameCard(
      size: Vector2(70, 90),
      card: game.activePlayer.guessCard!,
    );
    game.card2 = GameCard(
      size: Vector2(70, 90),
      card: game.activePlayer.card2!,
    );

    game.card1.onFlip = () => game.activePlayer.gameCard1?.startFlip();
    game.guessCard.onFlip = () => game.activePlayer.gameGuessCard?.startFlip();
    game.card2.onFlip = () => game.activePlayer.gameCard2?.startFlip();

    game.card1.onResetFlip = () => game.activePlayer.gameCard1?.resetFlip();
    game.guessCard.onResetFlip =
        () => game.activePlayer.gameGuessCard?.resetFlip();
    game.card2.onResetFlip = () => game.activePlayer.gameCard2?.resetFlip();

    game.card1.onUpdateCard =
        (newCard) async => game.activePlayer.gameCard1?.updateCard(newCard);
    game.guessCard.onUpdateCard =
        (newCard) async => game.activePlayer.gameGuessCard?.updateCard(newCard);
    game.card2.onUpdateCard =
        (newCard) async => game.activePlayer.gameCard2?.updateCard(newCard);
  }

  Future<void> _createZoomedCardHolders() async {
    game.shadowSprite = await game.loadSprite('cards/card_shadow.png');
    game.guessSprite = await game.loadSprite('cards/question_card.png');

    final yPosition = game.size.x / 2 * 0.09;

    game.cardHolder1 = CardHolder(
      holderSprite: game.shadowSprite,
      position: Vector2(yPosition, (game.size.y * 0.1 - 20)),
      size: Vector2(105, 120),
      generatedGameCard: game.card1,
    );

    game.guessCardHolder = CardHolder(
      holderSprite: game.guessSprite,
      position: Vector2(yPosition, (game.size.y * 0.1 - 20) + 95 + 10),
      size: Vector2(105, 120),
      generatedGameCard: game.guessCard,
      isGuessCard: true,
    );

    game.cardHolder2 = CardHolder(
      holderSprite: game.shadowSprite,
      position: Vector2(yPosition, (game.size.y * 0.1 - 20) + 190 + 10 + 10),
      size: Vector2(105, 120),
      generatedGameCard: game.card2,
    );

    game.add(game.cardHolder1);
    game.add(game.guessCardHolder);
    game.add(game.cardHolder2);
  }

  Future<void> _createMoneyHolder() async {
    final moneyHolderSprite = await game.loadSprite(
      'holders/amount_holder.png',
    );
    final yPosition = game.size.x / 2 * 0.005;

    game.moneyHolder = MoneyHolder(
      fontSize: 18,
      bg: moneyHolderSprite,
      position: Vector2(yPosition, game.size.y / 2 + 120),
      size: Vector2(game.size.x / 2 * 0.4, game.size.x / 2 * 0.2),
    );

    game.add(game.moneyHolder);
  }

  Future<void> _createPotHolder() async {
    final potHolderSprite = await game.loadSprite('holders/pot_bg.png');
    game.potHolder = MoneyHolder(
      priority: 10,
      fontSize: 12,
      bg: potHolderSprite,
      position: Vector2(game.size.x / 2 - 70, game.size.y / 2 - 35),
      size: Vector2(130, 60),
    );

    game.add(game.potHolder);
  }

  void _createTable() {
    game.table = Table(position: Vector2(game.size.x / 2, game.size.y / 2));
    game.add(game.table);
  }

  Future<void> _createBackground() async {
    final backgroundSprite = await game.loadSprite('background.png');
    final background = SpriteComponent(
      sprite: backgroundSprite,
      size: game.size,
      priority: -1,
    );
    await game.add(background);
  }
}
