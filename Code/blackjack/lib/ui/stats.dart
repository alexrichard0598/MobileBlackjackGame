import 'package:blackjack/bl/profile.dart';
import 'package:blackjack/globals.dart';
import 'package:blackjack/main.dart';
import 'package:blackjack/ui/background.dart';
import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List<Profile> profiles = [];
  String currentProfileName;

  @override
  void initState() {
    super.initState();
    _queryAll();
  }

  @override
  Widget build(BuildContext context) {
    _queryCurrentName();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BlackjackBackground(),
          Container(
            child: ListView.builder(
              itemCount: profiles.length + 1,
              itemBuilder: (context, index) {
                if (index == profiles.length) {
                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Return"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      RaisedButton(
                        child: Text("Refresh"),
                        onPressed: () {
                          _queryAll();
                        },
                      )
                    ],
                  );
                } else {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${profiles[index].name}",
                            style: TextStyle(
                                fontWeight:
                                    profiles[index].name == currentProfileName
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                          ),
                          Wrap(
                            spacing: 10,
                            children: <Widget>[
                              Text("Wins: ${profiles[index].wins}"),
                              Text("Losses: ${profiles[index].losses}"),
                            ],
                          ),
                          Text(
                              "Player Blackjacks: ${profiles[index].playerBlackjacks}"),
                          Text(
                              "Dealer Blackjacks: ${profiles[index].dealerBlackjacks}"),
                          Text(
                              "Average Player Hand: ${profiles[index].totalGames == 0 ? 0 : profiles[index].totalPlayerHand / profiles[index].totalGames}"),
                          Text(
                              "Average Dealer Hand: ${profiles[index].totalGames == 0 ? 0 : profiles[index].totalDealerHand / profiles[index].totalGames}"),
                        ],
                      ),
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

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    profiles.clear();
    allRows.forEach((row) => profiles.add(Profile.fromMap(row)));
    setState(() {});
  }

  void _queryCurrentName() async {
    Profile userProfile;
    final currentUserRow = await dbHelper.queryByID(currentUserID);
    userProfile = Profile.fromMap(currentUserRow.first);
    currentProfileName = userProfile.name;
    setState(() {});
  }
}
