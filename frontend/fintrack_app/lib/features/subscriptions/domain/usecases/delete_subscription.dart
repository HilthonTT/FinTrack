import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:fpdart/fpdart.dart';

final class DeleteSubscription
    implements UseCase<Unit, DeleteSubscriptionCommand> {
  final SubscriptionRepository subscriptionRepository;

  const DeleteSubscription(this.subscriptionRepository);

  @override
  Future<Either<Failure, Unit>> call(DeleteSubscriptionCommand params) async {
    return await subscriptionRepository.delete(
      subscriptionId: params.subscriptionId,
    );
  }
}

final class DeleteSubscriptionCommand {
  final String subscriptionId;

  const DeleteSubscriptionCommand({required this.subscriptionId});
}
