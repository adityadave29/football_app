import 'package:flutter/material.dart';
import 'package:football_app/screens/dice_roller.dart';
import 'package:football_app/screens/multi_screen_player_card.dart';
import 'package:football_app/screens/homepage.dart';
import 'package:football_app/screens/player_card.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceRoller(),
    );
  }
}
