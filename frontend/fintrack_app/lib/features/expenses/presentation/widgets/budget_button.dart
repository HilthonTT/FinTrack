import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class BudgetButton extends StatelessWidget {
  const BudgetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppPalette.border.withValues(alpha: .15),
          ),
          color: AppPalette.gray60.withValues(alpha: .3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          "See your budget",
          style: TextStyle(
            color: AppPalette.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
