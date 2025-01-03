import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/domain/enums/expense_category.dart';

final class ExpenseModel extends Expense {
  const ExpenseModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.amount,
    required super.currency,
    required super.company,
    required super.category,
    required super.date,
    required super.createdOnUtc,
    required super.modifiedOnUtc,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'amount': amount,
      'currency': currency,
      'company': company.index,
      'category': category.index,
      'date': date.toIso8601String(),
      'createdOnUtc': createdOnUtc.toIso8601String(),
      'modifiedOnUtc': modifiedOnUtc?.toIso8601String(),
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      name: map['name'] as String,
      amount: map['amount'] is int
          ? (map['amount'] as int).toDouble() // Convert int to double
          : double.parse(map['amount'] as String), // Parse String to double
      currency: map['currency'] as String,
      company: Company.values[map['company'] as int],
      category: ExpenseCategory.values[map['category'] as int],
      date: DateTime.parse(map['date'] as String),
      createdOnUtc: DateTime.parse(map['createdOnUtc'] as String),
      modifiedOnUtc: map['modifiedOnUtc'] != null
          ? DateTime.parse(map['modifiedOnUtc'] as String)
          : null,
    );
  }

  ExpenseModel copyWith({
    String? id,
    String? userId,
    String? name,
    double? amount,
    String? currency,
    Company? company,
    ExpenseCategory? category,
    DateTime? date,
    DateTime? createdOnUtc,
    DateTime? modifiedOnUtc,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      company: company ?? this.company,
      category: category ?? this.category,
      date: date ?? this.date,
      createdOnUtc: createdOnUtc ?? this.createdOnUtc,
      modifiedOnUtc: modifiedOnUtc ?? this.modifiedOnUtc,
    );
  }
}
