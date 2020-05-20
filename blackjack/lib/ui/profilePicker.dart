import 'package:flutter/material.dart';
import 'package:blackjack/ui/background.dart';

class ProfilePicker extends StatefulWidget {
  @override
  _ProfilePickerState createState() => _ProfilePickerState();
}

class _ProfilePickerState extends State<ProfilePicker> {
  @override
  Widget build(BuildContext context) {
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
                              decoration: InputDecoration(
                                hintText: "User Name",
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: RaisedButton(
                            child: Text("Create New User"),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Delete Profile"),
                          onPressed: () {},
                          color: Colors.red,
                        ),
                        RaisedButton(
                          child: Text("Reset Profile"),
                          onPressed: () {},
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
}

class UserDropdown extends StatefulWidget {
  @override
  _UserDropdownState createState() => _UserDropdownState();
}

class _UserDropdownState extends State<UserDropdown> {
  List _users = ["User 1", "User Bob", "Agent 47", "Falco", "Fluke"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentUser;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentUser = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String user in _users) {
      items.add(new DropdownMenuItem(
        value: user,
        child: Text(user),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: _currentUser,
      items: _dropDownMenuItems,
      onChanged: (selectedUser) {
        setState(() {
          _currentUser = selectedUser;
        });
      },
    );
  }
}
