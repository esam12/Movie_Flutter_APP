part of 'movie_tabbed_bloc.dart';

sealed class MovieTabbedState extends Equatable {
  final int currentTabIndex;
  const MovieTabbedState({this.currentTabIndex = 0});

  @override
  List<Object> get props => [currentTabIndex];
}

class MovieTabbedInitial extends MovieTabbedState {}

class MovieTabChanged extends MovieTabbedState {
  final List<MovieEntity>? movies;

  const MovieTabChanged({int currentIndex = 0, required this.movies})
      : super(currentTabIndex: currentIndex);

  @override
  List<Object> get props => [currentTabIndex, movies!];
}

class MovieTabLoadError extends MovieTabbedState {
  final AppErrorType errorType;
  const MovieTabLoadError({int currentIndex = 0, required this.errorType})
      : super(currentTabIndex: currentIndex);
}

class MovieTabLoading extends MovieTabbedState {
  const MovieTabLoading({required super.currentTabIndex});
}
