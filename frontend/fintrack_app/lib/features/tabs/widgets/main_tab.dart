import 'package:fintrack_app/core/common/widgets/bottom_bar.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/budgets/presentation/pages/budget_page.dart';
import 'package:fintrack_app/features/expenses/presentation/pages/home_page.dart';
import 'package:fintrack_app/features/subscriptions/presentation/pages/calendar_page.dart';
import 'package:fintrack_app/features/tabs/enums/main_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class MainTab extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const MainTab());

  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

final class _MainTabState extends State<MainTab> {
  final pageStorageBucket = PageStorageBucket();
  Widget currentPage = const HomePage();

  MainTabPage selectedPage = MainTabPage.home;

  void onSelect(MainTabPage tab) {
    setState(() {
      selectedPage = tab;

      switch (tab) {
        case MainTabPage.home:
          currentPage = const HomePage();
        case MainTabPage.budget:
          currentPage = const BudgetPage();
        case MainTabPage.calendar:
          currentPage = const CalendarPage();
        case MainTabPage.cards:
          currentPage = const HomePage();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.gray,
      body: Stack(
        children: [
          PageStorage(bucket: pageStorageBucket, child: currentPage),
          BottomBar(
            selectedPage: selectedPage,
            onHomePressed: () {
              onSelect(MainTabPage.home);
            },
            onBudgetPressed: () {
              onSelect(MainTabPage.budget);
            },
            onCalendarPressed: () {
              onSelect(MainTabPage.calendar);
            },
            onCardPressed: () {
              onSelect(MainTabPage.cards);
            },
          ),
        ],
      ),
    );
  }
}
