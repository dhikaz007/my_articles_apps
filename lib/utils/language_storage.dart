part of 'utils.dart';

class LanguageStorage {
  static Future<SharedPreferences> getPrefs() async =>
      SharedPreferences.getInstance();

  static Future<void> setCode({required String value}) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setString('code', value);
  }

  static Future<void> setCountryCode({required String value}) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setString('countryCode', value);
  }

  static Future<String?> getCode() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString('code');
  }

  static Future<String?> getCountryCode() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString('countryCode');
  }
}
