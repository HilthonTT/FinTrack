import 'package:fintrack_app/core/common/widgets/segment_button.dart';
import 'package:flutter/material.dart';

final class ExpenseSubscriptionSwitcher extends StatelessWidget {
  final bool isSubscriptions;
  final VoidCallback switchToSubscriptions;
  final VoidCallback switchToExpenses;

  const ExpenseSubscriptionSwitcher({
    super.key,
    required this.switchToSubscriptions,
    required this.switchToExpenses,
    required this.isSubscriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: SegmentButton(
              title: "Your subscriptions",
              onPressed: switchToSubscriptions,
              isActive: isSubscriptions,
            ),
          ),
          Expanded(
            child: SegmentButton(
              title: "Your expenses",
              isActive: !isSubscriptions,
              onPressed: switchToExpenses,
            ),
          )
        ],
      ),
    );
  }
}
