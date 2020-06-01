library blackjack.globals;

import 'package:blackjack/bl/deck.dart';
import 'package:blackjack/bl/hand.dart';
import 'package:blackjack/bl/profile.dart';

List<Profile> profiles = [];
int currentUserID = 1;
Hand playerHand = Hand();
Hand dealerHand = Hand();
Deck blackjackDeck = Deck();
bool playerHasStood = false;
bool dealerHasStood = false;
bool isHoleRevealed = false;
bool isGameOver = false;

String statusMsg = "";
