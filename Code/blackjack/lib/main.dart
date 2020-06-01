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

final dbHelper = DatabaseHelper.instance;
