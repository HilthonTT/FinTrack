import 'package:fintrack_app/core/common/utils/date.dart';
import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/constants/subscriptions.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class SubscriptionsList extends StatelessWidget {
  const SubscriptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];

        final imagePath = getImagePath(subscription['company']);

        void onTap() {}

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Container(
              height: 64,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppPalette.border.withValues(alpha: .15),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  if (imagePath != null) // Check if an image path exists
                    Image.asset(
                      imagePath,
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  if (imagePath == null)
                    Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppPalette.gray70.withValues(alpha: .5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      subscription['name'],
                      style: TextStyle(
                        color: AppPalette.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${subscription['amount']}",
                        style: TextStyle(
                          color: AppPalette.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        formatDate(subscription['createdOnUtc']),
                        style: TextStyle(
                          color: AppPalette.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
