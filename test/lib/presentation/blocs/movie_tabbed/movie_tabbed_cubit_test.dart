import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/get_coming_soon.dart';
import 'package:movieapp/domain/usecases/get_playing_now.dart';
import 'package:movieapp/domain/usecases/get_popular.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';

class GetPopularMock extends Mock implements GetPopular {}

class GetPlayingNowMock extends Mock implements GetPlayingNow {}

class GetComingSoonMock extends Mock implements GetComingSoon {}

void main() {
  late GetPopularMock getPopularMock;

  late GetPlayingNowMock getPlayingNowMock;

  late GetComingSoonMock getComingSoonMock;

  late MovieTabbedBloc movieTabbedBloc;

  setUp(() {
    getPopularMock = GetPopularMock();
    getPlayingNowMock = GetPlayingNowMock();
    getComingSoonMock = GetComingSoonMock();

    movieTabbedBloc = MovieTabbedBloc(
      getPopular: getPopularMock,
      playingNow: getPlayingNowMock,
      comingSoon: getComingSoonMock,
    );
  });

  tearDown(() {
    movieTabbedBloc.close();
  });

  test('bloc should have initial state as [MovieTabbedInitial]', () {
    expect(
      movieTabbedBloc.state.runtimeType,
      MovieTabbedInitial,
    );
  });

  blocTest(
      'Should emit [MovieTabLoading, MovieTabChanged] state when tab changed to 1 index success',
      build: () => movieTabbedBloc,
      act: (MovieTabbedBloc bloc) {
        when(
          getPlayingNowMock.call(NoParams()),
        ).thenAnswer((_) async => const Right([]));

        bloc.add(const MovieTabChangedEvent(currentTabIndex: 1));
      },
      expect: () => [
            isA<MovieTabLoading>(),
            isA<MovieTabChanged>(),
          ],
      verify: (MovieTabbedBloc bloc) {
        verify(getPlayingNowMock.call(NoParams())).called(1);
      });
}
