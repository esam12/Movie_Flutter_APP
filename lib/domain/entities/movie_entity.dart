import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String posterPath;
  final String title;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final num voteAverage;

  const MovieEntity({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [id, title];

  @override
  bool get stringify => true;
}
