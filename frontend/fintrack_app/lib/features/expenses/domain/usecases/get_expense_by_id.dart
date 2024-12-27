import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetExpenseById implements UseCase<Expense, GetExpenseByIdQuery> {
  final ExpenseRepository expenseRepository;

  const GetExpenseById(this.expenseRepository);

  @override
  Future<Either<Failure, Expense>> call(GetExpenseByIdQuery params) async {
    return await expenseRepository.getById(id: params.expenseId);
  }
}

final class GetExpenseByIdQuery {
  final String expenseId;

  const GetExpenseByIdQuery({required this.expenseId});
}
