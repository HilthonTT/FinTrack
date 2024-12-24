import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

final class UserEmailVerify implements UseCase<Unit, UserEmailVerifyCommand> {
  final AuthRepository authRepository;

  const UserEmailVerify(this.authRepository);

  @override
  Future<Either<Failure, Unit>> call(UserEmailVerifyCommand command) {
    return authRepository.verifyEmail(code: command.code);
  }
}

final class UserEmailVerifyCommand {
  final int code;

  const UserEmailVerifyCommand(this.code);
}
