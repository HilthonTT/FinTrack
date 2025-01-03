import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/common/widgets/editable_date_field.dart';
import 'package:fintrack_app/core/common/widgets/editable_numeric_field.dart';
import 'package:fintrack_app/core/common/widgets/editable_text_field.dart';
import 'package:fintrack_app/core/common/widgets/secondary_button.dart';
import 'package:fintrack_app/core/enums/enum_helper.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

final class ExpenseInfoDialog extends StatefulWidget {
  final Expense expense;
  final int take;
  final VoidCallback? onOk;
  final VoidCallback? onClose;

  const ExpenseInfoDialog({
    super.key,
    required this.expense,
    required this.take,
    this.onOk,
    this.onClose,
  });

  @override
  State<ExpenseInfoDialog> createState() => _ExpenseInfoDialogState();
}

final class _ExpenseInfoDialogState extends State<ExpenseInfoDialog> {
  late String name;
  late double amount;
  late DateTime date;

  void _refreshExpenses() {
    final event = ExpenseGetAllExpensesEvent(take: widget.take);
    context.read<ExpensesBloc>().add(event);
  }

  void _handleDelete() {
    final event = ExpenseDeleteExpenseEvent(expenseId: widget.expense.id);
    context.read<ExpensesBloc>().add(event);

    _refreshExpenses();

    if (widget.onClose != null) {
      widget.onClose!();
    }
  }

  void _handleUpdate() {
    final event = ExpenseUpdateExpenseEvent(
      expenseId: widget.expense.id,
      name: name,
      amount: amount,
      date: date,
    );

    context.read<ExpensesBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();

    final expense = widget.expense;
    name = expense.name;
    amount = expense.amount;
    date = expense.date;
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = getImagePath(widget.expense.company);

    return BlocConsumer<ExpensesBloc, ExpensesState>(
      listener: (context, state) {
        if (state is ExpenseUpdatedSuccess) {
          _refreshExpenses();
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: AppPalette.gray,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: EditableTextField(
                  initialValue: name,
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.white,
                  ),
                  inputDecoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter title',
                    hintStyle: TextStyle(color: AppPalette.gray50),
                  ),
                  onSave: (newValue) {
                    setState(() {
                      name = newValue;
                    });

                    _handleUpdate();
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: widget.onClose ?? () => Navigator.of(context).pop(),
              ),
            ],
          ),
          content: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 350),
              child: SizedBox(
                width: 600,
                child: SingleChildScrollView(
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
                          const SizedBox(width: 10),
                          Text(
                            formatEnumName(
                                widget.expense.company.name.toString()),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppPalette.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Divider(color: AppPalette.gray50),
                      const SizedBox(height: 5),
                      EditableNumericField(
                        initialValue: amount,
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: AppPalette.white,
                        ),
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter amount',
                          hintStyle: TextStyle(color: AppPalette.gray50),
                        ),
                        onSave: (newAmount) {
                          setState(() {
                            amount = newAmount;
                          });

                          _handleUpdate();
                        },
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Category: ${formatEnumName(widget.expense.category.name)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppPalette.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      EditableDateField(
                        initialDate: date, // Pass the current date
                        onDateChanged: (newDate) {
                          setState(() {
                            date = newDate;
                          });

                          _handleUpdate();
                        },
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Created On: ${DateFormat('yyyy-MM-dd').format(widget.expense.createdOnUtc.toLocal())}',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppPalette.gray40,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (widget.expense.modifiedOnUtc != null)
                            Text(
                              'Modified On: ${DateFormat('yyyy-MM-dd').format(widget.expense.modifiedOnUtc!.toLocal())}',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppPalette.gray40,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          SecondaryButton(
                            onPressed: widget.onOk ??
                                () => Navigator.of(context).pop(),
                            title: "Ok",
                            width: 250,
                            height: 50,
                          ),
                          SecondaryButton(
                            onPressed: () => _handleDelete(),
                            icon: Icons.delete,
                            title: "Delete",
                            width: 250,
                            height: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
