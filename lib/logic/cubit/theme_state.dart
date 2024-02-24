part of 'theme_cubit.dart';

final class ThemeState extends Equatable {
  final ThemeData themeData;
  const ThemeState(this.themeData);

  static ThemeState get darkTheme => ThemeState(
        ThemeData.dark().copyWith(
          brightness: Brightness.dark,
        ),
      );

  static ThemeState get lightTheme => ThemeState(
        ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          brightness: Brightness.light,
        ),
      );

  @override
  List<Object?> get props => [themeData];
}
