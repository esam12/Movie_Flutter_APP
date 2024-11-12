part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteMovieEvent extends FavoriteEvent {}

class DeleteFavoriteMovieEvent extends FavoriteEvent {
  final int movieId;

  const DeleteFavoriteMovieEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class ToggleFavoriteMovieEvent extends FavoriteEvent {
  final MovieEntity movie;
  final bool isFavorite;

  const ToggleFavoriteMovieEvent(
      {required this.movie, required this.isFavorite});

  @override
  List<Object> get props => [movie, isFavorite];
}


class CheckIfFavoriteMovieEvent extends FavoriteEvent {
  final int movieId;

  const CheckIfFavoriteMovieEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
