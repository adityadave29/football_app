import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:football_app/api.dart';
import 'package:football_app/components/appbar.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> matches = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B303D),
        title: const Center(child: appBar(title: 'MATCHES')),
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          final team1 = match['home']['name'];
          final team2 = match['away']['name'];
          final score = match['score'];
          return ListTile(
              leading: Text(score),
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(team1),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(team2),
                  ),
                  // Text(team2),
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
