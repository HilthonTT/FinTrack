import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetExpenses implements UseCase<List<Expense>, GetExpensesQuery> {
  final ExpenseRepository expenseRepository;

  const GetExpenses(this.expenseRepository);

  @override
  Future<Either<Failure, List<Expense>>> call(GetExpensesQuery params) async {
    return await expenseRepository.getAll(take: params.take);
  }
}

final class GetExpensesQuery {
  final int take;

  const GetExpensesQuery({this.take = 10});
}
