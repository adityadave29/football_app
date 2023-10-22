import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:football_app/api.dart';
import 'package:football_app/components/appbar.dart';
import 'package:football_app/screens/dice_roller.dart';
import 'package:football_app/screens/home_screen_shape.dart';
import 'package:football_app/screens/match_simulation.dart';
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
  List<dynamic> matches = []; //! live_data
  late Timer _timer; //r Timer for updating UI
  String storedRandomNumber = '0'; // random number for display

  int _counter = 0;
  DateTime _currentDate = DateTime.now();
  final int _maxPresses = 5;

  @override
  void initState() {
    super.initState();
    fetchData();
    _getRemainingTimeAndUpdate();
    _getStoredRandomNumber();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final box = Hive.box('buttonBox');
    DateTime lastDate =
        DateTime.parse(box.get('date') ?? _currentDate.toString());
    _counter = box.get('counter') ?? 0;

    // Check if the last press was not today
    if (lastDate.day != _currentDate.day ||
        lastDate.month != _currentDate.month ||
        lastDate.year != _currentDate.year) {
      _counter = 0;
    }
  }

  Future<void> _incrementCounter() async {
    final box = Hive.box('buttonBox');

    // Limit the button press to 5 times a day
    if (_counter < _maxPresses) {
      setState(() {
        _counter++;
      });

      box.put('counter', _counter);
      box.put('date', _currentDate.toString());
    }
  }

  bool get isButtonDisabled => _counter >= _maxPresses;

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

          return ListTile(
            title: Column(
              children: [
                Container(
                  child: Text(
                    'TODAY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2F3542),
                      fontSize: 15,
                      fontFamily: 'DIN Pro',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            image: AssetImage('assets/images/ground.png'),
                            fit: BoxFit.cover,
                            opacity: 0.4,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100, // Match the height of the ClipPath
                      //   width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 5, right: 1, bottom: 5),
                              child: Text(
                                team1,
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      15, // Adjust the font size as needed
                                  fontFamily: 'DIN Pro',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 13, left: 13),
                            child: Text(
                              "-",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, // Adjust the font size as needed
                                fontFamily: 'DIN Pro',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 5, right: 5, bottom: 5),
                              child: Text(
                                team2,
                                softWrap: true,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      15, // Adjust the font size as needed
                                  fontFamily: 'DIN Pro',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //! ON TAP
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Theme(
                      data: ThemeData(
                        dialogBackgroundColor:
                            Colors.transparent.withOpacity(0.8),
                        // cardColor: Color(0xFF2B303D),
                      ),
                      child: Container(
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(
                              color: Colors.black, // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                          title: Center(
                            child: Text(
                              'TODAY',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontFamily: 'DIN Pro',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipPath(
                                          clipper: CustomClipPath(),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/ground.png'),
                                                fit: BoxFit.cover,
                                                opacity: 0.4,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:
                                              100, // Match the height of the ClipPath
                                          //   width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 5, bottom: 5),
                                                  child: Text(
                                                    team1,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          12, // Adjust the font size as needed
                                                      fontFamily: 'DIN Pro',
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 13, left: 13),
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        18, // Adjust the font size as needed
                                                    fontFamily: 'DIN Pro',
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 5),
                                                  child: Text(
                                                    team2,
                                                    softWrap: true,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          12, // Adjust the font size as needed
                                                      fontFamily: 'DIN Pro',
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              children: [
                                TextButton(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 3, right: 5),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/button.png'),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (!isButtonDisabled) {
                                      print(_counter);
                                      _incrementCounter();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MatchSimulation(
                                            flag: '1',
                                            team1: team1,
                                            team2: team2,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Text(
                                  'PLAY IN THIS MATCH',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.5,
                                    fontFamily: 'DIN Pro',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                TextButton(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5, right: 3),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/button.png'),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (!isButtonDisabled) {
                                      print(_counter);
                                      _incrementCounter();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MatchSimulation(
                                            flag: '2',
                                            team1: team1,
                                            team2: team2,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
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
                  final result = await Navigator.pushReplacement(
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
