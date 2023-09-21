part of 'routes.dart';

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
        user: r.args.data,
      ),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 800),
    );
    r.child(
      '/select-language',
      child: (_) => const SelectLanguagePage(),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 800),
    );
  }
}
