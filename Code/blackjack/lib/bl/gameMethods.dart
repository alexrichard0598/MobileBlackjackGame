import 'dart:async';

import 'package:blackjack/bl/hand.dart';
import 'package:blackjack/bl/profile.dart';
import 'package:blackjack/globals.dart';
import 'package:blackjack/main.dart';
import 'package:flutter/material.dart';
import 'package:blackjack/bl/card.dart';

class GameMethods {
  Function updateUI;
  Profile _currentProfile;

  GameMethods(uiUpdater) {
    updateUI = uiUpdater;
  }

  Align createCardImage(BlackjackCard card, int cardNum,
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

  Hand sortHand(Hand hand) {
    Hand sorted = hand;
    sorted.sort();
    sorted.reverse();
    return sorted;
  }

  int calculateHandValue(Hand hand, bool isDealerHand) {
    int handValue = 0;
    Hand srtHand = Hand();

    if (isDealerHand) {
      if (isHoleRevealed) {
        for (BlackjackCard card in hand.getHand()) {
          srtHand.add(card);
        }
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

  List<Widget> displayPlayerHand() {
    List<Widget> cards = new List<Widget>();
    List<BlackjackCard> handList = playerHand.getHand();

    for (var i = 0; i < handList.length; i++) {
      cards.add(createCardImage(handList[i], i));
    }

    return cards;
  }

  List<Widget> displayDealerHand() {
    List<Widget> cards = new List<Widget>();
    List<BlackjackCard> handList = dealerHand.getHand();

    for (var i = 0; i < handList.length; i++) {
      cards.add(
          createCardImage(handList[i], i, isShoe: (i == 0 && !isHoleRevealed)));
    }

    return cards;
  }

  void hit(Hand hand) {
    hand.add(blackjackDeck.drawCard());
    updateUI();
  }

  void checkGameState() {
    int plrValue = calculateHandValue(playerHand, false);
    int dlrValue = calculateHandValue(dealerHand, true);
    if (plrValue == 21) {
      playerWon();
    } else if (plrValue > 21 || dlrValue == 21) {
      playerLost();
    } else if (playerHasStood && dlrValue > 21) {
      dealerHasStood = true;
      playerWon();
    } else if (playerHasStood && dlrValue >= plrValue) {
      dealerHasStood = true;
      playerLost();
    } else if (dealerHasStood && dlrValue < plrValue) {
      playerWon();
    } else if (playerHasStood && (dlrValue > plrValue || dlrValue >= 17)) {
      dealerHasStood = true;
      checkGameState();
    } else if (playerHasStood && dlrValue < plrValue) {
      hit(dealerHand);
    }
  }

  playerLost() {
    statusMsg = "You loose!";
    isHoleRevealed = true;
    updateUI();
    endGame(false);
  }

  playerWon() {
    statusMsg = "Congratulations! You Win!";
    isHoleRevealed = true;
    updateUI();
    endGame(true);
  }

  endGame(bool playerWon) async {
    int plrValue = calculateHandValue(playerHand, false);
    int dlrValue = calculateHandValue(dealerHand, true);
    isGameOver = true;
    await _getCurrentProfile();
    Profile profileUpdate = Profile(
        id: _currentProfile.id,
        name: _currentProfile.name,
        wins: playerWon ? _currentProfile.wins + 1 : _currentProfile.wins,
        losses: playerWon ? _currentProfile.losses : _currentProfile.losses + 1,
        playerBlackjacks: plrValue == 21
            ? _currentProfile.playerBlackjacks + 1
            : _currentProfile.playerBlackjacks,
        dealerBlackjacks: dlrValue == 21
            ? _currentProfile.dealerBlackjacks + 1
            : _currentProfile.dealerBlackjacks,
        totalPlayerHand: _currentProfile.totalPlayerHand + plrValue,
        totalDealerHand: _currentProfile.totalDealerHand + dlrValue,
        totalGames: _currentProfile.totalGames + 1);

    dbHelper.update(profileUpdate);
  }

  void resetGameGlobals() {
    playerHand.clear();
    dealerHand.clear();
    blackjackDeck.emptyDeck();
    playerHasStood = false;
    dealerHasStood = false;
    isHoleRevealed = false;
    statusMsg = "";
    isGameOver = false;
  }

  void startGame() {
    resetGameGlobals();

    //Setup the deck
    blackjackDeck.createShoe(4);
    blackjackDeck.shuffleDeck(7);

    //Deal the player cards
    playerHand.add(blackjackDeck.drawCard());
    playerHand.add(blackjackDeck.drawCard());

    //Deal the dealer cards
    dealerHand.add(blackjackDeck.drawCard());
    dealerHand.add(blackjackDeck.drawCard());

    checkGameState();
  }

  void stand() {
    playerHasStood = true;
    isHoleRevealed = true;
    updateUI();

    Timer.periodic(Duration(seconds: 1), (t) {
      checkGameState();
      updateUI();
      if (dealerHasStood) t.cancel();
    });
  }

  _getCurrentProfile() async {
    final currentUserRow = await dbHelper.queryByID(currentUserID);
    _currentProfile = Profile.fromMap(currentUserRow.first);
  }
}
