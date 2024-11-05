import 'package:movieapp/domain/entities/language_entity.dart';

class Languages {
  const Languages._();

  static List<LanguageEntity> languages = [
    LanguageEntity(code: 'en', value: 'English'),
    LanguageEntity(code: 'tr', value: 'Turkish'),
    LanguageEntity(code: 'ar', value: 'Arabic'),
  ];
}
