part of 'language_cubit.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

Locale locale = const Locale('en', '');

final class LanguageInitial extends LanguageState {}

final class LanguageLoading extends LanguageState {}

final class LanguageFailure extends LanguageState {
  final String message;

  const LanguageFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class ChangeLanguageSuccess extends LanguageState {}
