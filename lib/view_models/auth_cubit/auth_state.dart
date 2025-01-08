part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLeading extends AuthState {}

final class AuthDone extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}

final class AuthLoggedOut extends AuthState {}

final class AuthLogingOut extends AuthState {}

final class AuthLogeOutError extends AuthState {
  final String message;

  AuthLogeOutError(this.message);
}

final class GoogleAuthentitating extends AuthState {}

final class GoogleAuthError extends AuthState {
  final String message;

  GoogleAuthError(this.message);
}

final class GoogleAuthDnoe extends AuthState {}
