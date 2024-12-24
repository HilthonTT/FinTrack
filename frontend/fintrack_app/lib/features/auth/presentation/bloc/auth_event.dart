part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const AuthRegister({
    required this.email,
    required this.password,
    required this.name,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({required this.email, required this.password});
}

final class AuthVerifyEmail extends AuthEvent {
  final int code;

  const AuthVerifyEmail({required this.code});
}
