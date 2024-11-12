import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp/presentation/blocs/videos/videos_bloc.dart';
import 'package:movieapp/presentation/journeys/movie_detail/big_poster.dart';
import 'package:movieapp/presentation/journeys/movie_detail/cast_widget.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/presentation/journeys/movie_detail/videos_widget.dart';

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
  late CastBloc _castBloc;
  late VideosBloc _videosBloc;
  late FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    super.initState();

    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _castBloc = _movieDetailBloc.castBloc;
    _videosBloc = _movieDetailBloc.videosBloc;
    _favoriteBloc = _movieDetailBloc.favoriteBloc;
    _movieDetailBloc.add(
      MovieDetailLoadEvent(widget.movieDetailArguments.id),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _movieDetailBloc.close();
    _castBloc.close();
    _videosBloc.close();
    _favoriteBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailBloc),
          BlocProvider.value(value: _castBloc),
          BlocProvider.value(value: _videosBloc),
          BlocProvider.value(value: _favoriteBloc),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigPoster(movie: state.movieDetailEntity),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w,
                        vertical: Sizes.dimen_8.h,
                      ),
                      child: Text(
                        state.movieDetailEntity.overview,
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                            color: Colors.white60,
                            fontSizeDelta: 0.5,
                            fontWeightDelta: 1),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                      child: Text(
                        TranslationConstants.cast.t(context),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const CastWidget(),
                    VideosWidget(videosBloc: _videosBloc),
                  ],
                ),
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
