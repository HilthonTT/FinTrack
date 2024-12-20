import 'package:fintrack_app/core/common/widgets/segment_button.dart';
import 'package:flutter/material.dart';

final class ExpenseSubscriptionSwitcher extends StatefulWidget {
  const ExpenseSubscriptionSwitcher({super.key});

  @override
  State<ExpenseSubscriptionSwitcher> createState() =>
      _ExpenseSubscriptionSwitcherState();
}

final class _ExpenseSubscriptionSwitcherState
    extends State<ExpenseSubscriptionSwitcher> {
  bool isSubscription = true;

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
              onPressed: () {
                setState(() {
                  isSubscription = true;
                });
              },
              isActive: isSubscription,
            ),
          ),
          Expanded(
            child: SegmentButton(
              title: "Your expenses",
              isActive: !isSubscription,
              onPressed: () {
                setState(() {
                  isSubscription = !isSubscription;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
