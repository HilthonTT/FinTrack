import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class AppTheme {
  static final darkThemeMode = ThemeData(
    fontFamily: "Inter",
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.primary,
      surface: AppPalette.gray80,
      primary: AppPalette.primary,
      primaryContainer: AppPalette.gray60,
      secondary: AppPalette.secondary,
    ),
    useMaterial3: true,
  );
}
