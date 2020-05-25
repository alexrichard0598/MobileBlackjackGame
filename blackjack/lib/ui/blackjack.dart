import 'package:blackjack/bl/card.dart';
import 'package:blackjack/globals.dart';
import 'package:blackjack/ui/background.dart';
import 'package:flutter/material.dart';
import 'package:blackjack/bl/gameMethods.dart';

class UIUpdater {
  final void Function() updateUi;
  UIUpdater({this.updateUi});
}

UIUpdater uiUpdate;

class Blackjack extends StatefulWidget {
  @override
  _BlackjackState createState() => _BlackjackState();
}

class _BlackjackState extends State<Blackjack> {
  void updateUI() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    //Initialize the game
    GameMethods.startGame();

    //bind the set state of this widget to uiUpdate
    uiUpdate = UIUpdater(updateUi: updateUI);
  }

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
  MenuButtons({
    Key key,
  }) : super(key: key);

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
            onPressed: () {
              GameMethods.startGame();
              uiUpdate.updateUi();
            },
          ),
        ),
        ButtonTheme(
          minWidth: 120,
          child: RaisedButton(
            child: Text("Help"),
            onPressed: _showHelp,
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

  Future<void> _showHelp() async {
    String helpText = "The goal of Blackjack is to get as close to 21 without going over. " +
        "The player is dealt two cards, and then the dealer deals themselves two " +
        "cards, one face down, which is called the hole, and the other face up.\r\n\r\n" +
        "The scoring for Blackjack is as follows:\r\n" +
        "\u2022 Numbered cards are worth the amount on the card\r\n" +
        "\u2022 Kings, Queens and Jacks are worth 10\r\n" +
        "\u2022 Aces are worth 11 or 1 if 11 would put the player over 21\r\n\r\n" +
        "The player as two options, Hit or Stand. If you choose hit, the dealer deals " +
        "you another card. If you choose stand you end your turn and are not allowed any " +
        "more cards. After you stand the dealer will deal any additional cards to " +
        "themselves until they beat the player or reach 17, unless it is a Soft Seventeen " +
        "(a seventeen in which one of the cards is an Ace valued at 11)." +
        "\r\n\r\n This varient of Blackjack uses three decks and the " +
        "dealer wins all ties except when the player has Blackjack.";
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Help"),
            content: SingleChildScrollView(child: Text(helpText)),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}

class PlayerControls extends StatefulWidget {
  PlayerControls({Key key}) : super(key: key);

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
                GameMethods.calculateHandValue(playerHand).toString(),
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
  PlayerBox({Key key}) : super(key: key);

  @override
  _PlayerBoxState createState() => _PlayerBoxState();
}

class _PlayerBoxState extends State<PlayerBox> {
  List<Widget> children = List<Widget>();

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
          children: GameMethods.displayPlayerHand(playerHand),
        ),
      ),
    );
  }
}
