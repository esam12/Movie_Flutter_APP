part of 'search_movie_bloc.dart';

sealed class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

final class SearchMovieInitial extends SearchMovieState {}

final class SearchMovieLoaded extends SearchMovieState {
  final List<MovieEntity> movies;

  const SearchMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class SearchMovieError extends SearchMovieState {
  final AppErrorType errorType;

  const SearchMovieError(this.errorType);

  @override
  List<Object> get props => [errorType];
}

final class SearchMovieLoading extends SearchMovieState {}
