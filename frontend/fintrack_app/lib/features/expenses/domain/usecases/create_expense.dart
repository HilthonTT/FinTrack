import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/expenses/domain/enums/expense_category.dart';
import 'package:fintrack_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

final class CreateExpense implements UseCase<String, CreateExpenseCommand> {
  final ExpenseRepository expenseRepository;

  const CreateExpense(this.expenseRepository);

  @override
  Future<Either<Failure, String>> call(CreateExpenseCommand params) async {
    return await expenseRepository.create(
      name: params.name,
      amount: params.amount,
      currencyCode: params.currencyCode,
      category: params.category,
      company: params.company,
      date: params.date,
    );
  }
}

final class CreateExpenseCommand {
  final String name;
  final double amount;
  final String currencyCode;
  final ExpenseCategory category;
  final Company company;
  final DateTime date;

  const CreateExpenseCommand({
    required this.name,
    required this.amount,
    required this.currencyCode,
    required this.category,
    required this.company,
    required this.date,
  });
}
