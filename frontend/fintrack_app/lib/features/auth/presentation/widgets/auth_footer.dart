import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class AuthFooter extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AuthFooter({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label ",
            style: TextStyle(color: AppPalette.secondary50),
          ),
        ],
      ),
    );
  }
}
