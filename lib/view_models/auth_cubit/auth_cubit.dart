import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthServices authServices = AuthSrevicesImpl();
  Future<void> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(AuthLeading());
    try {
      final result =
          await authServices.loginWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthDone());
      } else {
        emit(AuthError('Login feiled'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(AuthLeading());
    try {
      final result = await authServices.registerWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        emit(AuthDone());
      } else {
        emit(AuthError('Register feiled'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void checkAuth() {
    final user = authServices.currentUser();
    if (user != null) {
      emit(AuthDone());
    }
  }

  Future<void> logOut() async {
    emit(AuthLogingOut());
    try {
      await authServices.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthLogeOutError(e.toString()));
    }
  }

  Future<void> authenticateWithGoogle() async {
    emit(GoogleAuthentitating());
    try {
      final result = await authServices.authWithGoogle();
      if (result) {
        emit(GoogleAuthDnoe());
      } else {
        emit(GoogleAuthError('Google authentication faild'));
      }
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }

  Future<void> authenticateWithFacebook() async {
    emit(FacebookAuthentitating());
    try {
      final result = await authServices.authWithFacebook();
      if (result) {
        emit(FacebookAuthDnoe());
      } else {
        emit(FacebookAuthError('Facebook authentication faild'));
      }
    } catch (e) {
      emit(FacebookAuthError(e.toString()));
    }
  }
}
