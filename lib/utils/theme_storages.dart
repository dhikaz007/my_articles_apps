part of 'utils.dart';

class ThemeStorages {
  static Future<SharedPreferences> _getPrefs() async =>
      await SharedPreferences.getInstance();

  static Future<void> setTheme(bool isDark) async {
    SharedPreferences prefs = await _getPrefs();
    await prefs.setBool('theme', isDark);
  }

  static Future<ThemeState> getTheme() async {
    SharedPreferences prefs = await _getPrefs();
    final theme = prefs.getBool('theme');
    if (theme != null && theme) {
      return ThemeState.darkTheme;
    } else {
      return ThemeState.lightTheme;
    }
  }
}
