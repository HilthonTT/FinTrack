import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

final class NoParams {
  const NoParams();
}
