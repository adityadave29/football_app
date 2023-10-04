import 'package:flutter/material.dart';
import 'package:football_app/components/appbar.dart';
import 'package:football_app/screens/my_collection.dart';
import 'package:football_app/screens/my_team.dart';

class PlayerCard extends StatefulWidget {
  const PlayerCard({super.key});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: const appBar(title: 'PLAYER CARD'),
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
