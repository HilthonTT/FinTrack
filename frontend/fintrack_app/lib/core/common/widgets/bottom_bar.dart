import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/subscriptions/presentation/pages/create_subscription_page.dart';
import 'package:fintrack_app/features/tabs/enums/main_tab_page.dart';
import 'package:flutter/material.dart';

final class BottomBar extends StatelessWidget {
  final MainTabPage selectedPage;

  final VoidCallback onHomePressed;
  final VoidCallback onBudgetPressed;
  final VoidCallback onCalendarPressed;
  final VoidCallback onCardPressed;

  const BottomBar({
    super.key,
    required this.selectedPage,
    required this.onHomePressed,
    required this.onBudgetPressed,
    required this.onCalendarPressed,
    required this.onCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppPalette.gray80,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: onHomePressed,
                              icon: Image.asset(
                                "assets/images/home.png",
                                width: 20,
                                height: 20,
                                color: _getTabColor(MainTabPage.home),
                              ),
                            ),
                            IconButton(
                              onPressed: onBudgetPressed,
                              icon: Image.asset(
                                "assets/images/budgets.png",
                                width: 20,
                                height: 20,
                                color: _getTabColor(MainTabPage.budget),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CreateSubscriptionPage.route(),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppPalette.secondary
                                          .withValues(alpha: .25),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.asset(
                                  "assets/images/center_btn.png",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: onCalendarPressed,
                              icon: Image.asset(
                                "assets/images/calendar.png",
                                width: 20,
                                height: 20,
                                color: _getTabColor(MainTabPage.calendar),
                              ),
                            ),
                            IconButton(
                              onPressed: onCardPressed,
                              icon: Image.asset(
                                "assets/images/creditcards.png",
                                width: 20,
                                height: 20,
                                color: _getTabColor(MainTabPage.cards),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTabColor(MainTabPage page) {
    if (page == selectedPage) {
      return AppPalette.white;
    }

    return AppPalette.gray30;
  }
}
