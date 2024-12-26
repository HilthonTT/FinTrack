import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/constants/subscriptions.dart';
import 'package:fintrack_app/features/subscriptions/presentation/widgets/subscription_card.dart';
import 'package:flutter/material.dart';

final class CalendarList extends StatelessWidget {
  const CalendarList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final int crossAxisCount = screenWidth < 600 ? 2 : 5;

    final double aspectRatio = screenWidth < 600 ? 0.8 : 1;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // number of columns
        crossAxisSpacing: 8, // Space between columns
        mainAxisSpacing: 8, // Space between rows
        childAspectRatio:
            aspectRatio, // Adjust aspect ratio to control card's size
      ),
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];

        final icon = getImagePath(subscription['company']) ??
            "assets/images/google_logo.png";

        return SubscriptionCard(
          name: subscription['name'],
          icon: icon,
          amount: subscription['amount'],
        );
      },
    );
  }
}
