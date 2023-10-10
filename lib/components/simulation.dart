import 'package:flutter/material.dart';

class SimulationComponent extends StatefulWidget {
  const SimulationComponent({super.key, required this.team1, required this.team2});
  final String team1;
  final String team2;
  @override
  State<SimulationComponent> createState() => _SimulationComponentState();
}

class _SimulationComponentState extends State<SimulationComponent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                  child: Text(
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
                  child: Text(
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
    );
  }
}
