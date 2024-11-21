import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/get_trending.dart';
import 'package:movieapp/presentation/blocs/loading/loading_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;
  final LoadingBloc loadingBloc;
  MovieCarouselBloc(this.getTrending, this.movieBackdropBloc,
      {required this.loadingBloc})
      : super(MovieCarouselInitial()) {
    on<MovieCarouselEvent>((event, emit) async {
      if (event is CarouselLoadEvent) {
        loadingBloc.add(StartLoading());
        final movieEither = await getTrending(NoParams());
        movieEither.fold(
          (failure) => emit(MovieCarouselError(failure.appErrorType)),
          (movies) {
            movieBackdropBloc.add(
              MovieBackdropChangedEvent(movies[event.defaultIndex]),
            );
            return emit(
              MovieCarouselLoaded(movies, event.defaultIndex),
            );
          },
        );
        loadingBloc.add(StopLoading());

      }
    });
  }
}
