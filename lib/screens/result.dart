import 'dart:math';

import 'package:flutter/material.dart';
import 'package:football_app/screens/dice_roller.dart';
import 'package:football_app/screens/home_screen_shape.dart';

class Result extends StatefulWidget {
  const Result(
      {super.key,
      required this.flag,
      required this.team1,
      required this.team2});
  final String flag;
  final String team1;
  final String team2;
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();

    // Generate a random number between 1 and 3
    int number1 = 1 + random.nextInt(3);

    // Generate a random number between 4 and 5
    int number2 = 4 + random.nextInt(2);

    int displayOne, displayTwo;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ground.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'YOU WIN!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'DIN Pro',
                      fontWeight: FontWeight.w900,
                      height: 0,
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(40),
                        height: 200,
                        child: ClipPath(
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
                      ),
                      Container(
                        height: 130, // Match the height of the ClipPath
                        //   width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: (widget.flag == '1')
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          left: 70,
                                          right: 1,
                                          bottom: 5,
                                          top: 65),
                                      child: Text(
                                        'My Team $number2',
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              15, // Adjust the font size as needed
                                          fontFamily: 'DIN Pro',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: 70, right: 1, top: 60),
                                      child: Text(
                                        '${widget.team1}  ${number1}',
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
                              margin:
                                  EdgeInsets.only(bottom: 1, left: 15, top: 55),
                              child: Text(
                                "-",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      17, // Adjust the font size as needed
                                  fontFamily: 'DIN Pro',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Expanded(
                              child: (widget.flag == '2')
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          left: 40,
                                          right: 60,
                                          // bottom: 5,
                                          top: 60),
                                      child: Text(
                                        'My Team    ${number2}',
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              15, // Adjust the font size as needed
                                          fontFamily: 'DIN Pro',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: 30,
                                          right: 40,
                                          // bottom: 5,
                                          top: 60),
                                      child: Text(
                                        '${widget.team2}              ${number1}',
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 10),
                  Container(
                    height: 80,
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Navigate to DiceRoller screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DiceRoller()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0x992B303D)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              color: Color(0xFF2B303D),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
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
                                    '0',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
