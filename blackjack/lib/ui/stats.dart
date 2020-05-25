import 'package:blackjack/ui/background.dart';
import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  var listLength = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BlackjackBackground(),
          Container(
            child: ListView.builder(
              itemCount: listLength,
              itemBuilder: (context, index) {
                if (index == listLength - 1) {
                  return Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Return"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                } else {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text("User$index"),
                        Wrap(
                          spacing: 10,
                          children: <Widget>[
                            Text("Wins: $index"),
                            Text("Losses: $index"),
                          ],
                        ),
                        Text("Player Blackjacks: $index"),
                        Text("Dealer Blackjacks: $index"),
                        Text("Average Player Hand: $index"),
                        Text("Average Dealer Hand: $index"),
                      ],
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
