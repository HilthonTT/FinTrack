part of 'subscriptions_bloc.dart';

@immutable
sealed class SubscriptionsEvent {
  const SubscriptionsEvent();
}

final class CancelSubscriptionsEvent extends SubscriptionsEvent {
  final String subscriptionId;

  const CancelSubscriptionsEvent({required this.subscriptionId});
}

final class CreateSubscriptionsEvent extends SubscriptionsEvent {
  final String name;
  final double amount;
  final String currency;
  final Frequency frequency;
  final Company company;
  final String startDate;
  final String endDate;

  const CreateSubscriptionsEvent({
    required this.name,
    required this.amount,
    required this.currency,
    required this.frequency,
    required this.company,
    required this.startDate,
    required this.endDate,
  });
}

final class UpdateSubscriptionsEvent extends SubscriptionsEvent {
  final String subscriptionId;
  final String name;
  final Frequency frequency;
  final Company company;

  const UpdateSubscriptionsEvent({
    required this.subscriptionId,
    required this.name,
    required this.frequency,
    required this.company,
  });
}

final class DeleteSubscriptionsEvent extends SubscriptionsEvent {
  final String subscriptionId;

  const DeleteSubscriptionsEvent({required this.subscriptionId});
}

final class GetSubscriptionsEvent extends SubscriptionsEvent {
  final String? searchTerm;
  final int take;

  const GetSubscriptionsEvent({this.searchTerm, this.take = 10});
}

final class GetByIdSubscriptionsEvent extends SubscriptionsEvent {
  final String subscriptionId;

  const GetByIdSubscriptionsEvent({required this.subscriptionId});
}
