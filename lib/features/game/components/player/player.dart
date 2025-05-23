import 'dart:async';
import 'package:flame/components.dart';

import 'package:in_between_game/features/game/components/cards/game_card.dart';
import 'package:in_between_game/features/game/components/player/player_text.dart';
import 'package:in_between_game/features/game/components/player/player_turn_arrow.dart';
import 'package:in_between_game/features/game/models/card.dart' as game_card;
import 'package:in_between_game/features/game/models/user.dart';

import 'package:in_between_game/features/game/my_game.dart';

class Player extends PositionComponent with HasGameReference<MyGame> {
  final User user;
  game_card.Card? card1;
  game_card.Card? card2;
  game_card.Card? guessCard;

  final double textAngle;
  final int playerIndex;

  late GameCard? gameCard1;
  late GameCard? gameCard2;
  late GameCard? gameGuessCard;

  late PlayerText playerText;

  bool turn = false;
  late PlayerTurnArrow playerTurnArrow;

  late String frontImagePath;

  late int currentBet;
  late double playerWinnings;
  Player({
    required this.textAngle,
    required this.playerIndex,
    required this.user,
    super.size,
    super.children,
    super.position,
    super.angle,
    super.key,
    required this.card1,
    required this.card2,
    required this.guessCard,
  }) : super(priority: 1) {
    currentBet = 0;
    playerWinnings = 0;
  }
  @override
  FutureOr<void> onLoad() async {
    playerTurnArrow = PlayerTurnArrow(playerIndex: playerIndex);
    frontImagePath = 'cards/clubs_2.png';

    playerText = PlayerText(
      user: user,
      angle: textAngle,
      position: _calculatePlayerTextPosition(playerIndex),
      walletBalanceVal: user.userWallet.balance.toInt(),
    );

    add(playerText);

    gameCard1 =
        card1 != null
            ? GameCard(
              size: Vector2(28, 40),
              //scale: Vector2(0.5, 0.5),
              position: Vector2(size.x, size.y),
              card: card1!,
            )
            : null;

    gameGuessCard =
        guessCard != null
            ? GameCard(
              size: Vector2(28, 40),
              //scale: Vector2(0.5, 0.5),
              position: Vector2(size.x + 30, size.y),
              card: guessCard!,
            )
            : null;

    gameCard2 =
        card2 != null
            ? GameCard(
              size: Vector2(28, 40),
              //scale: Vector2(0.5, 0.5),
              position: Vector2(size.x + 60, size.y),
              card: card2!,
            )
            : null;

    add(gameCard1!);
    add(gameGuessCard!);
    add(gameCard2!);
    return super.onLoad();
  }

  void setTurn(bool isActive) async {
    turn = isActive;

    if (isActive) {
      if (!children.contains(playerTurnArrow)) {
        playerTurnArrow = PlayerTurnArrow(
          size: Vector2(200, 200),
          position: Vector2(size.x / 2, size.y / 2),
          playerIndex: playerIndex,
        );
        await add(playerTurnArrow);
      }
      playerTurnArrow.show();
    } else {
      playerTurnArrow.removeFromParent();
    }
  }

  // void updateCurrentBet({required int amount}) {
  //   currentBet = amount;
  // }

  void updatePlayerWinnings({required double newWinnings}) {
    playerWinnings = newWinnings;
  }

  Vector2 _calculatePlayerTextPosition(int index) {
    if (index == 2) {
      return Vector2(size.x / 2 + 30, size.y / 2 - 70);
    }
    if (index == 3 || index == 4) {
      return Vector2(size.x / 2 + 85, size.y / 2 - 30);
    }
    if (index == 5) {
      return Vector2(size.x / 2 + 60, size.y / 2 + 10);
    }
    return Vector2(size.x / 2, size.y / 2);
  }
}
