import 'package:blackjack/bl/profile.dart';
import 'package:blackjack/globals.dart';
import 'package:blackjack/main.dart';
import 'package:blackjack/ui/background.dart';
import 'package:blackjack/ui/blackjack.dart';
import 'package:blackjack/ui/profilePicker.dart';
import 'package:blackjack/ui/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String profileName;

  @override
  void initState() {
    _createDefaultProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _getCurrentProfile();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BlackjackBackground(),
          Align(
            alignment: Alignment(0, -0.8),
            child: Image.asset("assets/images/logo.png"),
          ),
          Align(
            alignment: Alignment(0, -0.92),
            child: Text("Current Profile: $profileName",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
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

  void _getCurrentProfile() async {
    Profile userProfile;
    final currentUserRow = await dbHelper.queryByID(currentUserID);
    userProfile = Profile.fromMap(currentUserRow.first);
    profileName = userProfile.name;
    setState(() {});
  }

  void _createDefaultProfile() async {
    var defaultUser;
    final defaultProfileRow = await dbHelper.queryByID(1);
    defaultProfileRow.forEach((row) => defaultUser = row);
    if (defaultUser == null) dbHelper.insert(Profile(name: "DefaultProfile"));
    _getCurrentProfile();
  }
}
