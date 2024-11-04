import 'package:flutter/material.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_tab_cart_widget.dart';

class MovieListViewBuilder extends StatelessWidget {
  const MovieListViewBuilder({super.key, required this.movies});
  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: movies.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(width: 14.w),
      itemBuilder: (context, index) => MovieTabCartWidget(
        movieId: movies[index].id,
        title: movies[index].title,
        posterPath: movies[index].posterPath,
      ),
    );
  }
}
