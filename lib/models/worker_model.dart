class WorkerModel {
  final int id;

  final String name;

  final String skillType;

  final bool isOnline;

  final double rating;

  WorkerModel({
    required this.id,
    required this.name,
    required this.skillType,
    required this.isOnline,
    required this.rating,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json["id"],
      name: json["name"],
      skillType: json["skill_type"],
      isOnline: json["is_online"],
      rating: (json["rating"] ?? 5).toDouble(),
    );
  }
}
