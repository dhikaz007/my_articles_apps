import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'constants/constants.dart';
import 'feature/auth/cubit/auth_cubit.dart';
import 'localizations/app_localizations.dart';
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
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.grey.withOpacity(0.8),
        overlayWidgetBuilder: (progress) => Center(
          child: Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryWhite,
            ),
            child: CircularProgressIndicator(
              color: AppColors.primaryGreen,
            ),
          ),
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeAnimationCurve: Curves.easeInOut,
          theme: ThemeData(
            fontFamily: 'Inter',
            useMaterial3: true,
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
          ),
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
          //locale: ReadContext(context).read<LanguageCubit>().locale,
        ),
      ),
    );
  }
}
