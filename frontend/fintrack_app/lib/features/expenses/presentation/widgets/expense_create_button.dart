import 'package:dotted_border/dotted_border.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/presentation/pages/create_expense_page.dart';
import 'package:flutter/material.dart';

final class ExpenseCreateButton extends StatelessWidget {
  const ExpenseCreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(context, CreateExpensePage.route());
        },
        child: DottedBorder(
          dashPattern: const [5, 4],
          strokeWidth: 1,
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          color: AppPalette.border.withValues(alpha: .1),
          child: Container(
            height: 64,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add new expense ",
                  style: TextStyle(
                    color: AppPalette.gray30,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset(
                  "assets/images/add.png",
                  width: 12,
                  height: 12,
                  color: AppPalette.gray30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
