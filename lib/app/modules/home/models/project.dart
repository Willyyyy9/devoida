class Project {
  String id;
  String title;
  String description;
  String createdAt;
  String endedAt;
  String createdBy;
  String status;
  List<String> teams;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.endedAt,
    required this.status,
    required this.createdBy,
    required this.teams,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['id'] as String,
        title: json['title'] as String,
        endedAt: json['endedAt'] as String,
        status: json['status'] as String,
        description: json['description'] as String,
        createdAt: json['createdAt'] as String,
        createdBy: json['createdBy'] as String,
        teams: List<String>.from(json['teams']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'endedAt': endedAt,
        'status': status,
        'createdAt': createdAt,
        'createdBy': createdBy,
        'teams': teams,
      };
}
