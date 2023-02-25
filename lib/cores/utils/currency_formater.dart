import 'package:intl/intl.dart';

String currencyFormatter(int amount) {
  final NumberFormat formatter = NumberFormat('\u20A6 #,##0', 'en_US');
  return formatter.format(amount);
}
