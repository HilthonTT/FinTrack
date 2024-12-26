import 'package:fintrack_app/core/constants/exceptions.dart';
import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/features/expenses/data/datasources/expense_remote_data_source.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/domain/enums/expense_category.dart';
import 'package:fintrack_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

final class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remoteDataSource;

  const ExpenseRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> create({
    required String name,
    required double amount,
    required String currencyCode,
    required ExpenseCategory category,
    required Company company,
    required DateTime date,
  }) async {
    try {
      final expenseId = await remoteDataSource.create(
        name: name,
        amount: amount,
        currencyCode: currencyCode,
        category: category,
        company: company,
        date: date,
      );

      return right(expenseId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> delete({required String id}) async {
    try {
      await remoteDataSource.delete(id: id);

      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> getAll({int take = 10}) async {
    try {
      final expenses = await remoteDataSource.getAll(take: take);

      return right(expenses);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Expense>> getById({required String id}) async {
    try {
      final expense = await remoteDataSource.getById(id: id);

      return right(expense);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> update({
    required String id,
    required String name,
    required double amount,
    required DateTime date,
  }) async {
    try {
      await remoteDataSource.update(
        id: id,
        name: name,
        amount: amount,
        date: date,
      );

      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
