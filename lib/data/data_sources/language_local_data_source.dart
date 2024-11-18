import 'package:hive/hive.dart';

abstract class LanguageLocalDataSource {
  Future<void> updateLanguage(String language);
  Future<String> getPreferredLanguage();
}

class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  @override
  Future<void> updateLanguage(String language) async {
    final languageBox = await Hive.openBox('languageBox');
    return languageBox.put('preferred_language', language);
  }

  @override
  Future<String> getPreferredLanguage() async {
    final languageBox = await Hive.openBox('languageBox');
    return languageBox.get('preferred_language') ?? 'en';
  }
}
