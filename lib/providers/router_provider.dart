import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/providers/login_controller_provider.dart';
import 'package:projects/providers/states/login_states.dart';
import 'package:projects/screens/login_screen.dart';
import 'package:projects/screens/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    routes: router._routes,
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router._redirectLogic,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<LoginState>(
      loginControllerProvider,
      (_, __) => notifyListeners(),
    );
  }

  String? _redirectLogic(GoRouterState state) {
    final loginStates = _ref.read(loginControllerProvider);

    final areWeLoggingIn = state.location == '/login';

    if (loginStates is LoginStateInitial) {
      return areWeLoggingIn ? null : '/login';
    }

    if (loginStates is LoginStateSuccess) {
      if (areWeLoggingIn) {
        return '/home';
      }
    }

    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          name: 'login',
          builder: (context, state) => const LoginScreen(),
          path: '/login',
        ),
        GoRoute(
          name: 'home',
          builder: (context, state) => const HomeScreen(),
          path: '/home',
        )
      ];
}
