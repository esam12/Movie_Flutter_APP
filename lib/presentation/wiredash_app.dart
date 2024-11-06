import 'package:flutter/material.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  const WiredashApp({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'movieapp-w7tfh8c',
      secret: 'aYjzLk7fL8KGqtSTHj_8RsfA3WP_f6FI',
      child: child,
      
      
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.royalBlue,
        secondaryColor: AppColor.violet,
        secondaryBackgroundColor: AppColor.vulcan,
      ),
    );
  }
}
