import 'package:flutter/material.dart';
import 'package:football_app/components/appbar.dart';
import 'package:football_app/screens/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class MyTeam extends StatefulWidget {
  final String name;
  final String id;
  final int score;
  final int sum;
  const MyTeam({
    super.key,
    required this.name,
    required this.id,
    required this.score,
    required this.sum,
  });

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  List<String> playerNameList = [];
  String? playerName;
  String? playerId;
  int? score1;

  @override
  void initState() {
    super.initState();
    playerName = widget.name;
    playerId = widget.id;
    _getPlayerName();
    score1 = widget.score;
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0), // Add space at the top
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: ShapeDecoration(
                color: Color(0x992B303D),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF2B303D),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Center(
                child: Text(
                  widget.sum.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'DIN Pro',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: playerNameList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == playerNameList.length) {
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0x992B303D),
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFF2B303D),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: const SizedBox(
                            width: 306,
                            height: 64,
                            child: Center(child: appBar(title: 'TO THE MATCH')),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Text(playerNameList[index]),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
