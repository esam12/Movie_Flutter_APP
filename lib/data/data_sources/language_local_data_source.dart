import 'package:hive/hive.dart';

abstract class LanguageLocalDataSource {
  Future<void> updateLanguage(String language);
  Future<String> getPreferredLanguage();
  Future<void> updateTheme(String themeName);
  Future<String> getPreferredTheme();
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

  @override
  Future<String> getPreferredTheme() async {
    final themeBox = await Hive.openBox('themeBox');
    return await themeBox.get('preferred_theme') ?? 'dark';
  }

  @override
  Future<void> updateTheme(String themeName) async {
    final themeBox = await Hive.openBox('themeBox');
    return await themeBox.put('preferred_theme', themeName);
  }
}
