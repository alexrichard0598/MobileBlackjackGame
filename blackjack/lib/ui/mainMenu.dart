import 'package:blackjack/ui/background.dart';
import 'package:blackjack/ui/blackjack.dart';
import 'package:blackjack/ui/profilePicker.dart';
import 'package:blackjack/ui/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BlackjackBackground(),
          Align(
            alignment: Alignment(0, -0.8),
            child: Image.asset("assets/images/logo.png"),
          ),
          // #region Buttons
          Center(
            child: Wrap(
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Blackjack(),
                          ));
                    },
                    color: Colors.green,
                    child: Text("New Game"),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePicker(),
                        ),
                      );
                    },
                    color: Colors.orange,
                    child: Text("Change Profile"),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Stats(),
                        ),
                      );
                    },
                    color: Colors.yellow,
                    child: Text("Stats"),
                  ),
                ),
              ],
            ),
          ),
          // #endregion Buttons
        ],
      ),
    );
  }
}
