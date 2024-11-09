import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/cast_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class GetCastCrew extends UseCase<List<CastEntity>, MovieParams> {
  final MovieRepository movieRepository;

  GetCastCrew({required this.movieRepository});

  @override
  Future<Either<AppError, List<CastEntity>>> call(MovieParams params) {
    return movieRepository.getCastCrew(params.id);
  }
}
