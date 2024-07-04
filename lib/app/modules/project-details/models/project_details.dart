class ProjectTask {
  String id;
  String projectId;
  String assigneeId;
  String createdBy;
  String title;
  String description;
  String status;
  String deadlineDate;
  String finishedDate;
  String startedDate;
  String createdAt;
  String team;

  ProjectTask({
    required this.id,
    required this.projectId,
    required this.assigneeId,
    required this.createdBy,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.deadlineDate,
    required this.finishedDate,
    required this.startedDate,
    required this.team,
  });

  factory ProjectTask.fromJson(Map<String, dynamic> json) {
    return ProjectTask(
      id: json['id'],
      projectId: json['projectId'],
      assigneeId: json['assigneeId'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      deadlineDate: json['deadlineDate'],
      finishedDate: json['finishedDate'],
      startedDate: json['startedDate'],
      team: json['team'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'assigneeId': assigneeId,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'title': title,
      'description': description,
      'status': status,
      'deadlineDate': deadlineDate,
      'finishedDate': finishedDate,
      'startedDate': startedDate,
      'team': team,
    };
  }
}
