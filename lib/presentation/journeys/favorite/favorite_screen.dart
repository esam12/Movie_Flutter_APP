import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_movie_grid_view.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    super.initState();
    _favoriteBloc = getItInstance<FavoriteBloc>();
    _favoriteBloc.add(LoadFavoriteMovieEvent());
  }

  @override
  void dispose() {
    _favoriteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationConstants.favoriteMovies.t(context),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocProvider.value(
        value: _favoriteBloc,
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteMoviesLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 64.w),
                    child: Text(
                      TranslationConstants.noFavoriteMovies.t(context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              }
              return FavoriteMovieGridView(movies: state.movies);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
