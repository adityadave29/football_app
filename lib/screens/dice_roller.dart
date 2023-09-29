import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:football_app/components/appbar.dart';
import 'package:football_app/screens/homepage.dart';
import 'package:hive/hive.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  int randomNumber = 0;

  void generateRandomNumber() {
    final random = Random();
    int newRandomNumber = random.nextInt(20) + 1;

    setState(() {
      randomNumber = newRandomNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: const Center(child: appBar(title: 'DICE')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 193,
                  height: 228,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/dice.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 110,
                  child: Text(
                    randomNumber.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontFamily: 'DIN Pro',
                      fontWeight: FontWeight.w900,
                      height: 0,
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
              onPressed: () async {
                generateRandomNumber();
                var box = await Hive.openBox('randomNumber');
                await box.put('randNum', '$randomNumber');
                print(box.get('randNum'));
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
                child: Center(child: appBar(title: 'ROLL')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
