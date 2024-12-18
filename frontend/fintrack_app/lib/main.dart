import 'package:fintrack_app/core/theme/app_theme.dart';
import 'package:fintrack_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fintrack',
      theme: AppTheme.lightThemeMode,
      home: const LoginPage(),
    );
  }
}
