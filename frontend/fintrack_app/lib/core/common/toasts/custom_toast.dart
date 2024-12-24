import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class CustomToast extends StatelessWidget {
  final IconData icon;
  final String message;

  const CustomToast({
    super.key,
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppPalette.gray80,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(
              color: AppPalette.white,
            ),
          ),
        ],
      ),
    );
  }
}
