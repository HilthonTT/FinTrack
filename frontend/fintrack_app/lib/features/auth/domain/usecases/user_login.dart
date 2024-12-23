import 'package:fintrack_app/core/entities/user.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

final class UserLogin implements UseCase<User, UserLoginCommand> {
  final AuthRepository authRepository;

  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> handle(UserLoginCommand params) {
    return authRepository.login(email: params.email, password: params.password);
  }
}

final class UserLoginCommand {
  final String email;
  final String password;

  const UserLoginCommand({
    required this.email,
    required this.password,
  });
}
