import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/budgets/presentation/widgets/budget_header_background.dart';
import 'package:fintrack_app/features/budgets/presentation/widgets/budget_on_tack_button.dart';

import 'package:flutter/material.dart';

final class BudgetHeaderSection extends StatelessWidget {
  final double containerWidth;
  final double imageHeight;
  final double arcSize;

  const BudgetHeaderSection({
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
        color: AppPalette.gray70.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: BudgetHeaderBackground(arcSize: arcSize),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  Text(
                    "\$82,90",
                    style: TextStyle(
                      color: AppPalette.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "of \$2,0000 budget",
                    style: TextStyle(
                      color: AppPalette.gray30,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0, // Ensure it stretches across the entire width
            child: SizedBox(
              width: double.infinity,
              child: BudgetOnTackButton(),
            ),
          )
        ],
      ),
    );
  }
}
