import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/providers/states/login_states.dart';
import 'package:projects/repository/auth_repository.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this._ref) : super(const LoginStateInitial());

  final Ref _ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();

    try {
      _ref.read(authRepositoryProvider);
      state = const LoginStateSuccess();
    } catch (exception) {
      state = LoginStateError(exception.toString());
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
