import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp/presentation/journeys/movie_detail/big_poster.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieDetailArguments})
      : assert(movieDetailArguments != null,
            'movieDetailArguments cannot be null');

  final MovieDetailArguments movieDetailArguments;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    super.initState();

    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _movieDetailBloc.add(
      MovieDetailLoadEvent(widget.movieDetailArguments.id),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _movieDetailBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MovieDetailBloc>.value(
        value: _movieDetailBloc,
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BigPoster(movie: state.movieDetailEntity),
                  const SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_16.w,
                    ),
                    child: Text(
                      state.movieDetailEntity.overview,
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                          color: Colors.white60,
                          fontSizeDelta: 0.5,
                          fontWeightDelta: 1),
                    ),
                  )
                ],
              );
            } else if (state is MovieDetailError) {
              return Container();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
