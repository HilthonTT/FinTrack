import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:fpdart/fpdart.dart';

final class CancelSubscription
    implements UseCase<Subscription, CancelSubscriptionCommand> {
  final SubscriptionRepository subscriptionRepository;

  const CancelSubscription(this.subscriptionRepository);

  @override
  Future<Either<Failure, Subscription>> call(
    CancelSubscriptionCommand params,
  ) async {
    return await subscriptionRepository.cancel(
      subscriptionId: params.subscriptionId,
    );
  }
}

final class CancelSubscriptionCommand {
  final String subscriptionId;

  const CancelSubscriptionCommand({required this.subscriptionId});
}
