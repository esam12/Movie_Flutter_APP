import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/app_localizations.dart';
import 'package:movieapp/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp/presentation/blocs/loading/loading_bloc.dart';
import 'package:movieapp/presentation/blocs/login/login_bloc.dart';
import 'package:movieapp/presentation/fade_page_route_builder.dart';
import 'package:movieapp/presentation/journeys/loading/loading_screen.dart';
import 'package:movieapp/presentation/routes.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
import 'package:movieapp/presentation/wiredash_app.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageBloc _languageBloc;
  late LoginBloc _loginBloc;
  late LoadingBloc _loadingBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _loginBloc = getItInstance<LoginBloc>();
    _loadingBloc = getItInstance<LoadingBloc>();
    _languageBloc.add(LoadPreferredLanguageEvent());
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loginBloc.close();
    _loadingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: _languageBloc),
        BlocProvider<LoginBloc>.value(value: _loginBloc),
        BlocProvider<LoadingBloc>.value(value: _loadingBloc),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocProvider<LanguageBloc>.value(
            value: _languageBloc,
            child: BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                if (state is LanguageLoaded) {
                  return WiredashApp(
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Movie App',
                      theme: ThemeData(
                        primaryColor: AppColor.vulcan,
                        colorScheme: const ColorScheme.dark(),
                        scaffoldBackgroundColor: AppColor.vulcan,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        textTheme: ThemeText.getTextTheme(),
                        appBarTheme: const AppBarTheme(elevation: 0),
                      ),
                      supportedLocales: Languages.languages
                          .map((e) => Locale(e.code))
                          .toList(),
                      locale: state.locale,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      builder: (context, child) {
                        return LoadingScreen(screen: child!);
                      },
                      initialRoute: RouteList.initial,
                      onGenerateRoute: (RouteSettings settings) {
                        final routes = Routes.getRoutes(settings);
                        final WidgetBuilder builder =
                            routes[settings.name] ?? routes[RouteList.initial]!;
                        return FadePageRouteBuilder(
                          builder: builder,
                          settings: settings,
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
