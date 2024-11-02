import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/movie_app.dart';

Future<void> main() async {
  /// Setup the GetIt
  await init();
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup Screen Util
  await ScreenUtil.ensureScreenSize();

  runApp(const MovieApp());
}

