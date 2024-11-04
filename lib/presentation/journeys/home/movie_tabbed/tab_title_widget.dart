import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabTitleWidget extends StatelessWidget {
  const TabTitleWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  })  : assert(title != null, 'title must not be null'),
        assert(onTap != null, 'onTap must not be null'),
        assert(isSelected != null, 'isSelected must not be null');

  final String? title;
  final Function()? onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
                color: isSelected! ? AppColor.royalBlue : Colors.transparent,
                width: Sizes.dimen_1.h),
          ),
        ),
        child: Text(
          title ?? '',
          style: isSelected!
              ? Theme.of(context).textTheme.royalBlueSubtitle1
              : Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
