class Language {
  final String title;
  final String lang;
  final String code;
  final String countryCode;

  Language({
    required this.title,
    required this.lang,
    required this.code,
    required this.countryCode,
  });
}

List<Language> language = [
  Language(
    title: 'Bahasa Indonesia',
    lang: 'bahasa',
    code: 'id',
    countryCode: 'ID',
  ),
  Language(
    title: 'English',
    lang: 'english',
    code: 'en',
    countryCode: 'US',
  ),
];
