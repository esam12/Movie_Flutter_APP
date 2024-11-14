import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';

class MovieTabCartWidget extends StatelessWidget {
  const MovieTabCartWidget({
    super.key,
    required this.movieId,
    required this.title,
    required this.posterPath,
  });
  final int movieId;
  final String title, posterPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteList.movieDetail,
            arguments: MovieDetailArguments(id: movieId));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
              child: CachedNetworkImage(
                imageUrl: '${ApiConstants.baseImageUrl}$posterPath',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_4.h),
            child: Text(
              title.intelliTrim(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
