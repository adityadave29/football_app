import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:football_app/api.dart';
import 'package:football_app/components/appbar.dart';
import 'package:football_app/components/card_fontstyle.dart';
import 'package:football_app/components/players_attributes.dart';
import 'package:football_app/models/player.dart';
import 'package:football_app/screens/my_collection.dart';
import 'package:football_app/screens/my_team.dart';
import 'package:http/http.dart' as http;

class PlayerCard extends StatefulWidget {
  const PlayerCard({super.key});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  List<dynamic> players = [];

  @override
  void initState() {
    super.initState();
    fetchPlayerData();
  }

  Future<Player> fetchPlayerData() async {
    final Random random = Random();
    int randomNumber;

    Player? player;

    while (player == null) {
      randomNumber = random.nextInt(100);

      final response = await http.get(Uri.parse(
          'https://spoyer.com/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=playerdata&player=$randomNumber'));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        player = Player.fromJson(jsonMap);
      }
    }

    return player;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: const appBar(title: 'PLAYER CARD'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 278,
                  height: 387,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/player_card.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                FutureBuilder<Player>(
                  future: fetchPlayerData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final player = snapshot.data;
                      return Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 290, left: 90),
                            child: CardFontStyle(
                                size: 18, fontDetail: '${player?.name}'),
                          ),
                          Positioned(
                              left: 210,
                              bottom: 300,
                              child: CardFontStyle(
                                  size: 10, fontDetail: '${player?.position}')),
                          Container(
                            padding: EdgeInsets.only(top: 290),
                            child: CardFontStyle(
                                size: 40, fontDetail: '${player?.id}'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0x992B303D),
                side: const BorderSide(width: 2, color: Color(0xFF2B303D)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyTeam(),
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
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyCollection(),
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
      ),
    );
  }
}
