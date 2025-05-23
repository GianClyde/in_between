import 'package:flame/components.dart';
import 'package:in_between_game/features/game/components/betting/better.dart';
import 'package:in_between_game/features/game/components/betting/betting_buttons_row.dart';
import 'package:in_between_game/features/game/components/betting/cards_equal_box.dart';
import 'package:in_between_game/features/game/components/helpers/deck_manager.dart';
import 'package:in_between_game/features/game/components/overlay/beginning_timer_overlay.dart';
import 'package:in_between_game/features/game/components/timers/game_timer.dart';
import 'package:in_between_game/features/game/managers/ui_manager.dart';
import 'package:in_between_game/features/game/models/card.dart';
import 'package:in_between_game/features/game/my_game.dart';

class GameFlowManager {
  final MyGame game;
  final UIManager uiManager;
  final DeckManager deckManager;
  GameFlowManager({
    required this.game,
    required this.uiManager,
    required this.deckManager,
  });

  // get gameFlowManager => null;

  Future<void> gameBegin() async {
    game.timerSprites = [];
    game.hasFolded = false;
    for (int i = 0; i <= 9; i++) {
      game.timerSprites.add(await game.loadSprite('numbers/$i.png'));
    }

    await game.images.loadAll(['cards/other_back_red.png']);

    _createGameTimer();
    _createStartCountdown();

    print("Active player: ${game.activePlayer.user.userName}");
    print("isTurn: ${game.activePlayer.turn}");

    await _creatBettingButtons();
  }

  Future<void> finishTurn() async {
    game.guessCard.startFlip();

    TimerComponent delayTimer = TimerComponent(
      period: 2.0,
      removeOnFinish: true,
      onTick: () async {
        if (game.gameTimer.hasEnded && !game.hasShownOverlay) {
          game.isWinner = game.gameFlowManager.checkResults(
            bet: game.playerSide,
          );
          print("Result: $game.isWinner");

          if (game.isWinner) {
            game.activePlayer.user.userWallet.balance +=
                (game.activePlayer.currentBet * 2);

            game.activePlayer.playerText.updateWalletBalance(
              (game.activePlayer.user.userWallet.balance).toInt(),
            );
            game.pot = game.pot - (game.activePlayer.currentBet * 2);
            game.potHolder.updateMoney(game.pot);
          }
        }

        print(
          "WALLET VALUE AFTER: ${game.activePlayer.user.userWallet.balance}",
        );
        await uiManager.createWinnerOverlay(hasFolded: game.hasFolded);
        game.hasShownOverlay = true;
        game.card1.resetFlip();
        game.guessCard.resetFlip();
        game.card2.resetFlip();
        game.hasBet = false;
        startIntervalTimer(5);
      },
    );

    game.add(delayTimer);
  }

  void startIntervalTimer(double period) {
    TimerComponent intervalTimer = TimerComponent(
      period: period,
      removeOnFinish: true,
      onTick: () async {
        if (game.pot == 0) {
          game.gameTimer.stop();
          print("ERROR: ZERO POT");

          game.playerMaps.forEach((key, player) {
            player.user.userWallet.balance -= 100;
            game.pot += 100;
            //game.emptyPotOverlay.updatePotLabel(game.pot);
            game.potHolder.updateMoney(game.pot);
          });
          uiManager.createEmptyPotOverlay();
        } else {
          game.hasShownOverlay = false;
          game.hasFolded = false;

          if (game.deckManager.getDeckSize() < 3) {
            print("CARD COUNT: EMPTY STOP");
            game.gameTimer.stop();
            await game.uiManager.createEmptyDeckOverlay();
          } else {
            await switchToNextPlayer();

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
            game.gameTimer.start();
          }
        }
      },
    );
    game.add(intervalTimer);
  }

  bool checkResults({required String bet}) {
    final String cardResult = compareGuessToRange(
      card1: game.card1Val,
      card2: game.card2Val,
      guessCard: game.guessCardVal,
    );
    print("card result: $cardResult bet: $bet");

    print("RESULTS: PLAYER SIDE: ${bet} - CARD RESULT: ${cardResult}");
    return bet == cardResult;
  }

  String compareGuessToRange({
    required Card card1,
    required Card card2,
    required Card guessCard,
  }) {
    final List<String> order = [
      'ace',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      'jack',
      'queen',
      'king',
    ];

    int val1 = order.indexOf(card1.value);
    int val2 = order.indexOf(card2.value);
    int guessVal = order.indexOf(guessCard.value);

    if (val1 == -1 || val2 == -1 || guessVal == -1) {
      throw ArgumentError('Invalid card value');
    }

    if (val1 == val2) {
      if (guessVal > val1) return 'higher';
      if (guessVal < val1) return 'lower';
      return 'equal';
    }

    int minVal = val1 < val2 ? val1 : val2;
    int maxVal = val1 > val2 ? val1 : val2;

    if (guessVal > minVal && guessVal < maxVal) {
      return 'in between';
    } else {
      return 'not in between';
    }
  }

  void fold() {
    print("HAS BET: fold called");
    game.card1.resetFlip();
    game.guessCard.resetFlip();
    game.card2.resetFlip();
    if (!game.hasShownOverlay) {
      game.gameTimer.stop();
      game.isWinner = false;
      game.hasBet = false;
      game.betterShown = false;
      uiManager.createWinnerOverlay(hasFolded: game.hasFolded).then((_) {
        game.hasShownOverlay = true;
        startIntervalTimer(5);
      });
    }
  }

  void timerEnded() {
    print("HAS BET: $game.hasBet");
    if (game.hasBet) {
      print("HAS BET: gameflow");
      finishTurn();
    } else {
      print("HAS BET: fold");
      game.hasFolded = true;
      fold();
    }
  }

  void beginningTimerEnded() {
    game.hasShownOverlay = false;
    game.gameTimer.start();
  }

  Future<void> switchToNextPlayer() async {
    game.activePlayer.setTurn(false);

    if (game.betterShown) {
      game.remove(game.better);
      game.betterShown = false;
      await _creatBettingButtons();
    }

    print(
      "PLAYER INDEX: ${game.playerMaps["player$game.currentPlayerIndex"]} currentplyrIndex: ${game.currentPlayerIndex} player list length: ${game.room.userList.length}",
    );
    game.currentPlayerIndex =
        ((game.currentPlayerIndex + 1) % game.room.userList.length);

    print("PLAYER INDEX: ${game.currentPlayerIndex}");
    game.activePlayer = game.playerMaps["player${game.currentPlayerIndex}"]!;

    final newCard1 = deckManager.drawCard();
    final newGuessCard = deckManager.drawCard();
    final newCard2 = deckManager.drawCard();

    if (newCard1 == null || newGuessCard == null || newCard2 == null) {
      print("One or more drawn cards are null. Skipping turn.");
      return;
    }

    game.activePlayer.card1 = newCard1;
    game.activePlayer.guessCard = newGuessCard;
    game.activePlayer.card2 = newCard2;

    game.activePlayer.gameCard1?.updateCard(newCard1);
    game.activePlayer.gameGuessCard?.updateCard(newGuessCard);
    game.activePlayer.gameCard2?.updateCard(newCard2);

    game.activePlayer.setTurn(true);
    game.gameTimer.reset();
  }

  Future<void> _createStartCountdown() async {
    game.hasShownOverlay = true;
    game.startingGameOverlayTimer = GameOverlayTimer(
      size: game.size,
      position: Vector2.zero(),
      priority: 12,
      backgroundSprite: SpriteComponent(
        sprite: await game.loadSprite('timer_bg.png'),
        size: Vector2(100, 100),
      ),
      sprites: game.timerSprites,
      gameFlowManager: game.gameFlowManager,
    );

    game.add(game.startingGameOverlayTimer);
  }

  Future<void> _createGameTimer() async {
    final background = SpriteComponent(
      sprite: await game.loadSprite('timer_bg.png'),
      size: Vector2(100, 100),
    );

    game.gameTimer = GameTimer(
      gameFlowManager: game.gameFlowManager,
      sprites: game.timerSprites,
      backgroundSprite: background,
      position: Vector2(game.size.x * 0.85, game.size.x * 0.02),
    );

    game.add(game.gameTimer);
  }

  void finishedBetting(int bet) {
    game.activePlayer.currentBet = bet;
    game.activePlayer.user.userWallet.balance -= game.activePlayer.currentBet;
    game.activePlayer.playerText.updateWalletBalance(
      game.activePlayer.user.userWallet.balance.toInt(),
    );

    game.hasBet = true;

    game.betterShown = false;
    game.remove(game.better);

    game.cardsEqual =
        game.activePlayer.card1?.value == game.activePlayer.card2?.value;
    print(
      "CARDSEQUAL: $game.ardsEqual || ACTIVE PLAYER: ${game.activePlayer.user.userName} || ACTIV PLAYER CARDS = AC1: ${game.activePlayer.card1?.value}  AGC: ${game.activePlayer.guessCard?.value}  AC2: ${game.activePlayer.card2?.value} ||  CARD VALUES = C1: ${game.card1Val.value} C2: ${game.card2Val.value}",
    );

    if (game.cardsEqual) {
      createCardEqualBox();
    } else {
      _creatBettingButtons();
    }

    game.pot += game.activePlayer.currentBet;
    game.potHolder.updateMoney(game.pot);

    game.gameTimer.stop();
    finishTurn();
  }

  Future<void> _createBetter() async {
    final betterBg = await game.loadSprite('better_bg.png');

    game.better = Better(
      sliderMaxValue:
          game.pot > game.activePlayer.user.userWallet.balance.toDouble()
              ? game.activePlayer.user.userWallet.balance
              : game.pot.toDouble(),
      size: Vector2(game.size.x * 0.45, game.size.x * 0.085),
      priority: 15,
      position: Vector2(game.size.x / 2 - 200, game.size.y / 2 + 125),
      sliderMinValue: 100,
      onMinBtnPressed: () {
        finishedBetting(100);
      },
      onHalfBtnPressed: () {
        finishedBetting(
          (game.activePlayer.user.userWallet.balance / 2).toInt(),
        );
      },
      onMaxBtnPressed: () {
        finishedBetting(
          game.activePlayer.user.userWallet.balance > game.pot
              ? game.pot
              : game.activePlayer.user.userWallet.balance.toInt(),
        );
      },
      bg: betterBg,
      onClosed: () async {
        game.remove(game.better);
        if (!(game.bettingButtonsRow.isMounted)) {
          await _creatBettingButtons();
        }

        game.betterShown = false;
      },
      onDealPressed: () {
        game.hasBet = true;

        game.activePlayer.currentBet = game.better.sliderValue;
        game.betterShown = false;
        if (game.better.isMounted) {
          game.remove(game.better);
        }

        game.cardsEqual =
            game.activePlayer.card1?.value == game.activePlayer.card2?.value;
        print(
          "CARDSEQUAL: $game.ardsEqual || ACTIVE PLAYER: ${game.activePlayer.user.userName} || ACTIV PLAYER CARDS = AC1: ${game.activePlayer.card1?.value}  AGC: ${game.activePlayer.guessCard?.value}  AC2: ${game.activePlayer.card2?.value} ||  CARD VALUES = C1: ${game.card1Val.value} C2: ${game.card2Val.value}",
        );

        if (game.cardsEqual) {
          createCardEqualBox();
        } else {
          _creatBettingButtons();
          game.activePlayer.user.userWallet.balance =
              game.activePlayer.user.userWallet.balance -
              game.activePlayer.currentBet;

          game.activePlayer.playerText.updateWalletBalance(
            (game.activePlayer.user.userWallet.balance).toInt(),
          );
          game.pot += game.activePlayer.currentBet;
          game.potHolder.updateMoney(game.pot);

          game.gameTimer.stop();
          finishTurn();

          print("BET VALUE: ${game.activePlayer.currentBet}");
          print("WALLET VALUE: ${game.activePlayer.user.userWallet.balance}");
        }
      },
    );

    if (!game.betterShown) {
      await game.add(game.better);
    } else {
      game.remove(game.better);
    }
  }

  Future<void> _creatBettingButtons() async {
    game.bettingButtonsRow = BettingButtonsRow(
      priority: 10,
      //scale: Vector2(0.1, 0.1),
      position: Vector2(game.size.x / 2 - 40, game.size.y / 2 + 150),
      allInPressed: () {
        if (game.hasShownOverlay) {
          print("HAS OVERLAYYYYYYYYYYYY");
          return;
        } else {
          //if (game.activePlayer.user.userWallet.balance >= game.pot) {
          game.activePlayer.currentBet =
              game.activePlayer.user.userWallet.balance >= game.pot
                  ? game.pot
                  : game.activePlayer.user.userWallet.balance.toInt();
          game.cardsEqual =
              game.activePlayer.card1?.value == game.activePlayer.card2?.value;
          print(
            "CARDSEQUAL: $game.ardsEqual || ACTIVE PLAYER: ${game.activePlayer.user.userName} || ACTIV PLAYER CARDS = AC1: ${game.activePlayer.card1?.value}  AGC: ${game.activePlayer.guessCard?.value}  AC2: ${game.activePlayer.card2?.value} ||  CARD VALUES = C1: ${game.card1Val.value} C2: ${game.card2Val.value}",
          );

          if (game.cardsEqual) {
            game.remove(game.bettingButtonsRow);
            game.activePlayer.user.userWallet.balance =
                game.activePlayer.user.userWallet.balance -
                game.activePlayer.currentBet;

            game.activePlayer.playerText.updateWalletBalance(
              (game.activePlayer.user.userWallet.balance).toInt(),
            );
            game.pot += game.activePlayer.currentBet;
            game.potHolder.updateMoney(game.pot);
            createCardEqualBox();
          } else {
            game.remove(game.bettingButtonsRow);
            _creatBettingButtons();
            game.activePlayer.user.userWallet.balance =
                game.activePlayer.user.userWallet.balance -
                game.activePlayer.currentBet;

            game.activePlayer.playerText.updateWalletBalance(
              (game.activePlayer.user.userWallet.balance).toInt(),
            );
            game.pot += game.activePlayer.currentBet;
            game.potHolder.updateMoney(game.pot);

            game.gameTimer.stop();
            finishTurn();
          }

          //} else {
          print("NOT ENOUGH MONEYYYYYYYYYYYYYYYYY");
          //  }
        }
        print("ALL INNNNNNNNNNNNN");
      },
      betPressed: () async {
        if (game.hasShownOverlay) {
          return;
        } else {
          if (game.bettingButtonsRow.isMounted) {
            game.remove(game.bettingButtonsRow);
          }
          await _createBetter();
        }
      },
      foldPressed: () {
        if (game.hasShownOverlay) {
          return;
        } else {
          game.hasFolded = true;
          fold();
        }
      },
    );

    game.add(game.bettingButtonsRow);
  }

  Future<void> createCardEqualBox() async {
    final betterBg = await game.loadSprite('better_bg.png');
    game.cardsEqualBox = CardsEqualBox(
      size: Vector2(390, 75),
      priority: 15,
      position: Vector2(game.size.x / 2 - 200, game.size.y / 2 + 130),
      bg: betterBg,
      onHigherPresed: () async {
        // game.activePlayer.user.userWallet.balance -= game.activePlayer.currentBet;
        // game.pot += game.activePlayer.currentBet;
        print("PLAYER MONEY: ${game.activePlayer.user.userWallet.balance}");
        game.playerSide = "higher";
        if (game.cardsEqualBox.isMounted) {
          game.gameTimer.stop();
          game.remove(game.cardsEqualBox);
          await _creatBettingButtons();
          finishTurn();
        }
      },
      onLowerPresed: () async {
        // game.activePlayer.user.userWallet.balance -= game.activePlayer.currentBet;
        // game.pot += game.activePlayer.currentBet;
        print("PLAYER MONEY: ${game.activePlayer.user.userWallet.balance}");
        game.playerSide = "lower";
        if (game.cardsEqualBox.isMounted) {
          game.remove(game.cardsEqualBox);
          await _creatBettingButtons();
          game.gameTimer.stop();
          game.cardsEqual = false;
          finishTurn();
        }
      },
    );

    if (game.cardsEqual) {
      game.add(game.cardsEqualBox);
    } else {
      if (game.cardsEqualBox.isMounted) {
        game.remove(game.cardsEqualBox);
      }
    }
  }
}
