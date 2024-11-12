import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/presentation/blocs/favorite/favorite_bloc.dart';

class MovieDetailAppBar extends StatelessWidget {
  const MovieDetailAppBar({super.key, required this.movieDetailEntity});
  final MovieDetailEntity movieDetailEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: Sizes.dimen_18.h,
          ),
        ),
        BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
          if (state is IsFavoriteMovie) {
            return GestureDetector(
              onTap: () => BlocProvider.of<FavoriteBloc>(context).add(
                ToggleFavoriteMovieEvent(
                  movie: MovieEntity.fromMovieDetailEntity(movieDetailEntity),
                  isFavorite: state.isFavorite,
                ),
              ),
              child: Icon(
                state.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: Sizes.dimen_18.h,
              ),
            );
          } else {
            return Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: Sizes.dimen_18.h,
            );
          }
        })
      ],
    );
  }
}
