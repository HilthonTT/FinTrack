import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

final class UserRegister implements UseCase<Unit, UserRegisterCommand> {
  final AuthRepository authRepository;

  const UserRegister(this.authRepository);

  @override
  Future<Either<Failure, Unit>> handle(UserRegisterCommand params) {
    return authRepository.register(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

final class UserRegisterCommand {
  final String email;
  final String password;
  final String name;

  const UserRegisterCommand({
    required this.email,
    required this.password,
    required this.name,
  });
}
