import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/entities/video_entity.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class GetVideos extends UseCase<List<VideoEntity>, MovieParams> {
  MovieRepository movieRepository;

  GetVideos({required this.movieRepository});
  @override
  Future<Either<AppError, List<VideoEntity>>> call(MovieParams params) async {
    return await movieRepository.getVideo(params.id);
  }
}
