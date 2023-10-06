import 'package:flutter/material.dart';
import 'package:football_app/components/appbar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyTeam extends StatefulWidget {
  final String name;
  final String id;
  const MyTeam({super.key, required this.name, required this.id});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  List<String> playerNameList = [];
  String? playerName;
  String? playerId;

  @override
  void initState() {
    super.initState();
    playerName = widget.name;
    playerId = widget.id;
    _getPlayerName();
  }

  void _getPlayerName() async {
    var box = await Hive.openBox('playerData');
    setState(() {
      playerNameList = box.get('playerNameList') ?? [];
      print(playerNameList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: appBar(title: 'MY TEAM'), // appBar is in component
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: playerNameList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(playerNameList[index]),
          );
        },
      ),
    );
  }
}
