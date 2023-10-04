import 'dart:async';
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
  Stream<int> timerStream =
      Stream<int>.periodic(Duration(seconds: 60), (x) => x);
  List<dynamic> matches = []; // live_data
  late Timer _timer; // Timer for updating UI
  String storedRandomNumber = '0'; // random number for display

  @override
  void initState() {
    super.initState();
    fetchData();
    _getRemainingTimeAndUpdate();
    _getStoredRandomNumber();
  }

  // Start a timer to update the UI every second
  void _getRemainingTimeAndUpdate() {
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      setState(() {});
    });
  }

  // Cancel the timer when the widget is disposed to prevent memory leaks
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _getStoredRandomNumber() async {
    var box = await Hive.openBox('randomNumber');
    setState(() {
      storedRandomNumber = box.get('randNum');
      print(storedRandomNumber);
    });
  }

  Future<Duration?> getRemainingTime(DateTime now) async {
    final timerBox = await Hive.openBox('timerBox');
    final endTimeString = timerBox.get('timerEndTime');

    if (endTimeString != null) {
      final endTime = DateTime.parse(endTimeString);

      if (now.isBefore(endTime)) {
        return endTime.difference(now);
      }
    }

    return null;
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
    final now = DateTime.now(); // Current time

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: appBar(title: 'MATCHES'), // appBar is in component
        centerTitle: true,
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
              ],
            ),
          );
        },
      ),
      floatingActionButton: FutureBuilder<Duration?>(
        future: getRemainingTime(now), // Pass current time
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while fetching remaining time
          } else if (snapshot.hasError || snapshot.data == null) {
            return SizedBox(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                onPressed: () async {
                  // Navigate to DiceRoller screen
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DiceRoller()),
                  );
                  if (result != null) {
                    // Handle any result passed back from DiceRoller screen if needed
                  }
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
            );
          } else {
            final remainingTime = snapshot.data!;
            final hours = remainingTime.inHours;
            final minutes = remainingTime.inMinutes.remainder(60);

            return SizedBox(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                onPressed: () {
                  // Handle button press when the timer is running
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
                      Text('$hours:$minutes'),
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
            );
          }
        },
      ),
    );
  }
}
