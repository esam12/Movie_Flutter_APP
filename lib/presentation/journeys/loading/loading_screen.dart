import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/presentation/blocs/loading/loading_bloc.dart';
import 'package:movieapp/presentation/journeys/loading/loading_circle.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, required this.screen});

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            screen,
            if (state is LoadingStarted)
              Container(
                decoration: BoxDecoration(
                  color: AppColor.vulcan.withOpacity(0.8),
                ),
                child: Center(
                  child: LoadingCircle(size: Sizes.dimen_200.w),
                ),
              ),
          ],
        );
      },
    );
  }
}
