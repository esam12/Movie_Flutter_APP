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
import 'package:movieapp/presentation/blocs/theme/theme/theme_cubit.dart';
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
  late ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _loginBloc = getItInstance<LoginBloc>();
    _loadingBloc = getItInstance<LoadingBloc>();
    _themeCubit = getItInstance<ThemeCubit>();
    _languageBloc.add(LoadPreferredLanguageEvent());
    _themeCubit.loadPreferredTheme();
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loginBloc.close();
    _loadingBloc.close();
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: _languageBloc),
        BlocProvider<LoginBloc>.value(value: _loginBloc),
        BlocProvider<LoadingBloc>.value(value: _loadingBloc),
        BlocProvider<ThemeCubit>.value(value: _themeCubit)
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocBuilder<ThemeCubit, Themes>(
            builder: (context, theme) {
              print(theme);
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
                            brightness: theme == Themes.dark
                                ? Brightness.dark
                                : Brightness.light,
                            colorScheme: theme == Themes.dark
                                ? const ColorScheme.dark(
                                    primary: Colors
                                        .blue, // Customize colors for dark mode
                                    secondary: Colors.green,
                                  )
                                : const ColorScheme.light(
                                    primary: Colors
                                        .blue, // Customize colors for light mode
                                    secondary: Colors.green,
                                  ),
                            primaryColor: theme == Themes.dark
                                ? AppColor.vulcan
                                : Colors.white,
                            //colorScheme: const ColorScheme.dark(),
                            scaffoldBackgroundColor: theme == Themes.dark
                                ? AppColor.vulcan
                                : Colors.white,
                            cardTheme: CardTheme(
                              color: theme == Themes.dark
                                  ? Colors.white
                                  : AppColor.vulcan,
                            ),
                            inputDecorationTheme: InputDecorationTheme(
                              hintStyle: Theme.of(context).textTheme.bodySmall,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme == Themes.dark
                                      ? Colors.white
                                      : AppColor.vulcan,
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
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
                                routes[settings.name] ??
                                    routes[RouteList.initial]!;
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
          );
        },
      ),
    );
  }
}
