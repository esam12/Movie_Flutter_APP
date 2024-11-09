import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/cast_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/usecases/get_cast_crew.dart';

part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCastCrew getCastCrew;
  CastBloc({required this.getCastCrew}) : super(CastInitial()) {
    on<CastEvent>((event, emit) async {
      if (event is LoadCastEvent) {
        Either<AppError, List<CastEntity>> eitherResponse =
            await getCastCrew(MovieParams(id: event.movieId));
        
        eitherResponse.fold(
          (l) => emit(CastError()),
          (r) => emit(CastLoaded(casts: r)),
        );
      }
    });
  }
}
