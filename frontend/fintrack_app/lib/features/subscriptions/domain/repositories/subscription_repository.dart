import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/frequency.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SubscriptionRepository {
  Future<Either<Failure, Subscription>> cancel({
    required String subscriptionId,
  });

  Future<Either<Failure, Subscription>> create({
    required String name,
    required double amount,
    required String currency,
    required Frequency frequency,
    required Company company,
    required String startDate,
    required String endDate,
  });

  Future<Either<Failure, Unit>> delete({required String subscriptionId});

  Future<Either<Failure, List<Subscription>>> get({
    String? searchTerm,
    int take = 10,
  });

  Future<Either<Failure, Subscription>> getById({
    required String subscriptionId,
  });

  Future<Either<Failure, Subscription>> update({
    required String subscriptionId,
    required String name,
    required Frequency frequency,
    required Company company,
  });
}
