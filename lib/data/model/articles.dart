// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  String toString() {
    return 'Articles(title: $title, content: $content, image: $image, created: $created, views: $views, name: $name, email: $email, phoneNumber: $phoneNumber)';
  }
}
