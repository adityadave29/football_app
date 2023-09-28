import 'package:flutter/material.dart';

class appBar extends StatelessWidget {
  const appBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'DIN Pro',
        fontWeight: FontWeight.w900,
        height: 0,
      ),
    );
  }
}
