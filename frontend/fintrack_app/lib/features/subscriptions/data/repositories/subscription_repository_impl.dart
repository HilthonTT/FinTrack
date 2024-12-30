import 'package:fintrack_app/core/constants/error_messages.dart';
import 'package:fintrack_app/core/constants/exceptions.dart';
import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/network/connection_checker.dart';
import 'package:fintrack_app/features/subscriptions/data/datasources/subscription_remote_datasource.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/frequency.dart';
import 'package:fintrack_app/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:fpdart/fpdart.dart';

final class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDatasource remoteDatasource;
  final ConnectionChecker connectionChecker;

  const SubscriptionRepositoryImpl(
    this.remoteDatasource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Subscription>> cancel({
    required String subscriptionId,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(ErrorMessages.noInternetConnection));
      }

      await remoteDatasource.cancel(subscriptionId: subscriptionId);

      final subscription = await remoteDatasource.getById(
        subscriptionId: subscriptionId,
      );

      return right(subscription);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Subscription>> create({
    required String name,
    required double amount,
    required String currency,
    required Frequency frequency,
    required Company company,
    required String startDate,
    required String endDate,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(ErrorMessages.noInternetConnection));
      }

      final subscriptionId = await remoteDatasource.create(
        name: name,
        amount: amount,
        currency: currency,
        frequency: frequency,
        company: company,
        startDate: startDate,
        endDate: endDate,
      );

      final subscription = await remoteDatasource.getById(
        subscriptionId: subscriptionId,
      );

      return right(subscription);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> delete({required String subscriptionId}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(ErrorMessages.noInternetConnection));
      }

      await remoteDatasource.delete(subscriptionId: subscriptionId);

      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Subscription>>> get({
    String? searchTerm,
    int take = 10,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(ErrorMessages.noInternetConnection));
      }

      final subscriptions = await remoteDatasource.get(
        searchTerm: searchTerm,
        take: take,
      );

      return right(subscriptions);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Subscription>> getById({
    required String subscriptionId,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(ErrorMessages.noInternetConnection));
      }

      final subscription = await remoteDatasource.getById(
        subscriptionId: subscriptionId,
      );

      return right(subscription);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Subscription>> update({
    required String subscriptionId,
    required String name,
    required Frequency frequency,
    required Company company,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(ErrorMessages.noInternetConnection));
      }

      await remoteDatasource.update(
        subscriptionId: subscriptionId,
        name: name,
        frequency: frequency,
        company: company,
      );

      final subscription = await remoteDatasource.getById(
        subscriptionId: subscriptionId,
      );

      return right(subscription);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
