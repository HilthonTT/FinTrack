import 'package:fintrack_app/core/entities/paged_list.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetExpenses
    implements UseCase<PagedList<Expense>, GetExpensesQuery> {
  final ExpenseRepository expenseRepository;

  const GetExpenses(this.expenseRepository);

  @override
  Future<Either<Failure, PagedList<Expense>>> call(
    GetExpensesQuery params,
  ) async {
    return await expenseRepository.getAll(pageSize: params.pageSize);
  }
}

final class GetExpensesQuery {
  final String? searchTerm;
  final int pageSize;

  const GetExpensesQuery({this.searchTerm, this.pageSize = 10});
}
