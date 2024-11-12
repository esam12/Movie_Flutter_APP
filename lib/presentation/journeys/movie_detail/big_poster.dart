import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/num_extensions.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_app_bar.dart';
import 'package:movieapp/presentation/themes/app_color.dart';

class BigPoster extends StatelessWidget {
  const BigPoster({super.key, required this.movie});

  final MovieDetailEntity movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.3),
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
            width: ScreenUtil().screenWidth,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ListTile(
            title: Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: Text(
              movie.releaseDate,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.grey),
            ),
            trailing: Text(
              movie.voteAverage.convertToPercentageString(),
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: AppColor.royalBlue,
                  ),
            ),
          ),
        ),
        Positioned(
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
          top: ScreenUtil().statusBarHeight + Sizes.dimen_6.h,
          child: MovieDetailAppBar(
            movieDetailEntity: movie,
          ),
        )
      ],
    );
  }
}
