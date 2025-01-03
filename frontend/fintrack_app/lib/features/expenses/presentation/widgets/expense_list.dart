import 'package:fintrack_app/core/common/utils/date.dart';
import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/common/utils/toast_helper.dart';
import 'package:fintrack_app/core/common/widgets/load_more_button.dart';
import 'package:fintrack_app/core/common/widgets/loader.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/domain/entities/expense.dart';
import 'package:fintrack_app/features/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:fintrack_app/features/expenses/presentation/dialogs/expense_info_dialog.dart';
import 'package:fintrack_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

final class _ExpenseListState extends State<ExpenseList> {
  late FToast fToast;
  int take = 10;

  void loadMore() {
    setState(() {
      take += 10;
    });

    context.read<ExpensesBloc>().add(ExpenseGetAllExpensesEvent(take: take));
  }

  Future<void> _showInfo(Expense expense) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ExpenseInfoDialog(
          expense: expense,
          take: take,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);

    context.read<ExpensesBloc>().add(ExpenseGetAllExpensesEvent(take: take));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpensesBloc, ExpensesState>(
      listener: (context, state) {
        if (state is ExpensesFailure) {
          showToast(fToast, state.error, Icons.error);
        }
      },
      builder: (context, state) {
        if (state is ExpensesLoading) {
          return const Loader();
        }

        if (state is ExpensesLoadedSuccess) {
          final pagedExpenses = state.pagedExpenses;

          final expenses = pagedExpenses.items;
          final hasNextPage = pagedExpenses.hasNextPage;

          return Column(
            children: [
              ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  final imagePath = getImagePath(expense.company);

                  Future<void> onTap() async {
                    await _showInfo(expense);
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: onTap,
                      child: Container(
                        height: 64,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppPalette.border.withValues(alpha: .15),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            _getImage(imagePath, expense),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                expense.name,
                                style: TextStyle(
                                  color: AppPalette.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${expense.amount.toStringAsPrecision(3)}",
                                  style: TextStyle(
                                    color: AppPalette.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  formatDate(expense.date.toString()),
                                  style: TextStyle(
                                    color: AppPalette.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              LoadMoreButton(onPressed: loadMore, hasMore: hasNextPage),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _getImage(String? imagePath, Expense expense) {
    if (imagePath != null) {
      return Image.asset(
        imagePath,
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      );
    }

    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppPalette.gray70.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getMonth(expense.date.toString()), // Get the month
            style: TextStyle(
              color: AppPalette.gray30,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            getDay(expense.date.toString()), // Get the day
            style: TextStyle(
              color: AppPalette.gray30,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
