import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/entities/video_entity.dart';
import 'package:movieapp/domain/usecases/get_videos.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;
  VideosBloc({required this.getVideos}) : super(VideosInitial()) {
    on<VideosEvent>((event, emit) async {
      if (event is LoadVideosEvent) {
        Either<AppError, List<VideoEntity>> either = await getVideos(
          MovieParams(id: event.movieId),
        );
        either.fold(
          (l) => emit(NoVideos()),
          (videos) => emit(VideosLoaded(videos: videos)),
        );
      }
    });
  }
}
