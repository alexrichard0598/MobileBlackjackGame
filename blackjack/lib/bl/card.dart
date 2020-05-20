enum FaceValue {
  Ace,
  One,
  Two,
  Three,
  Four,
  Five,
  Six,
  Seven,
  Eight,
  Nine,
  Ten,
  Jack,
  Queen,
  King
}

extension FaceValueExtension on FaceValue {
  String get name {
    return this.toString().substring(this.toString().indexOf(".") + 1);
  }
}

enum Suit { Clubs, Diamonds, Hearts, Spades }

extension SuitExtension on Suit {
  String get name {
    return this.toString().substring(this.toString().indexOf(".") + 1);
  }
}

class BlackjackCard {
  FaceValue value;
  Suit suit;

  BlackjackCard(this.value, this.suit);
}
