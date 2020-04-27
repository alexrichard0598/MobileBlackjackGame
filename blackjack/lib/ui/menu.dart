import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child: Image.asset("assets/images/background.jpg"),
          ),
          Center(
            child: Wrap(
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text(
                      "New Game",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    onPressed: null,
                    child: Text("New Game"),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    onPressed: null,
                    child: Text("New Game"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
