import 'package:blackjack/bl/hand.dart';
import 'package:blackjack/globals.dart';
import 'package:flutter/material.dart';
import 'card.dart';

class GameMethods {
  static Align createCardImage(BlackjackCard card, int cardNum,
      {bool isShoe = false}) {
    double x = -0.96 + 0.08 * cardNum;
    double y = 0;
    Alignment alignment = Alignment(x, y);
    String imagePath = "assets/images/${card.value.name}${card.suit.name}.jpg";
    if (isShoe) imagePath = "assets/images/cardback.gif";
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

  static int calculateHandValue(Hand hand, bool isDealerHand) {
    int handValue = 0;
    Hand srtHand = Hand();

    if (isDealerHand) {
      if (isShoeRevealed) {
        srtHand = dealerHand;
      } else {
        List<BlackjackCard> dealerHandList = dealerHand.getHand();
        for (var i = 0; i < dealerHandList.length; i++) {
          if (i != 0) srtHand.add(dealerHandList[i]);
        }
      }
    } else {
      for (BlackjackCard card in hand.getHand()) {
        srtHand.add(card);
      }
    }

    srtHand.sort();
    List<BlackjackCard> sortedHand = srtHand.getHand();

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

  static List<Widget> displayPlayerHand() {
    List<Widget> cards = new List<Widget>();
    List<BlackjackCard> handList = playerHand.getHand();

    for (var i = 0; i < handList.length; i++) {
      cards.add(createCardImage(handList[i], i));
    }

    return cards;
  }

  static List<Widget> displayDealerHand() {
    List<Widget> cards = new List<Widget>();
    List<BlackjackCard> handList = dealerHand.getHand();

    for (var i = 0; i < handList.length; i++) {
      cards.add(createCardImage(handList[i], i, isShoe: i == 0));
    }

    return cards;
  }

  static void hit(Hand hand) {
    hand.add(blackjackDeck.drawCard());
    checkGameState();
  }

  static void checkGameState() {
    int plrValue = calculateHandValue(playerHand, false);
    int dlrValue = calculateHandValue(dealerHand, true);
    if (plrValue > 21) {}
    if (dlrValue > 21) {}
    if (hasPlayerStood && dlrValue >= plrValue) {}
    if (hasDealerStood && dlrValue < plrValue) {}
  }

  static void resetGameGlobals() {
    playerHand.clear();
    dealerHand.clear();
    blackjackDeck.emptyDeck();
    hasPlayerStood = false;
    hasDealerStood = false;
    isShoeRevealed = false;
  }

  static void startGame() {
    resetGameGlobals();
    blackjackDeck.createShoe(4);
    blackjackDeck.shuffleDeck(7);
    playerHand.add(blackjackDeck.drawCard());
    playerHand.add(blackjackDeck.drawCard());
  }
}
