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
