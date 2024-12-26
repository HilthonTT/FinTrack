import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class ExpenseStatusButton extends StatelessWidget {
  final String title;
  final String value;
  final Color statusColor;
  final VoidCallback onPressed;

  const ExpenseStatusButton({
    super.key,
    required this.title,
    required this.value,
    required this.statusColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 69,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppPalette.border.withValues(alpha: .15),
              ),
              color: AppPalette.gray60.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppPalette.gray40,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: AppPalette.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 60,
            height: 1,
            color: statusColor,
          ),
        ],
      ),
    );
  }
}
