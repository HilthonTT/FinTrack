import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/frequency.dart';
import 'package:fintrack_app/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:fpdart/fpdart.dart';

final class UpdateSubscription
    implements UseCase<Subscription, UpdateSubscriptionCommand> {
  final SubscriptionRepository subscriptionRepository;

  const UpdateSubscription(this.subscriptionRepository);

  @override
  Future<Either<Failure, Subscription>> call(
    UpdateSubscriptionCommand params,
  ) async {
    return await subscriptionRepository.update(
      subscriptionId: params.subscriptionId,
      name: params.name,
      frequency: params.frequency,
      company: params.company,
    );
  }
}

final class UpdateSubscriptionCommand {
  final String subscriptionId;
  final String name;
  final Frequency frequency;
  final Company company;

  const UpdateSubscriptionCommand({
    required this.subscriptionId,
    required this.name,
    required this.frequency,
    required this.company,
  });
}
