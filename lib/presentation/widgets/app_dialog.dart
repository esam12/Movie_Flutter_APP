import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/presentation/widgets/button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.image,
  });

  final String title, description, buttonText;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.vulcan,
      elevation: Sizes.dimen_32,
      insetPadding: EdgeInsets.all(Sizes.dimen_32.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_16.w, vertical: Sizes.dimen_16.h),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: AppColor.vulcan,
              blurRadius: Sizes.dimen_16,
            )
          ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.t(context),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: Sizes.dimen_6.h),
              Text(
                description.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: Sizes.dimen_16.h),
              image,
              SizedBox(height: Sizes.dimen_16.h),
              Button(
                title: TranslationConstants.okay,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
