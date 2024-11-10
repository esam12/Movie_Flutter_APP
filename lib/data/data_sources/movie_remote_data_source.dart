import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/models/cast_crew_result_data_model.dart';
import 'package:movieapp/data/models/movie_detail_model.dart';
import 'package:movieapp/data/models/movie_model.dart';
import 'package:movieapp/data/models/movies_result_model.dart';
import 'package:movieapp/data/models/video_model.dart';
import 'package:movieapp/data/models/video_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getComingSoon();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCastCrew(int id);
  Future<List<VideoModel>> getVideo(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient client;
  MovieRemoteDataSourceImpl({required this.client});
  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await client.get('trending/movie/day');
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies!;
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await client.get('movie/popular');
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies!;
  }

  @override
  Future<List<MovieModel>> getComingSoon() async {
    final response = await client.get('movie/upcoming');
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies!;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    final response = await client.get('movie/now_playing');
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies!;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    return movie;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final response = await client.get('movie/$id/credits');
    final castCrew = CastCrewResultDataModel.fromJson(response).cast;
    return castCrew;
  }

  @override
  Future<List<VideoModel>> getVideo(int id) async {
    final response = await client.get('movie/$id/videos');
    final videos = VideoResultModel.fromJson(response).videos;
    return videos;
  }
}
