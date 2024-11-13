import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/domain/entities/language_entity.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/get_preferred_language.dart';
import 'package:movieapp/domain/usecases/update_language.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetPreferredLanguage preferredLanguage;
  final UpdateLanguage updateLanguage;
  LanguageBloc({required this.preferredLanguage, required this.updateLanguage})
      : super(LanguageLoaded(locale: Locale(Languages.languages[0].code))) {
    on<LanguageEvent>((event, emit) async {
      if (event is ToggleLanguageEvent) {
        await updateLanguage(event.language.code);
        add(LoadPreferredLanguageEvent());
      } else if (event is LoadPreferredLanguageEvent) {
        final response = await preferredLanguage(NoParams());
        response.fold(
          (l) => emit(LanguageError()),
          (r) => emit(LanguageLoaded(locale: Locale(r))),
        );
      }
    });
  }
}
