class Player {
  final String name;
  final String position;

  Player({
    required this.name,
    required this.position,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    final results = json['results']['player'];
    return Player(
      name: results['name'],
      position: results['position'],
    );
  }
}
