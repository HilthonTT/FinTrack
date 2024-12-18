import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class AppTheme {
  static final lightThemeMode = ThemeData.light(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppPalette.backgroundColor),
    scaffoldBackgroundColor: AppPalette.backgroundColor,
  );
}
