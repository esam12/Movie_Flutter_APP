import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/presentation/widgets/button.dart';
import 'package:wiredash/wiredash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.errorType,
    required this.onPressed,
  });

  final AppErrorType errorType;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            errorType == AppErrorType.api
                ? TranslationConstants.somethingWentWrong.t(context)
                : TranslationConstants.checkNetwork.t(context),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          ),
          SizedBox(height: Sizes.dimen_16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                title: TranslationConstants.retry,
                onTap: onPressed,
              ),
              SizedBox(width: Sizes.dimen_16.w),
              Button(
                title: TranslationConstants.feedback,
                onTap: () => Wiredash.of(context).show(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
