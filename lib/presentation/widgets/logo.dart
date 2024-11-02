import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.height})
      : assert(height > 0, 'height must be greater than 0');
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/pngs/logo.png',
        color: Colors.white, height: height.h, fit: BoxFit.fitHeight);
  }
}
