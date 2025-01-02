part of 'subscriptions_bloc.dart';

@immutable
sealed class SubscriptionsState {
  const SubscriptionsState();
}

final class SubscriptionsInitial extends SubscriptionsState {
  const SubscriptionsInitial();
}

final class SubscriptionsLoading extends SubscriptionsState {
  const SubscriptionsLoading();
}

final class SubscriptionsFailure extends SubscriptionsState {
  final String error;

  const SubscriptionsFailure(this.error);
}

final class SubscriptionsLoadedSuccess extends SubscriptionsState {
  final PagedList<Subscription> pagedSubscriptions;

  const SubscriptionsLoadedSuccess(this.pagedSubscriptions);
}

final class SubscriptionByIdLoadedSuccess extends SubscriptionsState {
  final Subscription subscription;

  const SubscriptionByIdLoadedSuccess(this.subscription);
}

final class SubscriptionCreatedSuccess extends SubscriptionsState {
  final Subscription subscription;

  const SubscriptionCreatedSuccess(this.subscription);
}

final class SubscriptionDeletedSuccess extends SubscriptionsState {
  const SubscriptionDeletedSuccess();
}

final class SubscriptionUpdatedSuccess extends SubscriptionsState {
  const SubscriptionUpdatedSuccess();
}

final class SubscriptionCancelledSuccess extends SubscriptionsState {
  final Subscription subscription;

  const SubscriptionCancelledSuccess(this.subscription);
}
