import 'package:intl/intl.dart';

class NumberFormatter {
  static String commaDecimal(num value, int decimal) {
    final numberFormat = NumberFormat("#,##0.${'0' * decimal}");
    return numberFormat.format(value);
  }

  static String commaValue(num value) {
    return NumberFormat.decimalPattern().format(value);
  }
}
