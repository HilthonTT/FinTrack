import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetSubscriptions
    implements UseCase<List<Subscription>, GetSubscriptionsQuery> {
  final SubscriptionRepository subscriptionRepository;

  const GetSubscriptions(this.subscriptionRepository);

  @override
  Future<Either<Failure, List<Subscription>>> call(
    GetSubscriptionsQuery params,
  ) async {
    return subscriptionRepository.get(
      searchTerm: params.searchTerm,
      take: params.take,
    );
  }
}

final class GetSubscriptionsQuery {
  final String? searchTerm;
  final int take;

  const GetSubscriptionsQuery({this.searchTerm, this.take = 10});
}
