import 'package:flutter/material.dart';
import 'package:football_app/components/appbar.dart';

class MyTeam extends StatefulWidget {
  const MyTeam({super.key});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: appBar(title: 'MY TEAM'), // appBar is in component
        centerTitle: true,
      ),
    );
  }
}
