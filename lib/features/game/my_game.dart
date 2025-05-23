import 'dart:async';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:in_between_game/features/game/components/betting/better.dart';
import 'package:in_between_game/features/game/components/betting/betting_buttons_row.dart';
import 'package:in_between_game/features/game/components/betting/cards_equal_box.dart';
import 'package:in_between_game/features/game/components/cards/card_holder.dart';
import 'package:in_between_game/features/game/components/cards/game_card.dart';
import 'package:in_between_game/features/game/components/helpers/deck_manager.dart';
import 'package:in_between_game/features/game/components/holders/money_holder.dart';
import 'package:in_between_game/features/game/components/overlay/beginning_timer_overlay.dart';
import 'package:in_between_game/features/game/components/overlay/empty_deck_overlay.dart';
import 'package:in_between_game/features/game/components/overlay/empty_pot_overlay.dart';
import 'package:in_between_game/features/game/components/overlay/header_text.dart';
import 'package:in_between_game/features/game/components/player/player.dart';
import 'package:in_between_game/features/game/components/static/table.dart';
import 'package:in_between_game/features/game/components/timers/game_timer.dart';
import 'package:in_between_game/features/game/managers/game_flow_manager.dart';
import 'package:in_between_game/features/game/managers/player_manager.dart';
import 'package:in_between_game/features/game/managers/ui_manager.dart';
import 'package:in_between_game/features/game/models/card.dart';
import 'package:in_between_game/features/game/models/room.dart';

class MyGame extends FlameGame {
  late UIManager uiManager;
  late PlayerManager playerManager;
  late GameFlowManager gameFlowManager;

  // Core game components
  late Table table;
  late HeaderText headerText;
  late GameTimer gameTimer;
  late MoneyHolder moneyHolder;

  // Card holders and zoomed cards
  late CardHolder cardHolder1, guessCardHolder, cardHolder2;
  late GameCard card1, guessCard, card2;
  late Sprite shadowSprite, guessSprite;

  //Card Values for Logic purposes
  late Card card1Val;
  late Card guessCardVal;
  late Card card2Val;

  // Player-related properties
  late Map<String, Player> playerMaps;
  final Room room;

  late Player activePlayer;
  int currentPlayerIndex = 0;
  late final Images images;

  late List<Sprite> timerSprites;

  //beginning overlay
  late GameOverlayTimer startingGameOverlayTimer;
  late EmptyPotOverlay emptyPotOverlay;
  late EmptyDeckOverlay emptyDeckOverlay;
  //deck manager related
  late DeckManager deckManager;
  late Card playerCard1;
  late Card playerGuessCard;
  late Card playerCard2;

  // Predefined table positions for players
  late List<Vector2> tableCoordinates;
  //OG coordinates
  // final List<Vector2> tableCoordinates = [
  //   Vector2(320, 260),
  //   Vector2(530, 260),
  //   Vector2(670, 245),
  //   Vector2(620, 140),
  //   Vector2(410, 140),
  //   Vector2(275, 160),
  // ];

  //buttons row for betting
  late BettingButtonsRow bettingButtonsRow;
  late bool hasFolded;

  // Result tracking
  late String cardResult;
  late bool isWinner;
  bool hasShownOverlay = false;

  bool betterShown = false;
  bool cardsEqual = false;

  //Better
  late Better better;

  //pot
  int pot = 0;
  late MoneyHolder potHolder;

  late CardsEqualBox cardsEqualBox;

  String playerSide = "in between";

  MyGame({super.children, super.world, super.camera, required this.room});

  bool hasBet = false;

  @override
  Future<void> onLoad() async {
    tableCoordinates = [
      Vector2(320, 260),
      Vector2(530, 260),
      Vector2(670, 245),
      Vector2(620, 140),
      Vector2(410, 140),
      Vector2(275, 160),
    ];
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    images = Images();

    isWinner = false;

    deckManager = DeckManager();
    await deckManager.load();

    uiManager = UIManager(game: this);
    await uiManager.loadUI();

    playerManager = PlayerManager(game: this);
    playerManager.initializePlayers();

    print("PLAYERS: ${playerMaps.keys}");
    await uiManager.loadUserDependentUI();

    gameFlowManager = GameFlowManager(
      game: this,
      uiManager: uiManager,
      deckManager: deckManager,
    );

    gameFlowManager.gameBegin();
  }
}
