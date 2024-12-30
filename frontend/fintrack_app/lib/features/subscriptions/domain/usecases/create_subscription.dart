import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/frequency.dart';
import 'package:fintrack_app/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:fpdart/fpdart.dart';

final class CreateSubscription
    implements UseCase<Subscription, CreateSubscriptionCommand> {
  final SubscriptionRepository subscriptionRepository;

  const CreateSubscription(this.subscriptionRepository);

  @override
  Future<Either<Failure, Subscription>> call(
    CreateSubscriptionCommand params,
  ) async {
    return await subscriptionRepository.create(
      name: params.name,
      amount: params.amount,
      currency: params.currency,
      frequency: params.frequency,
      company: params.company,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

final class CreateSubscriptionCommand {
  final String name;
  final double amount;
  final String currency;
  final Frequency frequency;
  final Company company;
  final String startDate;
  final String endDate;

  const CreateSubscriptionCommand({
    required this.name,
    required this.amount,
    required this.currency,
    required this.frequency,
    required this.company,
    required this.startDate,
    required this.endDate,
  });
}
