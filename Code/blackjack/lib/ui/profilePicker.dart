import 'package:blackjack/bl/profile.dart';
import 'package:blackjack/globals.dart';
import 'package:blackjack/main.dart';
import 'package:flutter/material.dart';
import 'package:blackjack/ui/background.dart';
import 'package:blackjack/ui/uiMethods.dart';

List<DropdownMenuItem<String>> items = [];

class ProfilePicker extends StatefulWidget {
  @override
  _ProfilePickerState createState() => _ProfilePickerState();
}

class _ProfilePickerState extends State<ProfilePicker> {
  @override
  void initState() {
    _loadProfilesForDDB();

    super.initState();
  }

  String currentProfileName;

  @override
  Widget build(BuildContext context) {
    TextEditingController txtNewUserName = TextEditingController();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BlackjackBackground(),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: UserDropdown(),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: TextField(
                              controller: txtNewUserName,
                              decoration: InputDecoration(
                                hintText: "User Name",
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              maxLength: 24,
                              buildCounter: (context,
                                      {currentLength, isFocused, maxLength}) =>
                                  null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: RaisedButton(
                            child: Text("Create New User"),
                            onPressed: () {
                              String newUserName = txtNewUserName.text;
                              if (newUserName == "") {
                                UIMethods.messageBox(context,
                                    title: "Error",
                                    message: "The user name can't be blank");
                              } else {
                                _createNewUser(newUserName);
                              }
                            },
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Delete Profile"),
                          onPressed: () {
                            if (currentUserID == 1) {
                              UIMethods.messageBox(context,
                                  title: "Error",
                                  message:
                                      "You can't delete the default profile");
                            } else {
                              dbHelper.delete(currentUserID);
                              currentUserID = 1;
                              _loadProfilesForDDB();
                            }
                          },
                          color: Colors.red,
                        ),
                        RaisedButton(
                          child: Text("Reset Profile"),
                          onPressed: () async {
                            await _getCurrentProfileName();
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Reset Profile"),
                                    content: SingleChildScrollView(
                                        child: Text(
                                            "Warning reseting the profile will clear all stored user info. Are you sure you wish to reset profile $currentProfileName?")),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          dbHelper.update(Profile(
                                              id: currentUserID,
                                              name: currentProfileName));
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () => Navigator.pop(context),
                                      )
                                    ],
                                  );
                                });
                          },
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Return"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void _createNewUser(newUserName) async {
    var newUser;
    final defaultProfileRow = await dbHelper.queryByName(newUserName);
    defaultProfileRow.forEach((row) => newUser = row);
    if (newUser != null)
      UIMethods.messageBox(context,
          title: "Error", message: "A user already exists with that name");
    else {
      dbHelper.insert(Profile(name: newUserName));
      UIMethods.messageBox(context,
          title: "New User Created", message: "User $newUserName created");
      _loadProfilesForDDB();
    }
  }

  void _loadProfilesForDDB() async {
    items = [];
    await dbHelper.queryAllRows().then((listMap) {
      listMap.map((map) {
        return _getDDW(map);
      }).forEach((dropdownItem) {
        items.add(dropdownItem);
      });
    });
    setState(() {});
  }

  DropdownMenuItem<String> _getDDW(Map<String, dynamic> map) {
    return DropdownMenuItem<String>(
      value: map['ID'].toString(),
      child: Text(map['Name']),
    );
  }

  void _getCurrentProfileName() async {
    Profile userProfile;
    final currentUserRow = await dbHelper.queryByID(currentUserID);
    userProfile = Profile.fromMap(currentUserRow.first);
    currentProfileName = userProfile.name;
  }
}

class UserDropdown extends StatefulWidget {
  @override
  _UserDropdownState createState() => _UserDropdownState();
}

class _UserDropdownState extends State<UserDropdown> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dropDownMenuItems = items;
    _currentUser = currentUserID.toString();

    return DropdownButton<String>(
      isExpanded: true,
      value: _currentUser,
      items: _dropDownMenuItems,
      onChanged: (selectedUser) {
        setState(() {
          _currentUser = selectedUser;
          currentUserID = int.parse(selectedUser);
        });
      },
    );
  }
}
