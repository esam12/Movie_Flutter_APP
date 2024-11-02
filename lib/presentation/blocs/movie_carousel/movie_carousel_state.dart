part of 'movie_carousel_bloc.dart';

sealed class MovieCarouselState extends Equatable {
  const MovieCarouselState();

  @override
  List<Object> get props => [];
}

final class MovieCarouselInitial extends MovieCarouselState {}

final class MovieCarouselLoading extends MovieCarouselState {}

final class MovieCarouselLoaded extends MovieCarouselState {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieCarouselLoaded(this.movies, this.defaultIndex)
      : assert(defaultIndex >= 0, 'defaultIndex must be greater than 0');
}

final class MovieCarouselError extends MovieCarouselState {
  final String message;

  const MovieCarouselError(this.message);
}
