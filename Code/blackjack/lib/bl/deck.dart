import 'card.dart';
import 'dart:math';

class Deck {
  List<BlackjackCard> _deck = new List<BlackjackCard>();

  void createDeck() {
    for (Suit suit in Suit.values) {
      for (FaceValue value in FaceValue.values) {
        _deck.add(BlackjackCard(value, suit));
      }
    }
  }

  void createShoe(int numDecks) {
    for (var i = 0; i < numDecks; i++) {
      createDeck();
    }
  }

  void shuffleDeck(int numOfShuffles) {
    List<BlackjackCard> newDeck = new List<BlackjackCard>();
    var rng = new Random();

    while (_deck.length > 0) {
      int cardIndex = rng.nextInt(_deck.length);
      BlackjackCard cardRemoved = _deck[cardIndex];
      _deck.removeAt(cardIndex);
      newDeck.add(cardRemoved);
    }

    _deck = newDeck;
  }

  BlackjackCard drawCard() {
    BlackjackCard topCard;

    if (_deck.length > 0) {
      topCard = _deck[0];
      _deck.removeAt(0);

      return topCard;
    } else {
      throw ArgumentError("There are no cards in the deck - deal again.");
    }
  }

  void emptyDeck() {
    _deck.clear();
  }
}
