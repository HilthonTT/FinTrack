import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/common/widgets/secondary_button.dart';
import 'package:fintrack_app/core/enums/enum_helper.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

Widget expenseInfoDialogTitle(Expense expense, {VoidCallback? onClose}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        expense.name,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppPalette.white,
        ),
      ),
      IconButton(
        icon: Icon(Icons.close),
        onPressed: onClose,
      ),
    ],
  );
}

Widget expenseInfoDialogContent(
  BuildContext context,
  Expense expense,
  int take, {
  VoidCallback? onOk,
  VoidCallback? onClose,
}) {
  final imagePath = getImagePath(expense.company);

  void refreshExpenses() {
    final event = ExpenseGetAllExpensesEvent(take: take);

    context.read<ExpensesBloc>().add(event);
  }

  void handleDelete() {
    final event = ExpenseDeleteExpenseEvent(expenseId: expense.id);

    context.read<ExpensesBloc>().add(event);

    refreshExpenses();

    if (onClose != null) {
      onClose();
    }
  }

  return SizedBox(
    width: 600,
    height: 300,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with company logo and name
        Row(
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            SizedBox(width: 10),
            Text(
              formatEnumName(expense.company.name.toString()),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppPalette.white,
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        Divider(color: AppPalette.gray50),

        SizedBox(height: 5),

        Text(
          'Amount: ${expense.amount.toStringAsFixed(2)} ${expense.currency}',
          style: TextStyle(
            fontSize: 16,
            color: AppPalette.white,
          ),
        ),

        SizedBox(height: 5),

        // Expense Category
        Text(
          'Category: ${formatEnumName(expense.category.name)}',
          style: TextStyle(
            fontSize: 16,
            color: AppPalette.white,
          ),
        ),
        SizedBox(height: 5),

        // Expense Date
        Text(
          'Date: ${DateFormat('yyyy-MM-dd').format(expense.date.toLocal())}', // Format the date
          style: TextStyle(
            fontSize: 16,
            color: AppPalette.white,
          ),
        ),
        SizedBox(height: 10),

        // Created and Modified timestamps
        Row(
          children: [
            Text(
              'Created On: ${DateFormat('yyyy-MM-dd').format(expense.createdOnUtc.toLocal())}',
              style: TextStyle(
                fontSize: 14,
                color: AppPalette.gray40,
              ),
            ),
            SizedBox(width: 10),
            if (expense.modifiedOnUtc != null)
              Text(
                'Modified On: ${DateFormat('yyyy-MM-dd').format(expense.modifiedOnUtc!.toLocal())}',
                style: TextStyle(
                  fontSize: 14,
                  color: AppPalette.gray40,
                ),
              ),
          ],
        ),

        const SizedBox(height: 50),

        Row(
          children: <Widget>[
            SecondaryButton(
              onPressed: onOk ?? () {},
              title: "Ok",
              width: 250,
              height: 50,
            ),
            SecondaryButton(
              onPressed: handleDelete,
              icon: Icons.delete,
              title: "Delete",
              width: 250,
              height: 50,
            ),
          ],
        )
      ],
    ),
  );
}
