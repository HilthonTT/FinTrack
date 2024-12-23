import 'package:fintrack_app/core/common/widgets/load_more_button.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_list.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_subscription_switcher.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_header_section.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/subscriptions_list.dart';
import 'package:flutter/material.dart';

final class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  bool isSubscriptions = true;

  void switchToSubscriptions() {
    setState(() {
      isSubscriptions = true;
    });
  }

  void switchToExpenses() {
    setState(() {
      isSubscriptions = false;
    });
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
                      isSubscriptions: isSubscriptions,
                      switchToSubscriptions: switchToSubscriptions,
                      switchToExpenses: switchToExpenses,
                    ),
                    _buildList(),
                    LoadMoreButton(onPressed: () {}, hasMore: true),
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
    if (isSubscriptions) {
      return SubscriptionsList();
    }

    return ExpenseList();
  }
}
