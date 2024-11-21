import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/get_coming_soon.dart';
import 'package:movieapp/domain/usecases/get_playing_now.dart';
import 'package:movieapp/domain/usecases/get_popular.dart';

part 'movie_tabbed_event.dart';
part 'movie_tabbed_state.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow playingNow;
  final GetComingSoon comingSoon;

  MovieTabbedBloc({
    required this.getPopular,
    required this.playingNow,
    required this.comingSoon,
  }) : super(MovieTabbedInitial()) {
    on<MovieTabbedEvent>((event, emit) async {
      if (event is MovieTabChangedEvent) {
        emit(MovieTabLoading(currentTabIndex: event.currentTabIndex));
        late Either<AppError, List<MovieEntity>> moviesEither;
        switch (event.currentTabIndex) {
          case 0:
            moviesEither = await getPopular(NoParams());
            break;
          case 1:
            moviesEither = await playingNow(NoParams());
            break;
          case 2:
            moviesEither = await comingSoon(NoParams());
            break;
        }

        moviesEither.fold(
          (error) => emit(MovieTabLoadError(
              errorType: error.appErrorType,
              currentIndex: event.currentTabIndex)),
          (movies) => emit(MovieTabChanged(
              movies: movies, currentIndex: event.currentTabIndex)),
        );
      }
    });
  }
}
