// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

part of 'model.dart';

ArticleModel articleModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  final int code;
  final bool status;
  final String message;
  final List<Article> articles;

  ArticleModel({
    required this.code,
    required this.status,
    required this.message,
    required this.articles,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  final String uuid;
  final String title;
  final String content;
  final String image;
  final int views;
  final Created created;
  final User user;

  Article({
    required this.uuid,
    required this.title,
    required this.content,
    required this.image,
    required this.views,
    required this.created,
    required this.user,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        uuid: json["uuid"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        views: json["views"],
        created: Created.fromJson(json["created"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "title": title,
        "content": content,
        "image": image,
        "views": views,
        "created": created.toJson(),
        "user": user.toJson(),
      };
}

class Created {
  final DateTime date;
  final int timezoneType;
  final String timezone;

  Created({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory Created.fromJson(Map<String, dynamic> json) => Created(
        date: DateTime.parse(json["date"]),
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}

class User {
  final String name;
  final String email;
  final String phoneNumber;
  final Created created;
  final String uuid;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.created,
    required this.uuid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        created: Created.fromJson(json["created"]),
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "created": created.toJson(),
        "uuid": uuid,
      };
}
