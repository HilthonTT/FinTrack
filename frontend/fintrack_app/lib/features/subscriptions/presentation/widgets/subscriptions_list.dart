import 'package:fintrack_app/core/common/utils/date.dart';
import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class SubscriptionsList extends StatelessWidget {
  SubscriptionsList({super.key});

  final List<Map<String, dynamic>> subscriptions = [
    {
      "id": "1",
      "userId": "12345",
      "name": "Netflix Subscription",
      "amount": "15.99",
      "currency": "EUR",
      "frequency": 2, // Monthly (based on Frequency enum)
      "company": 1, // Netflix (based on Company enum)
      "periodStart": "2024-01-01", // Example start date
      "periodEnd": "2024-12-31", // Example end date
      "nextDueDate": "2025-01-01", // Next due date
      "status": 0, // Active (based on Status enum)
      "createdOnUtc": "2024-01-01T00:00:00Z",
      "modifiedOnUtc": "2024-01-01T00:00:00Z"
    },
    {
      "id": "2",
      "userId": "12345",
      "name": "Spotify Subscription",
      "amount": "9.99",
      "currency": "EUR",
      "frequency": 2, // Monthly (based on Frequency enum)
      "company": 3, // Spotify (based on Company enum)
      "periodStart": "2024-01-01", // Example start date
      "periodEnd": "2024-12-31", // Example end date
      "nextDueDate": "2025-01-01", // Next due date
      "status": 0, // Active (based on Status enum)
      "createdOnUtc": "2024-01-01T00:00:00Z",
      "modifiedOnUtc": "2024-01-01T00:00:00Z"
    },
    {
      "id": "3",
      "userId": "67890",
      "name": "Amazon Prime Subscription",
      "amount": "12.99",
      "currency": "EUR",
      "frequency": 3, // Yearly (based on Frequency enum)
      "company": 2, // AmazonPrime (based on Company enum)
      "periodStart": "2024-01-01", // Example start date
      "periodEnd": "2025-01-01", // Example end date
      "nextDueDate": "2025-01-01", // Next due date
      "status": 0, // Active (based on Status enum)
      "createdOnUtc": "2024-01-01T00:00:00Z",
      "modifiedOnUtc": "2024-01-01T00:00:00Z"
    },
  ];

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
                border: Border.all(color: AppPalette.border.withOpacity(0.15)),
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
                        color: AppPalette.gray70.withOpacity(0.5),
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
