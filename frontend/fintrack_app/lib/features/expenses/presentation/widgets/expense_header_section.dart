import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/balance_display.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/budget_button.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_statistics.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_header_background.dart';
import 'package:flutter/material.dart';

final class ExpenseHeaderSection extends StatelessWidget {
  final double containerWidth;
  final double imageHeight;
  final double arcSize;

  const ExpenseHeaderSection({
    super.key,
    required this.containerWidth,
    required this.imageHeight,
    required this.arcSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: containerWidth,
      decoration: BoxDecoration(
        color: AppPalette.gray70.withValues(alpha: .5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ExpenseHeaderBackground(arcSize: arcSize),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(
                  "assets/images/app_logo.png",
                  height: 100,
                  width: 150,
                ),
              ),
              const BalanceDisplay(),
              const SizedBox(
                height: 20,
              ),
              const BudgetButton(),
            ],
          ),
          const ExpenseStatistics(),
        ],
      ),
    );
  }
}
