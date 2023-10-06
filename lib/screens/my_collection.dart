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
                  '55',
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
                itemCount: playerNameCollectionList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == playerNameCollectionList.length) {
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
                                builder: (context) => const HomePage(),
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
                      title: Text(playerNameCollectionList[index]),
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
