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
  }
}
