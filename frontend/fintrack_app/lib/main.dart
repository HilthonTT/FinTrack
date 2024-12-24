import 'package:fintrack_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fintrack_app/core/theme/app_theme.dart';
import 'package:fintrack_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fintrack_app/features/auth/presentation/pages/login_page.dart';
import 'package:fintrack_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Fintrack',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
