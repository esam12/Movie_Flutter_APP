import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/domain/usecases/search_movies.dart';
import 'package:movieapp/presentation/blocs/loading/loading_bloc.dart';
import 'package:movieapp/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movieapp/presentation/journeys/search_movies/custom_search_delegate.dart';
import 'package:movieapp/presentation/widgets/logo.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              'assets/svgs/menu.svg',
              height: Sizes.dimen_16.h,
            ),
          ),
          const Expanded(
            child: Logo(height: Sizes.dimen_16),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  SearchMovieBloc(
                      searchMovies: getItInstance<SearchMovies>(),
                      loadingBloc: getItInstance<LoadingBloc>()),
                ),
              );
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: Sizes.dimen_16.h,
            ),
          ),
        ],
      ),
    );
  }
}
