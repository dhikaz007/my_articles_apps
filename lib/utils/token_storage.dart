part of 'utils.dart';

class TokenStoreges {
  static Future<SharedPreferences> getPrefs() async =>
      SharedPreferences.getInstance();

  static Future<void> setAccessToken({required String token}) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setString('token', token);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString('token') ?? '';
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await getPrefs();
    prefs.remove('token');
  }
}
