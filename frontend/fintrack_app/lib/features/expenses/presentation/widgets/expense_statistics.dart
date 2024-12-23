import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_status_button.dart';
import 'package:flutter/material.dart';

class ExpenseStatistics extends StatelessWidget {
  const ExpenseStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          const Spacer(),
          Row(
            children: <Widget>[
              Expanded(
                child: ExpenseStatusButton(
                  title: "Recent expenses",
                  value: "20",
                  statusColor: AppPalette.secondary,
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: ExpenseStatusButton(
                  title: "Highest expense",
                  value: "\$19.99",
                  statusColor: AppPalette.primary10,
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: ExpenseStatusButton(
                  title: "Lowest expense",
                  value: "\$5.99",
                  statusColor: AppPalette.secondaryG,
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
