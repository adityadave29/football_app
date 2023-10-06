class PlayerData {
  final String name;
  final String position;
  final String id;

  PlayerData({
    required this.name,
    required this.position,
    required this.id,
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    final results = json['results']['player'];
    return PlayerData(
      name: results['name'],
      id: results['id'],
      position: results['position'],
    );
  }
}
