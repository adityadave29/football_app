import 'package:flutter/material.dart';
import 'package:football_app/components/appbar.dart';

class MyTeam extends StatefulWidget {
  final String name;
  final String id;
  const MyTeam({super.key, required this.name, required this.id});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  String? playerName;
  String? playerId;
  

  @override
  void initState() {
    super.initState();
    playerName = widget.name;
    playerId = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2B303D),
          title: appBar(title: 'MY TEAM'), // appBar is in component
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Text('$playerName'),
              Text('$playerId'),
            ],
          ),
        ));
  }
}
