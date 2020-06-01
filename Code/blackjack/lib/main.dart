import 'package:blackjack/bl/databaseHelper.dart';
import 'package:blackjack/bl/profile.dart';
import 'package:blackjack/ui/mainMenu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Richard's Blackjack",
      home: new MainMenu(),
    ),
  );
}

void _createDefaultProfile() async {
  var defaultUser;
  final defaultProfileRow = await dbHelper.queryByID(1);
  defaultProfileRow.forEach((row) => defaultUser = row);
  if (defaultUser == null) dbHelper.insert(Profile(name: "DefaultProfile"));
}

final dbHelper = DatabaseHelper.instance;
