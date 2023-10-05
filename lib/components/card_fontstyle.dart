import 'package:flutter/material.dart';

class CardFontStyle extends StatelessWidget {
  final double size;
  final String fontDetail;
  const CardFontStyle({
    super.key,
    required this.size,
    required this.fontDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      fontDetail,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        fontFamily: 'DIN Pro',
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
