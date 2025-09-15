import 'package:intl/intl.dart';
import 'toast.dart';

pCurrencyFormat(
    dynamic value, {
      String? locale,
      String? symbol,
      int? decimalDigits,
      bool? isCurrencyCompact,
    }) {
  try {
    if (value == null || value == '') {
      value = 0;
    }
    double price = double.parse((value).toString());
    if (isCurrencyCompact ?? false) {
      return NumberFormat.compactCurrency(
        locale: locale,
        symbol: symbol,
        decimalDigits: decimalDigits,
      ).format(price);
    } else {
      return NumberFormat.currency(
        locale: locale,
        symbol: symbol,
        decimalDigits: decimalDigits,
      ).format(price);
    }
  } catch (e) {
    pShowToast(message: 'You Enter Invalid Amount');
    return 0;
  }
}
