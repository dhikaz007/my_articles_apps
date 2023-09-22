//* Model JSON without generator

part of 'model.dart';

class Articles {
  final String title;
  final String content;
  final String image;
  final String created;
  final int views;
  final String name;
  final String email;
  final String phoneNumber;

  Articles({
    required this.title,
    required this.content,
    required this.image,
    required this.created,
    required this.views,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      title: json['title'] ?? '-',
      content: json['content'] ?? '-',
      image: json['image'] ?? '-',
      created: json['created']['date'] ?? DateTime.now(),
      views: json['views'] ?? 0,
      name: json['user']['name'] ?? '-',
      email: json['user']['email'] ?? '-',
      phoneNumber: json['user']['phone_number'] ?? '-',
    );
  }
}
