//* Model JSON without generator

part of 'model.dart';

class Articles {
  final String title;
  final String content;
  final String image;
  final String created;

  Articles({
    required this.title,
    required this.content,
    required this.image,
    required this.created,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      title: json['title'],
      content: json['content'],
      image: json['image'],
      created: json['created']['date'] ?? DateTime.now(),
    );
  }
}
