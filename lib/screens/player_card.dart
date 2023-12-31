import 'dart:convert';
import 'dart:math';
import 'package:football_app/components/appbar.dart';
import 'package:football_app/components/card_fontstyle.dart';
import 'package:football_app/screens/my_collection.dart';
import 'package:football_app/screens/my_team.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:football_app/models/player.dart';

class PlayerCard extends StatefulWidget {
  const PlayerCard({super.key});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  List<dynamic> players = [];
  String? selectedName;
  String? selectedId;

  @override
  void initState() {
    super.initState();
    fetchPlayerData();
    _retrieveSumFromHive();
  }

  void _retrieveSumFromHive() async {
    var box = await Hive.openBox('sumbox');
    setState(() {
      sum = int.tryParse(box.get('sum') ?? '0') ?? 0;
    });
  }

  final Random random = Random();

  Future<PlayerData?> fetchPlayerData() async {
    final Random random = Random();
    int randomNumber;

    PlayerData? player;

    while (player == null) {
      randomNumber = random.nextInt(100);

      final response = await http.get(Uri.parse(
          'https://spoyer.com/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=playerdata&player=$randomNumber'));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        final success = jsonMap['success'];

        if (success == 1) {
          player = PlayerData.fromJson(jsonMap);
        }
      }
    }

    return player;
  }

  int sum = 0;
  void addToSum(int scoreToAdd) {
    setState(() {
      sum += scoreToAdd;
    });
    _updateSumInHive();
  }

  void _updateSumInHive() async {
    var box = await Hive.openBox('sumbox');
    await box.put('sum', sum.toString());
  }

  int score = 0;
  int generateRandomNumber() {
    int max = 4; // Maximum range
    int min = 1; // Minimum range
    var randomizer = new Random();
    var randomNumber1 = min + randomizer.nextInt(max - min);
    setState(() {
      score = randomNumber1;
      print(score);
    });
    return randomNumber1;
  }

  @override
  Widget build(BuildContext context) {
    int randomNumber = generateRandomNumber();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2B303D),
          title: const appBar(title: 'PLAYER CARD'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 65),
                width: 278,
                height: 387,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 278,
                        height: 387,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/player_card.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 13,
                      child: Container(
                        width: 254,
                        height: 356,
                        child: Stack(
                          children: [
                            // Positioned(
                            //   left: 41,
                            //   top: 90,
                            //   child: Container(
                            //     width: 172,
                            //     height: 181,
                            //     decoration: ShapeDecoration(
                            //       image: DecorationImage(
                            //         image: NetworkImage(
                            //             "https://via.placeholder.com/172x181"),
                            //         fit: BoxFit.cover,
                            //       ),
                            //       shape: RoundedRectangleBorder(
                            //         side: BorderSide(
                            //           width: 4,
                            //           strokeAlign: BorderSide.strokeAlignOutside,
                            //           color: Color(0xFFF49627),
                            //         ),
                            //         borderRadius: BorderRadius.circular(180),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            FutureBuilder<PlayerData?>(
                              future: fetchPlayerData(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final player = snapshot.data;
                                  selectedName = player?.name;
                                  selectedId = player?.id;
                                  return Stack(
                                    children: [
                                      Positioned(
                                        left: 124,
                                        top: 312,
                                        child: CardFontStyle(
                                            size: 18,
                                            fontDetail: '${player?.name}'),
                                      ),
                                      Positioned(
                                          left: 206,
                                          top: 3,
                                          child: CardFontStyle(
                                              size: 10,
                                              fontDetail:
                                                  '${player?.position}')),
                                      Positioned(
                                        left: 5,
                                        top: 306,
                                        child: CardFontStyle(
                                            size: 40,
                                            fontDetail: '${player?.id}'),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            //! ATTRIBUTES SECTION
                            Container(
                              child: Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 60,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 44,
                                          height: 29,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Text(
                                                  'SPEED',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontFamily: 'DIN Pro',
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 16,
                                                child: Container(
                                                  width: 44,
                                                  height: 13,
                                                  child: Row(
                                                    children: List.generate(
                                                      randomNumber,
                                                      (index) => Image.asset(
                                                          'assets/images/speed.png'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 38,
                                        child: Container(
                                          width: 50,
                                          height: 29,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Text(
                                                  'POWER',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontFamily: 'DIN Pro',
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 16,
                                                child: Container(
                                                  width: 44,
                                                  height: 13,
                                                  child: Row(
                                                    children: List.generate(
                                                      randomNumber,
                                                      (index) => Image.asset(
                                                          'assets/images/power.png'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 1,
                                        top: 76,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Text(
                                                  'DEFENCE',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontFamily: 'DIN Pro',
                                                    fontWeight: FontWeight.w900,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 16,
                                                child: Container(
                                                  width: 44,
                                                  height: 25,
                                                  child: Row(
                                                    children: List.generate(
                                                      randomNumber,
                                                      (index) => Image.asset(
                                                          'assets/images/Defense.png'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0x992B303D),
                  side: const BorderSide(width: 2, color: Color(0xFF2B303D)),
                ),
                onPressed: () async {
                  // var box = await Hive.openBox('playerData');
                  // await box.put('playerName', selectedName);
                  // print(box.get('playerName'));
                  var box = await Hive.openBox('playerData');
                  List<String> playerNameList =
                      box.get('playerNameList')?.toSet().toList() ?? [];

                  if (playerNameList.length < 11 &&
                      !playerNameList.contains(selectedName)) {
                    playerNameList.add(selectedName!);
                    await box.put('playerNameList', playerNameList);
                    addToSum(3 * score);
                  }

                  // addToSum(0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyTeam(
                        name: selectedName!,
                        id: selectedId!,
                        score: score,
                        sum: sum,
                      ),
                    ),
                  );
                },
                child: const SizedBox(
                  width: 306,
                  height: 64,
                  child: Center(child: appBar(title: 'ADD TO TEAM')),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0x992B303D),
                  side: const BorderSide(width: 2, color: Color(0xFF2B303D)),
                ),
                onPressed: () async {
                  var box = await Hive.openBox('playerCollectionData');
                  List<String> playerNameCollectionList =
                      box.get('playerNameCollectionList')?.toSet().toList() ??
                          [];

                  if (!playerNameCollectionList.contains(selectedName)) {
                    playerNameCollectionList.add(selectedName!);
                    await box.put(
                        'playerNameCollectionList', playerNameCollectionList);
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyCollection(name: selectedName!, id: selectedId!),
                    ),
                  );
                },
                child: const SizedBox(
                  width: 306,
                  height: 64,
                  child: Center(child: appBar(title: 'TO THE COLLECTION')),
                ),
              ),
            ],
          ),
        ));
  }
}

// class RepeatWidget extends StatefulWidget {
//   const RepeatWidget({super.key});

//   @override
//   State<RepeatWidget> createState() => _RepeatWidgetState();
// }

// class _RepeatWidgetState extends State<RepeatWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 4, // Number of times you want to display your custom widget
//       itemBuilder: (context, index) {
//         return PlayerCard(); // Create a new instance of your custom widget
//       },
//     );
//   }
// }
