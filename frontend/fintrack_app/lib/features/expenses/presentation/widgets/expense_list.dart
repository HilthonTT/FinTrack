import 'package:intl/intl.dart';
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
      "subscriptionType": 1, // Netflix
      "transactionType": 2, // Expense
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
      "subscriptionType": 0, // Google
      "transactionType": 2, // Expense
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
      "subscriptionType": 2, // AmazonPrime
      "transactionType": 2, // Expense
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
      "subscriptionType": 3, // Spotify
      "transactionType": 2, // Expense
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
      "subscriptionType": 4, // DisneyPlus
      "transactionType": 2, // Expense
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
      "subscriptionType": 5, // Apple
      "transactionType": 2, // Expense
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
      "subscriptionType": 9, // Dropbox
      "transactionType": 2, // Expense
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
      "subscriptionType": 7, // YouTube Premium
      "transactionType": 2, // Expense
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
      "subscriptionType": 8, // Microsoft
      "transactionType": 2, // Expense
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

        final subscriptionType = expense["subscriptionType"] as int?;
        final imagePath = _getImage(subscriptionType);

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
                            _getMonth(expense['date']), // Get the month
                            style: TextStyle(
                              color: AppPalette.gray30,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            _getDay(expense['date']), // Get the day
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
                        _formatDate(expense['createdOnUtc']),
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

  String? _getImage(int? subscriptionType) {
    switch (subscriptionType) {
      case 0: // Netflix
        return 'assets/images/google_logo.png';
      case 1: // Netflix
        return 'assets/images/netflix_logo.png';
      case 2: // Amazon Prime
        return 'assets/images/amazon_logo.png';
      case 3: // Spotify
        return 'assets/images/spotify_logo.png';
      case 4: // Disney Plus
        return 'assets/images/disney_logo.png';
      case 5: // Apple
        return 'assets/images/apple_logo.png';
      case 6: // Hulu
        return 'assets/images/hulu_logo.png';
      case 7: // YouTube Premium
        return 'assets/images/youtube_logo.png';
      case 8: // Microsoft
        return 'assets/images/microsoft_logo.png';
      case 9: // Dropbox
        return 'assets/images/dropbox_logo.png';
      default:
        return null;
    }
  }

  String _formatDate(String dateUtc) {
    try {
      final DateTime dateTime = DateTime.parse(dateUtc);
      return DateFormat('MMM d, yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String _getMonth(String date) {
    try {
      final DateTime dateTime = DateTime.parse(date);
      return DateFormat('MMM').format(dateTime);
    } catch (e) {
      return 'N/A';
    }
  }

  String _getDay(String date) {
    try {
      final DateTime dateTime = DateTime.parse(date);
      return DateFormat('d').format(dateTime);
    } catch (e) {
      return '--';
    }
  }
}
