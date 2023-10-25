// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'model.dart';

class UserCredential {
  final String email;
  final String password;

  UserCredential({
    required this.email,
    required this.password,
  });

  factory UserCredential.fromJson(Map<String, dynamic> json) => UserCredential(
        email: json['email'],
        password: json['password'],
      );

  toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() => 'UserCredential(email: $email, password: $password)';
}
