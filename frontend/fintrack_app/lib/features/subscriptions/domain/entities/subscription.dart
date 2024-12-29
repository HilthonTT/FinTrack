import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/frequency.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/status.dart';

class Subscription {
  final String id;
  final String userId;
  final String name;
  final double amount;
  final String currency;
  final Frequency frequency;
  final Company company;
  final DateTime periodStart;
  final DateTime periodEnd;
  final DateTime nextDueDate;
  final Status status;
  final DateTime createdOnUtc;
  final DateTime? modifiedOnUtc;

  const Subscription({
    required this.id,
    required this.userId,
    required this.name,
    required this.amount,
    required this.currency,
    required this.frequency,
    required this.company,
    required this.periodStart,
    required this.periodEnd,
    required this.nextDueDate,
    required this.status,
    required this.createdOnUtc,
    required this.modifiedOnUtc,
  });
}
