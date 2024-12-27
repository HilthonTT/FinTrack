import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

final class UpdateExpense implements UseCase<Unit, UpdateExpenseCommand> {
  final ExpenseRepository expenseRepository;

  const UpdateExpense(this.expenseRepository);

  @override
  Future<Either<Failure, Unit>> call(UpdateExpenseCommand params) async {
    return await expenseRepository.update(
      id: params.expenseId,
      name: params.name,
      amount: params.amount,
      date: params.date,
    );
  }
}

final class UpdateExpenseCommand {
  final String expenseId;
  final String name;
  final double amount;
  final DateTime date;

  const UpdateExpenseCommand({
    required this.expenseId,
    required this.name,
    required this.amount,
    required this.date,
  });
}
