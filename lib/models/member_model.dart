class Member {
  final String id;
  final String name;
  final String role;
  final String company;
  final String imageUrl;
  final List<String> interests;
  final String bio;
  final bool isAvailableForNetworking;

  Member({
    required this.id,
    required this.name,
    required this.role,
    required this.company,
    required this.imageUrl,
    required this.interests,
    required this.bio,
    required this.isAvailableForNetworking,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      company: json['company'],
      imageUrl: json['imageUrl'],
      interests: List<String>.from(json['interests']),
      bio: json['bio'],
      isAvailableForNetworking: json['isAvailableForNetworking'],
    );
  }
}
