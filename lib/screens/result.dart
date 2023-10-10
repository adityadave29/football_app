import 'package:flutter/material.dart';

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
                          child: (widget.flag == '1')
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
                          child: (widget.flag == '2')
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
            )
          ],
        ),
      ),
    );
  }
}
