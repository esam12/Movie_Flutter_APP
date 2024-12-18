part of 'language_bloc.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

final class LanguageLoaded extends LanguageState {
  final Locale locale;
  const LanguageLoaded({required this.locale});

  @override
  List<Object> get props => [locale.languageCode];
}

class LanguageError extends LanguageState {}
