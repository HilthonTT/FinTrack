import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class SubscriptionCard extends StatelessWidget {
  final String icon;
  final String name;
  final String amount;

  const SubscriptionCard({
    super.key,
    required this.icon,
    required this.name,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;

    final imageSize = isMobile ? 60.0 : 100.0;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              icon,
              width: imageSize,
              height: imageSize,
            ),
            const SizedBox(height: 20),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppPalette.white,
                fontSize: isMobile ? 12 : 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "\$$amount",
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppPalette.white,
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
