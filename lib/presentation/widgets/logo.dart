import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/presentation/blocs/theme/theme/theme_cubit.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.height})
      : assert(height > 0, 'height must be greater than 0');
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/pngs/logo.png',
        color: context.read<ThemeCubit>().state == Themes.dark
            ? Colors.white
            : AppColor.vulcan,
        height: height.h,
        fit: BoxFit.fitHeight);
  }
}
