import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingInitial()) {
    on<LoadingEvent>((event, emit) {
      if (event is StartLoading) {
        emit(LoadingStarted());
      } else if (event is StopLoading) {
        emit(LoadingStopped());
      }
    });
  }
}
