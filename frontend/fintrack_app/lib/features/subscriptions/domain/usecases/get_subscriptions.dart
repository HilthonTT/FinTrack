import 'package:fintrack_app/core/entities/paged_list.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetSubscriptions
    implements UseCase<PagedList<Subscription>, GetSubscriptionsQuery> {
  final SubscriptionRepository subscriptionRepository;

  const GetSubscriptions(this.subscriptionRepository);

  @override
  Future<Either<Failure, PagedList<Subscription>>> call(
    GetSubscriptionsQuery params,
  ) async {
    return subscriptionRepository.get(
      searchTerm: params.searchTerm,
      pageSize: params.pageSize,
    );
  }
}

final class GetSubscriptionsQuery {
  final String? searchTerm;
  final int pageSize;

  const GetSubscriptionsQuery({this.searchTerm, this.pageSize = 10});
}
