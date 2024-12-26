import 'package:fintrack_app/core/common/utils/date.dart';
import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/constants/expenses.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];

        final imagePath = getImagePath(expense['company']);

        void onTap() {}

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
                  if (imagePath != null) // Check if an image path exists
                    Image.asset(
                      imagePath,
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  if (imagePath == null)
                    Container(
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
                            getMonth(expense['date']), // Get the month
                            style: TextStyle(
                              color: AppPalette.gray30,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            getDay(expense['date']), // Get the day
                            style: TextStyle(
                              color: AppPalette.gray30,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      expense['name'],
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
                        "\$${expense['amount']}",
                        style: TextStyle(
                          color: AppPalette.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        formatDate(expense['createdOnUtc']),
                        style: TextStyle(
                          color: AppPalette.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
