import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_list_view_builder.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_tabbed_constants.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/tab_title_widget.dart';

class MovieTabbedWidget extends StatefulWidget {
  const MovieTabbedWidget({super.key});

  @override
  State<MovieTabbedWidget> createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget>
    with SingleTickerProviderStateMixin {
  MovieTabbedBloc get movieTabbedBloc =>
      BlocProvider.of<MovieTabbedBloc>(context);

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    movieTabbedBloc.add(MovieTabChangedEvent(currentTabIndex: currentIndex));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedBloc, MovieTabbedState>(
        builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(top: Sizes.dimen_4.h),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < MovieTabbedConstants.movieTab.length; i++)
                  TabTitleWidget(
                    title: MovieTabbedConstants.movieTab[i].title,
                    onTap: () => _onTabTabbed(i),
                  ),
              ],
            ),
            if (state is MovieTabChanged)
              Expanded(
                child: MovieListViewBuilder(
                  movies: state.movies,
                ),
              )
          ],
        ),
      );
    });
  }

  void _onTabTabbed(int index) {
    movieTabbedBloc
        .add(MovieTabChangedEvent(currentTabIndex: index));
  }
}
