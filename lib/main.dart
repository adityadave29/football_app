import 'package:flutter/material.dart';
import 'package:football_app/screens/dice_roller.dart';
import 'package:football_app/screens/homepage.dart';
import 'package:football_app/screens/player_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
