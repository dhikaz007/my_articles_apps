part of 'helpers.dart';

class GetLanguage {
  static Future<String> currentLanguage() async {
    String code = await LanguageStorage.getCode() ?? 'en';
    String countryCode = await LanguageStorage.getCountryCode() ?? 'US';

    debugPrint('INI CODENYA');
    debugPrint(code);
    debugPrint(countryCode);

    return '${code}_$countryCode';
  }
}
