import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.title, this.onTap});

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColor.royalBlue,
            AppColor.violet,
          ],
        ),
        borderRadius: BorderRadius.circular(Sizes.dimen_20.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      child: TextButton(
        onPressed: onTap,
        child: Text(title.t(context),
            style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
