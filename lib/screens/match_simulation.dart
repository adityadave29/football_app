import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:football_app/screens/homepage.dart';
import 'package:football_app/screens/result.dart';
import 'package:hive/hive.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class MatchSimulation extends StatefulWidget {
  const MatchSimulation({
    super.key,
    required this.flag,
    required this.team1,
    required this.team2,
  });

  final String flag;
  final String team1;
  final String team2;

  @override
  State<MatchSimulation> createState() => _MatchSimulationState();
}

class _MatchSimulationState extends State<MatchSimulation> {
  String? getSum;
  String teamFlag = '0';
  int sum = 0;
  void initState() {
    super.initState();
    teamFlag = widget.flag;
    _retrieveSumFromHive();
  }

  void _retrieveSumFromHive() async {
    var box = await Hive.openBox('sumbox');
    setState(() {
      sum = int.tryParse(box.get('sum') ?? '0') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    void navigateToResult() {
      sum > 50
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Result(
                  team1: widget.team1,
                  team2: widget.team2,
                  flag: teamFlag,
                ),
              ),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
    }

    Future.delayed(Duration(seconds: 20), () {
      navigateToResult();
    });

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
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 320,
                    height: 64,
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Stack(
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
                            ),
                            Align(
                              child: Container(
                                margin: EdgeInsets.only(left: 7),
                                width: 50,
                                height: 50,
                                child: Image(
                                  image: AssetImage("assets/images/clock.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 18,
                            width: 230,
                            decoration: ShapeDecoration(
                              color: Color(0x992B303D),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 3,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  color: Color(0xFF2B303D),
                                ),
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            child: ProgressBarAnimation(
                              curve: Curves.linear,
                              duration: const Duration(seconds: 20),
                              color: Colors.black,
                              backgroundColor: Colors.grey.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 100,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ground.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: (teamFlag == '1')
                              ? Text(
                                  'My Team',
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'DIN Pro',
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              : Text(
                                  '${widget.team1}',
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'DIN Pro',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'DIN Pro',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Expanded(
                          child: (teamFlag == '2')
                              ? Text(
                                  'My Team',
                                  softWrap: true,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'DIN Pro',
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              : Text(
                                  '${widget.team2}',
                                  softWrap: true,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'DIN Pro',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                        ),
                      ],
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
