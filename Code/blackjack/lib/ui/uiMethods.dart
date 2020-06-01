import 'package:flutter/material.dart';

class UIMethods {
  final void Function() updateUi;
  UIMethods({this.updateUi});

  static Future<void> showErrorMessage(BuildContext context, dynamic ex) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(ex.toString()),
            actions: <Widget>[
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Ok"),
              ),
            ],
          );
        });
  }

  static Future<void> messageBox(BuildContext context,
      {title = "", message = ""}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
                child: Text(message)),
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
