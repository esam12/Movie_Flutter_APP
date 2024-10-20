import 'package:movieapp/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  final String backdropPath;
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String mediaType;
  final bool adult;
  final String originalLanguage;
  final List<int> genreIds;
  final num popularity;
  final String releaseDate;
  final bool video;
  final num voteAverage;
  final int voteCount;

  const MovieModel({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
          id: id,
          title: title,
          overview: overview,
          posterPath: posterPath,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          backdropPath: backdropPath,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json['backdrop_path'] ?? '',
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      mediaType: json['media_type'] ?? '',
      adult: json['adult'] ?? false,
      originalLanguage: json['original_language'] ?? '',
      genreIds: json['genre_ids'].cast<int>() ?? [],
      popularity: json['popularity'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      video: json['video'] ?? false,
      voteAverage: json['vote_average'] ?? 0,
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['title'] = title;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['media_type'] = mediaType;
    data['adult'] = adult;
    data['original_language'] = originalLanguage;
    data['genre_ids'] = genreIds;
    data['popularity'] = popularity;
    data['release_date'] = releaseDate;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
