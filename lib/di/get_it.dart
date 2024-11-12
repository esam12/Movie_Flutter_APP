import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/data_sources/movie_local_data_source.dart';
import 'package:movieapp/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp/data/repositories/movie_repository_impl.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/check_if_favorite_movie.dart';
import 'package:movieapp/domain/usecases/delete_favorite_movie.dart';
import 'package:movieapp/domain/usecases/get_cast_crew.dart';
import 'package:movieapp/domain/usecases/get_coming_soon.dart';
import 'package:movieapp/domain/usecases/get_favorite_movies.dart';
import 'package:movieapp/domain/usecases/get_movie_detail.dart';
import 'package:movieapp/domain/usecases/get_playing_now.dart';
import 'package:movieapp/domain/usecases/get_popular.dart';
import 'package:movieapp/domain/usecases/get_trending.dart';
import 'package:movieapp/domain/usecases/get_videos.dart';
import 'package:movieapp/domain/usecases/save_movie.dart';
import 'package:movieapp/domain/usecases/search_movies.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movieapp/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movieapp/presentation/blocs/videos/videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));

  getItInstance.registerLazySingleton<GetCastCrew>(
    () => GetCastCrew(movieRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<GetVideos>(
    () => GetVideos(movieRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<SearchMovies>(
    () => SearchMovies(movieRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<SaveMovie>(
    () => SaveMovie(movieRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<GetFavoriteMovies>(
    () => GetFavoriteMovies(getItInstance()),
  );
  getItInstance.registerLazySingleton<GetFavoriteMovies>(
    () => GetFavoriteMovies(getItInstance()),
  );
  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
    () => DeleteFavoriteMovie(getItInstance()),
  );
  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(
    () => CheckIfFavoriteMovie(getItInstance()),
  );

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerFactory(() => MovieCarouselBloc(
        getItInstance(),
        getItInstance(),
      ));

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(
    () => MovieTabbedBloc(
      getPopular: getItInstance(),
      playingNow: getItInstance(),
      comingSoon: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());

  getItInstance.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: getItInstance(),
      castBloc: getItInstance(),
      videosBloc: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => CastBloc(
      getCastCrew: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => VideosBloc(
      getVideos: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => SearchMovieBloc(
      searchMovies: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => FavoriteBloc(
        saveMovie: getItInstance(),
        getFavoriteMovies: getItInstance(),
        deleteFavoriteMovie: getItInstance(),
        checkIfFavoriteMovie: getItInstance()),
  );
}
