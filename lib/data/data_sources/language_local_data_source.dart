import 'package:hive/hive.dart';

abstract class LanguageLocalDataSource {
  Future<void> updateLanguage(String language);
  Future<String> getPreferredLanguage();
}

class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  @override
  Future<void> updateLanguage(String language) async {
    final languageBox = Hive.box('languageBox');
    return await languageBox.put('preferred_language', language);
  }

  @override
  Future<String> getPreferredLanguage() {
    final languageBox = Hive.box('languageBox');
    return languageBox.get('preferred_language');
  }
}
