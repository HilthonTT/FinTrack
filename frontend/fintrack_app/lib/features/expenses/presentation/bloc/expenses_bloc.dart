import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/domain/enums/expense_category.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/create_expense.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/delete_expense.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/get_expense_by_id.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/get_expenses.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/update_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

final class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final CreateExpense createExpense;
  final DeleteExpense deleteExpense;
  final GetExpenseById getExpenseById;
  final GetExpenses getExpenses;
  final UpdateExpense updateExpense;

  ExpensesBloc({
    required this.createExpense,
    required this.deleteExpense,
    required this.getExpenseById,
    required this.getExpenses,
    required this.updateExpense,
  }) : super(ExpensesInitial()) {
    on<ExpensesEvent>((event, emit) {
      emit(const ExpensesLoading());
    });

    on<ExpenseCreateExpenseEvent>(_createExpense);
    on<ExpenseDeleteExpenseEvent>(_deleteExpense);
    on<ExpenseGetByIdExpenseEvent>(_getExpenseById);
    on<ExpenseGetAllExpensesEvent>(_getExpenses);
    on<ExpenseUpdateExpenseEvent>(_updateExpense);
  }

  Future<void> _createExpense(
    ExpenseCreateExpenseEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    final command = CreateExpenseCommand(
      name: event.name,
      amount: event.amount,
      currencyCode: event.currencyCode,
      category: event.category,
      company: event.company,
      date: event.date,
    );

    final response = await createExpense(command);

    response.fold(
      (failure) => emit(ExpensesFailure(failure.message)),
      (expenseId) => emit(ExpenseCreatedSuccess()),
    );
  }

  Future<void> _deleteExpense(
    ExpenseDeleteExpenseEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    final command = DeleteExpenseCommand(expenseId: event.expenseId);

    final response = await deleteExpense(command);

    response.fold(
      (failure) => emit(ExpensesFailure(failure.message)),
      (_) => emit(ExpenseDeletedSuccess()),
    );
  }

  Future<void> _getExpenseById(
    ExpenseGetByIdExpenseEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    final query = GetExpenseByIdQuery(expenseId: event.expenseId);

    final response = await getExpenseById(query);

    response.fold(
      (failure) => emit(ExpensesFailure(failure.message)),
      (expense) => emit(ExpenseByIdLoadedSuccess(expense)),
    );
  }

  Future<void> _getExpenses(
    ExpenseGetAllExpensesEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    final query = GetExpensesQuery(take: event.take);

    final response = await getExpenses(query);

    response.fold(
      (failure) => emit(ExpensesFailure(failure.message)),
      (expenses) => emit(ExpensesLoadedSuccess(expenses)),
    );
  }

  Future<void> _updateExpense(
    ExpenseUpdateExpenseEvent event,
    Emitter<ExpensesState> emit,
  ) async {
    final command = UpdateExpenseCommand(
      expenseId: event.expenseId,
      name: event.name,
      amount: event.amount,
      date: event.date,
    );

    final response = await updateExpense(command);

    response.fold(
      (failure) => emit(ExpensesFailure(failure.message)),
      (_) => emit(ExpenseUpdatedSuccess()),
    );
  }
}
