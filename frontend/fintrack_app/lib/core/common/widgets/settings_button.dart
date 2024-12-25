import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/auth/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';

final class SettingsButton extends StatelessWidget {
  final double width;
  final double height;

  const SettingsButton({
    super.key,
    this.height = 25,
    this.width = 25,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(context, SettingsPage.route());
      },
      icon: Image.asset(
        "assets/images/settings.png",
        width: width,
        height: height,
        color: AppPalette.gray30,
      ),
    );
  }
}
