import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/localizations/app_localizations.dart';
import 'data/repositories/repositories.dart';
import 'logic/bloc/article_bloc.dart';
import 'logic/cubit/auth_cubit.dart';
import 'logic/cubit/language_cubit.dart';
import 'logic/cubit/password_visibility_cubit.dart';
import 'presentation/login_page/screens.dart';
import 'routes/routes.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    ModularApp(
      module: AppRoutes(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? code;
  String? countryCode;

  @override
  void initState() {
    getCode();
    super.initState();
  }

  void getCode() async {
    code = await LanguageStorage.getCode();
    countryCode = await LanguageStorage.getCountryCode();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/login');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AuthCubit(authRepositoryImpl: AuthRepositoryImpl())),
        BlocProvider(create: (context) => PasswordVisibilityCubit()),
        BlocProvider(
            create: (context) =>
                ArticleBloc(articlesRepositoryImpl: ArticlesRepositoryImpl())
                  ..add(GetArticle())),
        BlocProvider(create: (context) => LanguageCubit()),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) =>
            BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            if (state is LanguageInitial) {
              if (code != null) {
                ReadContext(context)
                    .read<LanguageCubit>()
                    .setLanguage(Locale(code ?? '', countryCode ?? ''));
              }
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                themeAnimationCurve: Curves.easeInOut,
                theme: ThemeData(fontFamily: 'Inter'),
                routerConfig: Modular.routerConfig,
                localizationsDelegates: const [
                  //* Add localization to app
                  AppLocalizations
                      .delegate, //* build in terminal flutter gen-l10n
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('id', 'ID'),
                ],
                locale: ReadContext(context).read<LanguageCubit>().locale,
              );
            }
            if (state is ChangeLanguageSuccess) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                themeAnimationCurve: Curves.easeInOut,
                theme: ThemeData(fontFamily: 'Inter'),
                routerConfig: Modular.routerConfig,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('id', 'ID'),
                ],
                locale: ReadContext(context).read<LanguageCubit>().locale,
              );
            }
            return const MaterialApp(
              home: LoginPage(),
            );
          },
        ),
      ),
    );
  }
}
