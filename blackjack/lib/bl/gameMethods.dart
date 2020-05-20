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
}
