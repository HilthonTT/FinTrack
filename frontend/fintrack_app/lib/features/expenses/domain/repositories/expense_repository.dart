import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/domain/enums/expense_category.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ExpenseRepository {
  Future<Either<Failure, Expense>> getById({required String id});

  Future<Either<Failure, List<Expense>>> getAll({int take = 10});

  Future<Either<Failure, String>> create({
    required String name,
    required double amount,
    required String currencyCode,
    required ExpenseCategory category,
    required Company company,
    required DateTime date,
  });

  Future<Either<Failure, Unit>> update({
    required String id,
    required String name,
    required double amount,
    required DateTime date,
  });

  Future<Either<Failure, Unit>> delete({required String id});
}
