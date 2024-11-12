import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/check_if_favorite_movie.dart';
import 'package:movieapp/domain/usecases/delete_favorite_movie.dart';
import 'package:movieapp/domain/usecases/get_favorite_movies.dart';
import 'package:movieapp/domain/usecases/save_movie.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovie;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfFavoriteMovie checkIfFavoriteMovie;
  FavoriteBloc({
    required this.saveMovie,
    required this.getFavoriteMovies,
    required this.deleteFavoriteMovie,
    required this.checkIfFavoriteMovie,
  }) : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      if (event is ToggleFavoriteMovieEvent) {
        if (event.isFavorite) {
          await deleteFavoriteMovie(
            MovieParams(id: event.movie.id),
          );
        } else {
          await saveMovie(event.movie);
        }
        final response =
            await checkIfFavoriteMovie(MovieParams(id: event.movie.id));
        response.fold(
          (l) => emit(FavoriteMoviesError()),
          (r) => emit(IsFavoriteMovie(r)),
        );
      } else if (event is LoadFavoriteMovieEvent) {
        _fetchLoadFavoriteMovies();
      } else if (event is DeleteFavoriteMovieEvent) {
        await deleteFavoriteMovie(MovieParams(id: event.movieId));
        _fetchLoadFavoriteMovies();
      } else if (event is CheckIfFavoriteMovieEvent) {
        final response =
            await checkIfFavoriteMovie(MovieParams(id: event.movieId));
        response.fold(
          (l) => emit(FavoriteMoviesError()),
          (r) => emit(IsFavoriteMovie(r)),
        );
      }
    });
  }

  void _fetchLoadFavoriteMovies() async {
    final Either<AppError, List<MovieEntity>> response =
        await getFavoriteMovies(NoParams());
    response.fold(
      (l) => FavoriteMoviesError(),
      (r) => FavoriteMoviesLoaded(r),
    );
  }
}
