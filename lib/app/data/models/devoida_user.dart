class DevoidaUser {
  final String id;
  final String name;
  final String email;
  final String image;
  final List<String> teams;
  final String createdAt;

  DevoidaUser({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.teams,
    required this.createdAt,
  });

  // Optionally, you can add methods like toJson and fromJson for easier serialization/deserialization
  factory DevoidaUser.fromJson(Map<String, dynamic> json) {
    return DevoidaUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      teams: List<String>.from(json['teams']),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'teams': teams,
      'createdAt': createdAt,
    };
  }
}
