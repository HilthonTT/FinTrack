import 'package:fintrack_app/core/entities/paged_list.dart';
import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/frequency.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/cancel_subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/create_subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/delete_subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/get_by_id_subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/get_subscriptions.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/update_subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subscriptions_event.dart';
part 'subscriptions_state.dart';

final class SubscriptionsBloc
    extends Bloc<SubscriptionsEvent, SubscriptionsState> {
  final CancelSubscription cancelSubscription;
  final CreateSubscription createSubscription;
  final DeleteSubscription deleteSubscription;
  final GetByIdSubscription getByIdSubscription;
  final GetSubscriptions getSubscriptions;
  final UpdateSubscription updateSubscription;

  SubscriptionsBloc({
    required this.cancelSubscription,
    required this.createSubscription,
    required this.deleteSubscription,
    required this.getByIdSubscription,
    required this.getSubscriptions,
    required this.updateSubscription,
  }) : super(const SubscriptionsInitial()) {
    on<SubscriptionsEvent>((event, emit) {
      emit(const SubscriptionsLoading());
    });

    on<CancelSubscriptionsEvent>(_onCancelSubscription);

    on<CreateSubscriptionsEvent>(_onCreateSubscription);

    on<DeleteSubscriptionsEvent>(_onDeleteSubscription);

    on<GetByIdSubscriptionsEvent>(_onGetByIdSubscription);

    on<GetSubscriptionsEvent>(_onGetSubscriptions);
  }

  Future<void> _onCancelSubscription(
    CancelSubscriptionsEvent event,
    Emitter<SubscriptionsState> emit,
  ) async {
    final command = CancelSubscriptionCommand(
      subscriptionId: event.subscriptionId,
    );

    final response = await cancelSubscription(command);

    response.fold(
      (failure) => emit(SubscriptionsFailure(failure.message)),
      (subscription) => emit(SubscriptionCancelledSuccess(subscription)),
    );
  }

  Future<void> _onCreateSubscription(
    CreateSubscriptionsEvent event,
    Emitter<SubscriptionsState> emit,
  ) async {
    final command = CreateSubscriptionCommand(
      name: event.name,
      amount: event.amount,
      currency: event.currency,
      frequency: event.frequency,
      company: event.company,
      startDate: event.startDate,
      endDate: event.endDate,
    );

    final response = await createSubscription(command);

    response.fold(
      (failure) => emit(SubscriptionsFailure(failure.message)),
      (subscription) => emit(SubscriptionCreatedSuccess(subscription)),
    );
  }

  Future<void> _onDeleteSubscription(
    DeleteSubscriptionsEvent event,
    Emitter<SubscriptionsState> emit,
  ) async {
    final command = DeleteSubscriptionCommand(
      subscriptionId: event.subscriptionId,
    );

    final response = await deleteSubscription(command);

    response.fold(
      (failure) => emit(SubscriptionsFailure(failure.message)),
      (_) => emit(const SubscriptionDeletedSuccess()),
    );
  }

  Future<void> _onGetByIdSubscription(
    GetByIdSubscriptionsEvent event,
    Emitter<SubscriptionsState> emit,
  ) async {
    final query = GetByIdSubscriptionQuery(
      subscriptionId: event.subscriptionId,
    );

    final response = await getByIdSubscription(query);

    response.fold(
      (failure) => emit(SubscriptionsFailure(failure.message)),
      (subscription) => emit(SubscriptionByIdLoadedSuccess(subscription)),
    );
  }

  Future<void> _onGetSubscriptions(
    GetSubscriptionsEvent event,
    Emitter<SubscriptionsState> emit,
  ) async {
    final query = GetSubscriptionsQuery(
      searchTerm: event.searchTerm,
      pageSize: event.take,
    );

    final response = await getSubscriptions(query);

    response.fold(
      (failure) => emit(SubscriptionsFailure(failure.message)),
      (subscriptions) => emit(SubscriptionsLoadedSuccess(subscriptions)),
    );
  }
}
