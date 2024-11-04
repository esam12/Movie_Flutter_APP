import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/presentation/themes/app_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();
  static TextStyle get _whiteHeadlineMedium =>
      _poppinsTextTheme.headlineMedium!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );
  static TextStyle get whiteTitleMedium =>
      _poppinsTextTheme.titleMedium!.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      );

  static TextStyle get whiteBodyMedium =>
      _poppinsTextTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static getTextTheme() => TextTheme(
        headlineMedium: _whiteHeadlineMedium,
        titleMedium: whiteTitleMedium,
        bodyMedium: whiteBodyMedium,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => titleMedium!.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      );
}