import 'package:fintrack_app/core/common/utils/date.dart';
import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class ExpenseList extends StatelessWidget {
  ExpenseList({super.key});

  final List<Map<String, dynamic>> expenses = [
    {
      "id": "1",
      "userId": "userId",
      "name": "Netflix Subscription",
      "amount": 12.99,
      "currencyCode": "USD",
      "category": 14, // StreamingServices
      "company": 1, // Netflix
      "date": "2024-12-01",
      "createdOnUtc": "2024-11-30T12:34:56Z",
      "modifiedOnUtc": "2024-12-01T10:00:00Z",
    },
    {
      "id": "2",
      "userId": "userId",
      "name": "Google Subscription",
      "amount": 8.99,
      "currencyCode": "USD",
      "category": 14, // StreamingServices
      "company": 0, // Google
      "date": "2024-11-15",
      "createdOnUtc": "2024-11-14T08:22:45Z",
      "modifiedOnUtc": "2024-11-15T09:12:00Z",
    },
    {
      "id": "3",
      "userId": "userId",
      "name": "Amazon Prime",
      "amount": 14.99,
      "currencyCode": "USD",
      "category": 14, // StreamingServices
      "company": 2, // AmazonPrime
      "date": "2024-11-20",
      "createdOnUtc": "2024-11-19T11:45:00Z",
      "modifiedOnUtc": "2024-11-20T13:00:00Z",
    },
    {
      "id": "4",
      "userId": "userId",
      "name": "Spotify",
      "amount": 29.99,
      "currencyCode": "USD",
      "category": 14, // StreamingServices
      "company": 3, // Spotify
      "date": "2024-12-05",
      "createdOnUtc": "2024-12-04T15:00:00Z",
      "modifiedOnUtc": "2024-12-05T08:00:00Z",
    },
    {
      "id": "5",
      "userId": "userId",
      "name": "Disney Plus Subscription",
      "amount": 9.99,
      "currencyCode": "USD",
      "category": 14, // StreamingServices
      "company": 4, // DisneyPlus
      "date": "2024-12-03",
      "createdOnUtc": "2024-12-02T10:30:15Z",
      "modifiedOnUtc": "2024-12-03T12:30:00Z",
    },
    {
      "id": "6",
      "userId": "userId",
      "name": "Apple Music",
      "amount": 9.99,
      "currencyCode": "USD",
      "category": 14, // StreamingServices
      "company": 5, // Apple
      "date": "2024-11-30",
      "createdOnUtc": "2024-11-29T07:05:00Z",
      "modifiedOnUtc": "2024-11-30T09:45:00Z",
    },
    {
      "id": "7",
      "userId": "userId",
      "name": "Dropbox Subscription",
      "amount": 12.99,
      "currencyCode": "USD",
      "category": 15, // Subscriptions
      "company": 9, // Dropbox
      "date": "2024-12-02",
      "createdOnUtc": "2024-12-01T17:22:00Z",
      "modifiedOnUtc": "2024-12-02T10:00:00Z",
    },
    {
      "id": "8",
      "userId": "userId",
      "name": "YouTube Premium",
      "amount": 59.99,
      "currencyCode": "USD",
      "category": 14, // StreamingServices
      "company": 7, // YouTube Premium
      "date": "2024-12-01",
      "createdOnUtc": "2024-11-30T12:34:56Z",
      "modifiedOnUtc": "2024-12-01T10:00:00Z",
    },
    {
      "id": "9",
      "userId": "userId",
      "name": "Microsoft Subscription",
      "amount": 29.99,
      "currencyCode": "USD",
      "category": 14, // StreamingServices
      "company": 8, // Microsoft
      "date": "2024-12-04",
      "createdOnUtc": "2024-12-03T14:25:00Z",
      "modifiedOnUtc": "2024-12-04T11:00:00Z",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];

        final imagePath = getImagePath(expense['company']);

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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getMonth(expense['date']), // Get the month
                            style: TextStyle(
                              color: AppPalette.gray30,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            getDay(expense['date']), // Get the day
                            style: TextStyle(
                              color: AppPalette.gray30,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      expense['name'],
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
                        "\$${expense['amount']}",
                        style: TextStyle(
                          color: AppPalette.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        formatDate(expense['createdOnUtc']),
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
