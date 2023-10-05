import 'package:flutter/material.dart';
import 'package:football_app/components/players_attributes.dart';
import 'package:football_app/screens/homepage.dart';
import 'package:football_app/screens/my_collection.dart';
import 'package:football_app/screens/my_team.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlayerCard(),
    );
  }
}
