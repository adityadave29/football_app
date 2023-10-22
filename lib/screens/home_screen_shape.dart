import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HomeScreenShape extends StatefulWidget {
  const HomeScreenShape({super.key});

  @override
  State<HomeScreenShape> createState() => _HomeScreenShapeState();
}

class _HomeScreenShapeState extends State<HomeScreenShape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black, // Set the background color to black
      body: ClipPath(
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ground.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        clipper: CustomClipPath(),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  // var radius = 25.0;
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0016667, size.height * 0.1457143);
    path_0.lineTo(size.width * 0.4591667, size.height * 0.1428571);
    path_0.lineTo(size.width * 0.5008333, size.height * 0.3614286);
    path_0.lineTo(size.width * 0.5425000, size.height * 0.3614286);
    path_0.lineTo(size.width * 0.5850000, size.height * 0.1442857);
    path_0.lineTo(size.width, size.height * 0.1442857);
    path_0.lineTo(size.width * 0.9991667, size.height * 0.7114286);
    path_0.lineTo(size.width * 0.5841667, size.height * 0.7142857);
    path_0.lineTo(size.width * 0.5466667, size.height * 0.4871429);
    path_0.lineTo(size.width * 0.4983333, size.height * 0.4928571);
    path_0.lineTo(size.width * 0.4616667, size.height * 0.7157143);
    path_0.lineTo(size.width * 0.0025000, size.height * 0.7157143);
    path_0.lineTo(size.width * 0.0016667, size.height * 0.1457143);

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
