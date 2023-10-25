part of 'model.dart';

class UserResponse {
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime created;
  final String uuid;

  UserResponse({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.created,
    required this.uuid,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        name: json['name'] ?? '-',
        email: json['email'] ?? '-',
        phoneNumber: json['phone_number'] ?? '-',
        created: DateTime.parse(json['created']['date']),
        uuid: json['uuid'] ?? '-',
      );

  @override
  String toString() =>
      'UserResponse(name: $name, email: $email, phoneNumber: $phoneNumber, created: $created, uuid: $uuid)';
}
