import 'package:blackjack/bl/profile.dart';
import 'package:blackjack/globals.dart';
import 'package:blackjack/main.dart';
import 'package:blackjack/ui/background.dart';
import 'package:blackjack/ui/blackjack.dart';
import 'package:blackjack/ui/profilePicker.dart';
import 'package:blackjack/ui/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(0, -0.8),
                child: Image.asset("assets/images/LogoTransparent.png"),
              ),
              Align(
                alignment: Alignment(0, -0.8),
                child: Text("Richard's Blackjack",
                    style: GoogleFonts.robotoSlab(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: Colors.yellow,
                        decorationThickness: 2,
                      ),
                    )),
              ),
            ],
          ),
          Align(
            alignment: Alignment(0, -0.95),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Current Profile: $profileName",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // #region Buttons
          Center(
            child: Wrap(
              children: <Widget>[
                Center(
                  child: ButtonTheme(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Blackjack(),
                            ));
                      },
                      child: Text("New Game"),
                    ),
                    buttonColor: Colors.green,
                    minWidth: 130,
                  ),
                ),
                Center(
                  child: ButtonTheme(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePicker(),
                          ),
                        );
                      },
                      child: Text("Change Profile"),
                    ),
                    buttonColor: Colors.orange,
                    minWidth: 130,
                  ),
                ),
                Center(
                  child: ButtonTheme(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Stats(),
                          ),
                        );
                      },
                      child: Text("Stats"),
                    ),
                    minWidth: 130,
                    buttonColor: Colors.yellow,
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
