import 'package:fintrack_app/core/entities/user.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Unit>> register({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();

  Future<Either<Failure, Unit>> verifyEmail({required int code});
}
