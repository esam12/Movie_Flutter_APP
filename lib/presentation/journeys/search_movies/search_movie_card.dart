import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchMovieCard extends StatelessWidget {
  const SearchMovieCard({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              movieDetailArguments: MovieDetailArguments(
                id: movie.id,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_16.w, vertical: Sizes.dimen_2.h),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(
                Sizes.dimen_8.w,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.dimen_4.w),
                child: CachedNetworkImage(
                  imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
                  width: Sizes.dimen_100.w,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: Sizes.dimen_4.h),
                  Text(
                    movie.overview,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.white60),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
