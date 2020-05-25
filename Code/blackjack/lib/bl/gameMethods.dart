import 'package:blackjack/bl/hand.dart';
import 'package:blackjack/globals.dart';
import 'package:flutter/material.dart';
import 'card.dart';

class GameMethods {
  static Align createCardImage(BlackjackCard card, int cardNum) {
    double x = -0.96 + 0.08 * cardNum;
    double y = 0;
    Alignment alignment = Alignment(x, y);
    String imagePath = "assets/images/${card.value.name}${card.suit.name}.jpg";
    return Align(
      alignment: alignment,
      child: Image.asset(
        imagePath,
        width: 80,
      ),
    );
  }

  static Hand sortHand(Hand hand) {
    Hand sorted = hand;
    sorted.sort();
    sorted.reverse();
    return sorted;
  }

  static int calculateHandValue(Hand hand) {
    int handValue = 0;
    List<BlackjackCard> sortedHand = sortHand(hand).getHand();

    for (var i = 0; i < sortedHand.length; i++) {
      int cardValue;
      switch (sortedHand[i].value) {
        case FaceValue.Ace:
          if (i != sortedHand.length - 1 || 11 + handValue > 21) {
            cardValue = 1;
          } else {
            cardValue = 11;
          }
          break;
        case FaceValue.King:
        case FaceValue.Queen:
        case FaceValue.Jack:
          cardValue = 10;
          break;
        default:
          cardValue = sortedHand[i].value.index + 1;
          break;
      }
      handValue += cardValue;
    }
    return handValue;
  }

  static List<Widget> displayPlayerHand(Hand hand) {
    List<Widget> cards = new List<Widget>();
    List<BlackjackCard> handList = hand.getHand();

    for (var i = 0; i < handList.length; i++) {
      cards.add(createCardImage(handList[i], i));
    }

    return cards;
  }

  static void resetGameGlobals() {
    playerHand.clear();
    dealerHand.clear();
    blackjackDeck.emptyDeck();
  }

  static void startGame() {
    resetGameGlobals();
    blackjackDeck.createShoe(4);
    blackjackDeck.shuffleDeck(7);
    playerHand.add(blackjackDeck.drawCard());
    playerHand.add(blackjackDeck.drawCard());
  }
}
