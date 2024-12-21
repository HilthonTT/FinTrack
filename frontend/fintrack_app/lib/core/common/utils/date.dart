import 'package:intl/intl.dart';

String formatDate(String dateUtc) {
  try {
    final DateTime dateTime = DateTime.parse(dateUtc);
    return DateFormat('MMM d, yyyy').format(dateTime);
  } catch (e) {
    return 'Invalid Date';
  }
}

String getMonth(String date) {
  try {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMM').format(dateTime);
  } catch (e) {
    return 'N/A';
  }
}

String getDay(String date) {
  try {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('d').format(dateTime);
  } catch (e) {
    return '--';
  }
}
