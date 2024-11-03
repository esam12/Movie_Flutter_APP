import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/get_trending.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;
  MovieCarouselBloc(this.getTrending, this.movieBackdropBloc)
      : super(MovieCarouselInitial()) {
    on<MovieCarouselEvent>((event, emit) async {
      if (event is CarouselLoadEvent) {
        final movieEither = await getTrending(NoParams());
        movieEither.fold(
          (failure) => emit(MovieCarouselError(failure.message)),
          (movies) {
            movieBackdropBloc.add(
              MovieBackdropChangedEvent(movies[event.defaultIndex]),
            );
            return emit(
              MovieCarouselLoaded(movies, event.defaultIndex),
            );
          },
        );
      }
    });
  }
}
