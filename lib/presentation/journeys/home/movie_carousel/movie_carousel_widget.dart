import 'package:flutter/material.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/presentation/journeys/home/movie_carousel/movie_page_view.dart';
import 'package:movieapp/presentation/widgets/movie_app_bar.dart';

class MovieCarouselWidget extends StatelessWidget {
  const MovieCarouselWidget(
      {super.key, required this.movies, required this.defaultIndex})
      : assert(defaultIndex >= 0, 'must be greater than 0');

  final List<MovieEntity> movies;
  final int defaultIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieAppBar(),
        MoviePageView(
          movies: movies,
          initialPage: defaultIndex,
        ),
      ],
    );
  }
}
