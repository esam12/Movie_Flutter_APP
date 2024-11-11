import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/movie_search_params.dart';
import 'package:movieapp/domain/usecases/search_movies.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;
  SearchMovieBloc({required this.searchMovies}) : super(SearchMovieInitial()) {
    on<SearchMovieEvent>((event, emit) async {
      if (event is SearchTermChangedEvent) {
        if (event.searchTerm.length > 2) {
          Either<AppError, List<MovieEntity>> eitherSearchResult =
              await searchMovies(
                  MovieSearchParams(searchTerm: event.searchTerm));
          eitherSearchResult.fold((l) {
            emit(SearchMovieError(l.appErrorType));
          }, (r) {
            emit(SearchMovieLoaded(r));
          });
        }
      }
    });
  }
}
