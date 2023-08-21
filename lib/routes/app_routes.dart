import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/home_page/home_main.dart';
import '../presentation/login_page/login_main.dart';

class AppRoutes extends Module {
  @override
  void routes(r) {
    r.child(
      '/login',
      child: (_) => const LoginMain(),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 800),
    );
    r.child(
      '/home',
      child: (_) => const HomeMain(),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 800),
    );
  }
}
