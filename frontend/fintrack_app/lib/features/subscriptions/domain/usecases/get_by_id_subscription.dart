import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetByIdSubscription
    implements UseCase<Subscription, GetByIdSubscriptionQuery> {
  final SubscriptionRepository subscriptionRepository;

  const GetByIdSubscription(this.subscriptionRepository);

  @override
  Future<Either<Failure, Subscription>> call(
    GetByIdSubscriptionQuery params,
  ) async {
    return await subscriptionRepository.getById(
      subscriptionId: params.subscriptionId,
    );
  }
}

final class GetByIdSubscriptionQuery {
  final String subscriptionId;

  const GetByIdSubscriptionQuery({required this.subscriptionId});
}
