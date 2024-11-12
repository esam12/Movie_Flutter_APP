import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_movie_card_widget.dart';

class FavoriteMovieGridView extends StatelessWidget {
  const FavoriteMovieGridView({super.key, required this.movies});

  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: Sizes.dimen_16.w,
        ),
        itemBuilder: (context, index) {
          print(movies);
          return FavoriteMovieCardWidget(movie: movies[index]);
        },
      ),
    );
  }
}
