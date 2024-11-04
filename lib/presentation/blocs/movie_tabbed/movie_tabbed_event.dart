part of 'movie_tabbed_bloc.dart';

sealed class MovieTabbedEvent extends Equatable {
  const MovieTabbedEvent();

  @override
  List<Object> get props => [];
}

class MovieTabChangedEvent extends MovieTabbedEvent {
  final int currentTabIndex;

  const MovieTabChangedEvent({this.currentTabIndex = 0});
}
