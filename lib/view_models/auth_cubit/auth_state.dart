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
