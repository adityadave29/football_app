import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:football_app/api.dart';
import 'package:football_app/components/appbar.dart';
import 'package:football_app/screens/dice_roller.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> matches = []; // live_data
  String storedRandomNumber = '0'; // random number for display

  @override
  void initState() {
    super.initState();
    fetchData();
    _getStoredRandomNumber();
  }

  // get data from dice_roller.dart (random number)
  void _getStoredRandomNumber() async {
    var box = await Hive.openBox('randomNumber');
    setState(() {
      storedRandomNumber = box.get('randNum');
      print(storedRandomNumber);
    });
  }

  // get live data from api
  void fetchData() async {
    const url = LiveDataAPIKey;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      matches = json['games_live'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: const Center(
            child: appBar(title: 'MATCHES')), // appBar is in component
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          final team1 = match['home']['name'];
          final team2 = match['away']['name'];
          final score = match['score'];
          return ListTile(
            leading: Text(score),
            title: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(team1),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(team2),
                ),
                // Text(team2),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          onPressed: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DiceRoller()),
            );
          },
          backgroundColor: Color(0x992B303D),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: Color(0xFF2B303D),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 1),
                Text('Timer'),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 46,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/dice.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 50,
                        height: 25,
                        child: Text(
                          storedRandomNumber,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'DIN Pro',
                            fontWeight: FontWeight.w900,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
