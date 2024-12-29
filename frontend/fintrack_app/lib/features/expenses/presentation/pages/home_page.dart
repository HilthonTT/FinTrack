import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/presentation/pages/create_expense_page.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/create_button.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_list.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_subscription_switcher.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_header_section.dart';
import 'package:fintrack_app/features/subscriptions/presentation/pages/create_subscription_page.dart';
import 'package:fintrack_app/features/subscriptions/presentation/widgets/subscriptions_list.dart';
import 'package:flutter/material.dart';

final class HomePage extends StatefulWidget {
  static MaterialPageRoute<HomePage> route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  bool _isSubscriptions = true;

  void _switchToSubscriptions() {
    setState(() {
      _isSubscriptions = true;
    });
  }

  void _switchToExpenses() {
    setState(() {
      _isSubscriptions = false;
    });
  }

  void _onCreatePressed() {
    if (_isSubscriptions) {
      Navigator.push(context, CreateSubscriptionPage.route());
    } else {
      Navigator.push(context, CreateExpensePage.route());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.gray,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktop = constraints.maxWidth >= 800;

          final double containerWidth =
              isDesktop ? double.infinity : constraints.maxWidth;

          final double imageHeight =
              isDesktop ? 400 : constraints.maxHeight * 0.45;

          final double arcSize = isDesktop ? 300 : 200;

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ExpenseHeaderSection(
                      containerWidth: containerWidth,
                      imageHeight: imageHeight,
                      arcSize: arcSize,
                    ),
                    ExpenseSubscriptionSwitcher(
                      isSubscriptions: _isSubscriptions,
                      switchToSubscriptions: _switchToSubscriptions,
                      switchToExpenses: _switchToExpenses,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CreateButton(onPressed: _onCreatePressed),
                    ),
                    const SizedBox(height: 10),
                    _buildList(),
                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList() {
    if (_isSubscriptions) {
      return SubscriptionsList();
    }

    return ExpenseList();
  }
}
