import 'package:flutter/material.dart';
import 'package:football_app/components/appbar.dart';

class MyCollection extends StatefulWidget {
  const MyCollection({super.key});

  @override
  State<MyCollection> createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: appBar(title: 'MY COLLECTION'), // appBar is in component
        centerTitle: true,
      ),
    );
  }
}
