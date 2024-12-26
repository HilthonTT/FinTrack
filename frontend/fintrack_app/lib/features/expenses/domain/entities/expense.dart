import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/features/expenses/domain/enums/expense_category.dart';

class Expense {
  final String id;
  final String userId;
  final String name;
  final double amount;
  final String currency;
  final Company company;
  final ExpenseCategory category;
  final DateTime date;
  final DateTime createdOnUtc;
  final DateTime? modifiedOnUtc;

  const Expense({
    required this.id,
    required this.userId,
    required this.name,
    required this.amount,
    required this.currency,
    required this.company,
    required this.category,
    required this.date,
    required this.createdOnUtc,
    required this.modifiedOnUtc,
  });
}
