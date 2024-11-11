import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:movieapp/data/tables/movie_table.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';

abstract class MovieLocalDataSource {
  Future<void> saveMovie(MovieTable movieTable);
  Future<List<MovieEntity>> getMovies();
  Future<void> deleteMovie(int movieId);
  Future<bool> checkIfMovieFavorite(int movieId);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  @override
  Future<bool> checkIfMovieFavorite(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    return movieBox.containsKey(movieId);
  }

  @override
  Future<void> deleteMovie(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.delete(movieId);
  }

  @override
  Future<List<MovieEntity>> getMovies() async {
    final movieBox = await Hive.openBox('movieBox');
    final movieIds = movieBox.values;
    List<MovieEntity> movies = [];
    movieIds.forEach((movieId) {
      movies.add(movieBox.get(movieId));
    });
    return movies;
  }

  @override
  Future<void> saveMovie(MovieTable movieTable) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.put(movieTable.id, movieTable);
  }
}
