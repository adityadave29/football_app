import 'package:flutter/material.dart';
import 'package:football_app/components/appbar.dart';
import 'package:football_app/screens/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyCollection extends StatefulWidget {
  final String name;
  final String id;
  const MyCollection({super.key, required this.name, required this.id});

  @override
  State<MyCollection> createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {
  List<String> playerNameCollectionList = [];
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
    var box = await Hive.openBox('playerCollectionData');
    setState(() {
      playerNameCollectionList = box.get('playerNameCollectionList') ?? [];
      print(playerNameCollectionList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: appBar(title: 'MY COLLECTION'), // appBar is in component
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: playerNameCollectionList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(playerNameCollectionList[index]),
          );
        },
      ),
    );
  }
}
