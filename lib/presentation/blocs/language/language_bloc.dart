import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/domain/entities/language_entity.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(LanguageLoaded(locale: Locale(Languages.languages[0].code))) {
    on<LanguageEvent>((event, emit) {
      if (event is ToggleLanguageEvent) {
        emit(
          LanguageLoaded(
            locale: Locale(event.language.code),
          ),
        );
      }
    });
  }
}
