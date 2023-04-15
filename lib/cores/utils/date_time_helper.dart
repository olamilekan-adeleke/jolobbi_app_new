import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatDate(DateTime dateTime) {
    return DateFormat('E, MMM dd yyyy').format(dateTime);
  }

  static String formatDateWithTime(DateTime dateTime) {
    return DateFormat('hh:mm a. E, MMM dd yyyy').format(dateTime);
  }

  static String formatDay(DateTime dateTime) {
    return DateFormat('EEE, MMM d').format(dateTime);
  }
}
