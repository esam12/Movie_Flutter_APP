import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';

class FavoriteMovieCardWidget extends StatelessWidget {
  const FavoriteMovieCardWidget({super.key, required this.movie});
  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.dimen_8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(RouteList.movieDetail,
              arguments: MovieDetailArguments(id: movie.id));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => BlocProvider.of<FavoriteBloc>(context).add(
                    DeleteFavoriteMovieEvent(movieId: movie.id),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.dimen_12.w),
                    child: Container(
                      padding: EdgeInsets.all(Sizes.dimen_4.w),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.delete,
                        size: Sizes.dimen_16.h,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
