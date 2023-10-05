class Player {
  final String name;
  final String position;
  final String id;

  Player({
    required this.name,
    required this.position,
    required this.id,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    final results = json['results']['player'];
    return Player(
      name: results['name'],
      id: results['id'],
      position: results['position'],
    );
  }
}
