import 'package:fintrack_app/core/constants/exceptions.dart';
import 'package:fintrack_app/core/entities/user.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fintrack_app/features/auth/data/models/user_model.dart';
import 'package:fintrack_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

final class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failure("You aren't logged in."));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );

      return right(UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
      ));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
      );

      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail({required int code}) async {
    try {
      await remoteDataSource.verifyEmail(code: code);

      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
