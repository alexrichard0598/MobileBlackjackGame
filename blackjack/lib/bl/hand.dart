import 'card.dart';

class Hand {
  List<BlackjackCard> _hand = List<BlackjackCard>();

  void add(BlackjackCard card) {
    _hand.add(card);
  }

  void sort() {
    _hand.sort((a, b) => a.value.index.compareTo(b.value.index));
  }

  bool contains(BlackjackCard cardToCheck) {
    return _hand
            .where((card) =>
                card.value == cardToCheck.value &&
                card.suit == cardToCheck.suit)
            .length >
        0;
  }
}
