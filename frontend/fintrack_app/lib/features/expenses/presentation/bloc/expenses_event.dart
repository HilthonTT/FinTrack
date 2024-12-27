part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesEvent {
  const ExpensesEvent();
}

final class ExpenseCreateExpenseEvent extends ExpensesEvent {
  final String name;
  final double amount;
  final String currencyCode;
  final ExpenseCategory category;
  final Company company;
  final DateTime date;

  const ExpenseCreateExpenseEvent({
    required this.name,
    required this.amount,
    required this.currencyCode,
    required this.category,
    required this.company,
    required this.date,
  });
}

final class ExpenseDeleteExpenseEvent extends ExpensesEvent {
  final String expenseId;

  const ExpenseDeleteExpenseEvent({required this.expenseId});
}

final class ExpenseGetByIdExpenseEvent extends ExpensesEvent {
  final String expenseId;

  const ExpenseGetByIdExpenseEvent({required this.expenseId});
}

final class ExpenseGetAllExpensesEvent extends ExpensesEvent {
  final int take;

  const ExpenseGetAllExpensesEvent({required this.take});
}

final class ExpenseUpdateExpenseEvent extends ExpensesEvent {
  final String expenseId;
  final String name;
  final double amount;
  final DateTime date;

  const ExpenseUpdateExpenseEvent({
    required this.expenseId,
    required this.name,
    required this.amount,
    required this.date,
  });
}
