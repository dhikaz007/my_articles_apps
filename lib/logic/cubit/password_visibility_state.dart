part of 'password_visibility_cubit.dart';

class PasswordVisibilityState extends Equatable {
  final bool isVisible;

  const PasswordVisibilityState({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}
