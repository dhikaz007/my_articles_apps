import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'data/repositories/articles_repository.dart';
import 'data/repositories/auth_repository.dart';
import 'logic/bloc/article_bloc.dart';
import 'logic/cubit/auth_cubit.dart';
import 'logic/cubit/password_visibility_cubit.dart';
import 'routes/app_routes.dart';

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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/login');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthCubit(authRepositoryImpl: AuthRepositoryImpl()),
        ),
        BlocProvider(create: (context) => PasswordVisibilityCubit()),
        BlocProvider(
          create: (context) =>
              ArticleBloc(articlesRepositoryImpl: ArticlesRepositoryImpl())
                ..add(
                  GetArticle(),
                ),
        ),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeAnimationCurve: Curves.easeInOut,
          theme: ThemeData(fontFamily: 'Inter'),
          routerConfig: Modular.routerConfig,
        ),
      ),
    );
  }
}
