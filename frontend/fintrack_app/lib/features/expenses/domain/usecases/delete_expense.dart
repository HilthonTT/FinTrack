import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

final class DeleteExpense implements UseCase<Unit, DeleteExpenseCommand> {
  final ExpenseRepository expenseRepository;

  const DeleteExpense(this.expenseRepository);

  @override
  Future<Either<Failure, Unit>> call(DeleteExpenseCommand params) async {
    return await expenseRepository.delete(id: params.expenseId);
  }
}

final class DeleteExpenseCommand {
  final String expenseId;

  const DeleteExpenseCommand({required this.expenseId});
}
