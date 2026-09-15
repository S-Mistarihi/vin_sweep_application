import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formateLastLogin(String? value) {
    if (value == null || value.isEmpty) {
      return ' ';
    }
    final dateTime = DateTime.parse(value).toLocal();
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final loginDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final difference = today.difference(loginDate).inDays;
    final time = DateFormat('h:mm a').format(dateTime);

    if (difference == 0) {
      return 'Today at $time';
    }
    if (difference == 1) {
      return 'Yesterday at $time';
    }
    return '${DateFormat('MMM d').format(dateTime)} at $time';
  }
}
