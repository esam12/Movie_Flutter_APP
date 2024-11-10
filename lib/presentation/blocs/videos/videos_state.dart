part of 'videos_bloc.dart';

sealed class VideosState extends Equatable {
  const VideosState();
  
  @override
  List<Object> get props => [];
}

final class VideosInitial extends VideosState {}

class VideosLoaded extends VideosState {
  final List<VideoEntity> videos;
  const VideosLoaded({required this.videos});

  @override
  List<Object> get props => [videos];
}

class NoVideos extends VideosState {}
