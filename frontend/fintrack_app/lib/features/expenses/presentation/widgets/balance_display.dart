import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class BalanceDisplay extends StatelessWidget {
  const BalanceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "\$1,235",
          style: TextStyle(
            color: AppPalette.white,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "This month bills",
          style: TextStyle(
            color: AppPalette.gray40,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
