part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthLoggedIn extends AuthState {
  final User user;

  const AuthLoggedIn(this.user);
}

final class AuthRegistered extends AuthState {
  const AuthRegistered();
}

final class AuthEmailVerified extends AuthState {
  const AuthEmailVerified();
}

final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}
