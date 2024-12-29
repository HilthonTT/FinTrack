import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/features/subscriptions/domain/entities/subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/frequency.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/status.dart';

final class SubscriptionModel extends Subscription {
  const SubscriptionModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.amount,
    required super.currency,
    required super.frequency,
    required super.company,
    required super.periodStart,
    required super.periodEnd,
    required super.nextDueDate,
    required super.status,
    required super.createdOnUtc,
    required super.modifiedOnUtc,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      frequency: Frequency.values[json['frequency'] as int],
      company: Company.values[json['company'] as int],
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: json['periodEnd'] != null
          ? DateTime.parse(json['periodEnd'] as String)
          : DateTime.now(),
      nextDueDate: json['nextDueDate'] != null
          ? DateTime.parse(json['nextDueDate'] as String)
          : DateTime.now(),
      status: Status.values[json['status'] as int],
      createdOnUtc: DateTime.parse(json['createdOnUtc'] as String),
      modifiedOnUtc: json['modifiedOnUtc'] != null
          ? DateTime.parse(json['modifiedOnUtc'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'amount': amount,
      'currency': currency,
      'frequency': frequency.index,
      'company': company.index,
      'periodStart': periodStart,
      'periodEnd': periodEnd,
      'nextDueDate': nextDueDate,
      'status': status.index,
      'createdOnUtc': createdOnUtc.toIso8601String(),
      'modifiedOnUtc': modifiedOnUtc?.toIso8601String(),
    };
  }

  SubscriptionModel copyWith({
    String? id,
    String? userId,
    String? name,
    double? amount,
    String? currency,
    Frequency? frequency,
    Company? company,
    DateTime? periodStart,
    DateTime? periodEnd,
    DateTime? nextDueDate,
    Status? status,
    DateTime? createdOnUtc,
    DateTime? modifiedOnUtc,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      frequency: frequency ?? this.frequency,
      company: company ?? this.company,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      status: status ?? this.status,
      createdOnUtc: createdOnUtc ?? this.createdOnUtc,
      modifiedOnUtc: modifiedOnUtc ?? this.modifiedOnUtc,
    );
  }
}
