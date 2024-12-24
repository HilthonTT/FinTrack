import 'package:fintrack_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fintrack_app/core/entities/user.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/features/auth/domain/usecases/user_email_verify.dart';
import 'package:fintrack_app/features/auth/domain/usecases/user_login.dart';
import 'package:fintrack_app/features/auth/domain/usecases/user_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'auth_event.dart';
part 'auth_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUserCubit appUserCubit;
  final UserRegister userRegister;
  final UserLogin userLogin;
  final UserEmailVerify userEmailVerify;

  AuthBloc({
    required this.userRegister,
    required this.userLogin,
    required this.appUserCubit,
    required this.userEmailVerify,
  }) : super(const AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));

    on<AuthRegister>(_onAuthRegister);
    on<AuthLogin>(_onAuthLogin);
    on<AuthVerifyEmail>(_onAuthEmailVerify);
  }

  Future<void> _onAuthRegister(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    final command = UserRegisterCommand(
      email: event.email,
      password: event.password,
      name: event.name,
    );

    final response = await userRegister(command);

    await _handleResponse(
      response,
      emit,
      successState: const AuthRegistered(),
      failureAction: (message) => AuthFailure(message),
    );
  }

  Future<void> _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final command = UserLoginCommand(
      email: event.email,
      password: event.password,
    );

    final response = await userLogin(command);

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        appUserCubit.updateUser(user);
        emit(AuthLoggedIn(user));
      },
    );
  }

  Future<void> _onAuthEmailVerify(
    AuthVerifyEmail event,
    Emitter<AuthState> emit,
  ) async {
    final command = UserEmailVerifyCommand(event.code);

    final response = await userEmailVerify(command);

    await _handleResponse(
      response,
      emit,
      successState: const AuthEmailVerified(),
      failureAction: (message) => AuthFailure(message),
    );
  }

  Future<void> _handleResponse<T>(
    Either<Failure, T> response,
    Emitter<AuthState> emit, {
    required AuthState successState,
    required AuthState Function(String) failureAction,
  }) async {
    response.fold(
      (failure) => emit(failureAction(failure.message)),
      (_) => emit(successState),
    );
  }
}
