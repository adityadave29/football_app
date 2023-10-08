import 'package:flutter/material.dart';

class MatchSimulation extends StatefulWidget {
  const MatchSimulation({
    super.key,
    required this.flag,
  });

  final String flag;

  @override
  State<MatchSimulation> createState() => _MatchSimulationState();
}

class _MatchSimulationState extends State<MatchSimulation> {
  String? teamFlag;
  void initState() {
    super.initState();
    teamFlag = widget.flag;
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
            Column(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
