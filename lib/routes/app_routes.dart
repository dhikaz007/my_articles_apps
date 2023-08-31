import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/home_page/home_page.dart';
import '../presentation/login_page/login_page.dart';

class AppRoutes extends Module {
  @override
  void routes(r) {
    r.child(
      '/login',
      child: (_) => const LoginPage(),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 800),
    );
    r.child(
      '/home',
      child: (_) => HomePage(
        user: Modular.args.data,
      ),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 800),
    );
  }
}
