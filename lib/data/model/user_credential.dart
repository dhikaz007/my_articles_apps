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
}
