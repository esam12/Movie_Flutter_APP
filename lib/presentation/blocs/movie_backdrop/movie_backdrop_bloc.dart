import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';

part 'movie_backdrop_event.dart';
part 'movie_backdrop_state.dart';

class MovieBackdropBloc extends Bloc<MovieBackdropEvent, MovieBackdropState> {
  MovieBackdropBloc() : super(MovieBackdropInitial()) {
    on<MovieBackdropEvent>((event, emit) {
      emit(MovieBackdropChanged(
          movie: (event as MovieBackdropChangedEvent).movie));
    });
  }
}
