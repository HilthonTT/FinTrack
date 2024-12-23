import 'package:dotted_border/dotted_border.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class BudgetCreateButton extends StatelessWidget {
  const BudgetCreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: DottedBorder(
          dashPattern: const [5, 4],
          strokeWidth: 1,
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          color: AppPalette.border.withOpacity(0.1),
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
                  "Add new budget ",
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
