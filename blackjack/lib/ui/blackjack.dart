import 'package:blackjack/bl/card.dart';
import 'package:blackjack/ui/background.dart';
import 'package:flutter/material.dart';
import 'package:blackjack/bl/gameMethods.dart';

class Blackjack extends StatefulWidget {
  @override
  _BlackjackState createState() => _BlackjackState();
}

class _BlackjackState extends State<Blackjack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        BlackjackBackground(),
        StatusBar(),
        DealerBox(),
        Align(
          alignment: Alignment(0, -0.42),
          child: Container(
            alignment: Alignment.center,
            width: 50,
            height: 35,
            color: Colors.white,
            child: Text(
              "20",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        MenuButtons(),
        PlayerControls(),
        PlayerBox(),
      ],
    );
  }
}

class StatusBar extends StatefulWidget {
  StatusBar({Key key}) : super(key: key);

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.95),
      child: Container(
        width: double.maxFinite,
        height: 24,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Cogratulations! You Win.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class DealerBox extends StatefulWidget {
  DealerBox({Key key}) : super(key: key);

  @override
  _DealerBoxState createState() => _DealerBoxState();
}

class _DealerBoxState extends State<DealerBox> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.8),
      child: Container(
        width: double.maxFinite,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.yellow,
          ),
        ),
        child: Stack(
          children: <Widget>[
            GameMethods.createCardImage(
                BlackjackCard(FaceValue.Four, Suit.Spades), 0),
            GameMethods.createCardImage(
                BlackjackCard(FaceValue.Six, Suit.Diamonds), 1),
            GameMethods.createCardImage(
                BlackjackCard(FaceValue.Seven, Suit.Clubs), 2),
            GameMethods.createCardImage(
                BlackjackCard(FaceValue.Three, Suit.Hearts), 3),
          ],
        ),
      ),
    );
  }
}

class MenuButtons extends StatefulWidget {
  MenuButtons({Key key}) : super(key: key);

  @override
  _MenuButtonsState createState() => _MenuButtonsState();
}

class _MenuButtonsState extends State<MenuButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonTheme(
          minWidth: 120,
          child: RaisedButton(
            child: Text("New Game"),
            onPressed: () {},
          ),
        ),
        ButtonTheme(
          minWidth: 120,
          child: RaisedButton(
            child: Text("Help"),
            onPressed: () {},
          ),
        ),
        ButtonTheme(
          minWidth: 120,
          child: RaisedButton(
            child: Text("Main Menu"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}

class PlayerControls extends StatefulWidget {
  @override
  _PlayerControlsState createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment(-0.75, 0.5),
            child: ButtonTheme(
              child: RaisedButton(
                child: Text("Hit"),
                onPressed: () {},
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: Container(
              height: 35,
              width: 50,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                "21",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.75, 0.5),
            child: ButtonTheme(
              child: RaisedButton(
                child: Text("Stand"),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerBox extends StatefulWidget {
  @override
  _PlayerBoxState createState() => _PlayerBoxState();
}

class _PlayerBoxState extends State<PlayerBox> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.9),
      child: Container(
        width: double.maxFinite,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.yellow,
          ),
        ),
        child: Stack(
          children: <Widget>[
            GameMethods.createCardImage(
                BlackjackCard(FaceValue.Ace, Suit.Clubs), 0),
            GameMethods.createCardImage(
                BlackjackCard(FaceValue.Ten, Suit.Hearts), 1),
          ],
        ),
      ),
    );
    ;
  }
}
