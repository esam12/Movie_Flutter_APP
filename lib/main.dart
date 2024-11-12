import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:movieapp/data/tables/movie_table.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/movie_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  /// Setup the GetIt
  await init();
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup Screen Util
  await ScreenUtil.ensureScreenSize();

  /// Get the app document directory
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  /// Hive Init
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieTableAdapter());

  runApp(const MovieApp());
}
