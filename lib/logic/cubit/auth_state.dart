part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String message;
  final UserResponse? userResponse;

  const AuthAuthenticated({required this.message, required this.userResponse});

  @override
  List<Object?> get props => [message, userResponse];
}

class AuthError extends AuthState {
  final String errorMessage;

  const AuthError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
