part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesState {
  const ExpensesState();
}

final class ExpensesInitial extends ExpensesState {
  const ExpensesInitial();
}

final class ExpensesLoading extends ExpensesState {
  const ExpensesLoading();
}

final class ExpensesFailure extends ExpensesState {
  final String error;

  const ExpensesFailure(this.error);
}

final class ExpensesLoadedSuccess extends ExpensesState {
  final PagedList<Expense> pagedExpenses;

  const ExpensesLoadedSuccess(this.pagedExpenses);
}

final class ExpenseByIdLoadedSuccess extends ExpensesState {
  final Expense expense;

  const ExpenseByIdLoadedSuccess(this.expense);
}

final class ExpenseCreatedSuccess extends ExpensesState {
  const ExpenseCreatedSuccess();
}

final class ExpenseDeletedSuccess extends ExpensesState {
  const ExpenseDeletedSuccess();
}

final class ExpenseUpdatedSuccess extends ExpensesState {
  const ExpenseUpdatedSuccess();
}
