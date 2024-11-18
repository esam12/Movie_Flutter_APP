import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LabelFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;
  final UnderlineInputBorder _enabledBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );

  final UnderlineInputBorder _focusedBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
  );

  const LabelFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    this.isPasswordField = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.start,
          ),
          TextField(
            obscureText: isPasswordField,
            obscuringCharacter: '*',
            controller: controller,
            style: Theme.of(context).textTheme.titleMedium,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.labelSmall,
              focusedBorder: _focusedBorder,
              enabledBorder: _enabledBorder,
            ),
          ),
         
        ],
      ),
    );
  }
}
