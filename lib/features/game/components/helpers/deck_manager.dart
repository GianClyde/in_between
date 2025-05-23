import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:in_between_game/features/game/models/card.dart';

class DeckManager {
  bool deckEmpty = false;
  final List<Card> _deck = [];
  final List<String> suits = ['clubs', 'diamonds', 'hearts', 'spades'];
  final List<String> values = [
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

  bool _isLoaded = false;
  int _totalCards = 0;

  Future<void> load() async {
    if (_isLoaded) return;

    for (final suit in suits) {
      for (final value in values) {
        final path = 'cards/${suit}_$value.png';
        final front = Sprite(await Flame.images.load(path));
        final back = Sprite(
          await Flame.images.load('cards/other_back_red.png'),
        );

        _deck.add(Card(front: front, back: back, suit: suit, value: value));
      }
    }

    _deck.shuffle(Random());
    _totalCards = _deck.length;
    _isLoaded = true;
  }

  Card? drawCard() {
    if (_deck.isEmpty) {
      return null;
    }
    return _deck.removeLast();
  }

  void resetDeck() async {
    _deck.clear();
    _isLoaded = false;
    deckEmpty = false;
    await load();
    if (_deck.isEmpty) {
      print("CARD COUNT: ERROR: Deck failed to reset properly.");
    } else {
      print("CARD COUNT: Deck reset successfully. Card count: ${_deck.length}");
    }
  }

  int getDrawnCount() {
    return _totalCards - _deck.length;
  }

  int getDeckSize() {
    return _deck.length;
  }

  int get remainingCards => _deck.length;

  Future<Card?> getFourOfSpades() async {
    if (!_isLoaded) {
      await load();
    }

    for (final card in _deck) {
      if (card.suit == 'spades' && card.value == '4') {
        return card;
      }
    }

    final front = Sprite(await Flame.images.load('cards/spades_4.png'));
    final back = Sprite(await Flame.images.load('cards/other_back_red.png'));
    return Card(front: front, back: back, suit: 'spades', value: '4');
  }

  Future<Card?> getAceOfSpades() async {
    if (!_isLoaded) {
      await load();
    }

    for (final card in _deck) {
      if (card.suit == 'spades' && card.value == 'ace') {
        return card;
      }
    }

    final front = Sprite(await Flame.images.load('cards/spades_ace.png'));
    final back = Sprite(await Flame.images.load('cards/other_back_red.png'));
    return Card(front: front, back: back, suit: 'spades', value: 'ace');
  }
}
