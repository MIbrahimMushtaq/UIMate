import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ui_mate/utils/utils.dart';

class Dates {
  Dates._();

  // ================= Formats =================
  static const String pGetTime12 = 'hh:mm:ss a';
  static const String pGetTime24 = 'HH:mm:ss';
  static const String pGetTime24WithoutSec = 'HH:mm';
  static const String pGetTime12WithoutSec = 'hh:mm a';
  static const String pGetDateTime = 'dd-MM-yyyy HH:mm';
  static const String pGetShortDate = 'dd-MM-yyyy';
  static const String pGetLongDate = 'dd-MMM-yyyy';
  static const String pGetDateFormat = 'yyyy-MM-dd';
  static const String pGetDate = 'dd-MMM-yyyy';
  static const String pGetDay = 'dd';
  static const String pGetMonth = 'MMM';
  static const String pGetDateFullMonth = 'dd-MMMM-yyyy';
  static const String pGetMonthAndDate = 'MMM dd';
  static const String pGetMonthDayAndTime = 'MMM dd, hh:mm a';
  static const String pGetMonthDayAndTimeForDifference =
      'dd-MM-yyyy, hh:mm a';

  // ================= Locale Init =================
  static bool _initialized = false;
  static String _currentLocale = 'en_US';

  static void _ensureInitialized([String? locale]) {
    final loc = locale ?? _currentLocale;

    if (_initialized && _currentLocale == loc) return;

    try {
      initializeDateFormatting(loc, null);
      _initialized = true;
      _currentLocale = loc;
    } catch (e) {
      if (kDebugMode) {
        print('Dates locale init failed: $e');
      }
    }
  }

  // ================= Formatters =================
  static DateFormat _dateFormatter({String? localization}) {
    final locale = localization ?? _currentLocale;
    _ensureInitialized(locale);

    return DateFormat(
      Static.defaultDateFormat ?? pGetDate,
      locale,
    );
  }

  static DateFormat _dateTimeFormatter({String? localization}) {
    final locale = localization ?? _currentLocale;
    _ensureInitialized(locale);

    return DateFormat(
      Static.defaultDateTimeFormat ?? pGetDateTime,
      locale,
    );
  }

  // ================= Public APIs =================
  static String pDateToString(
      DateTime? dateTime, {
        String? defaultValue,
        String? localization,
      }) {
    if (dateTime == null) return defaultValue ?? '';
    try {
      return _dateFormatter(localization: localization).format(dateTime);
    } catch (e) {
      if (kDebugMode) {
        print('pDateToString error: $e');
      }
      return defaultValue ?? '00-00-0000';
    }
  }

  static String pDateTimeToString(
      DateTime? dateTime, {
        String? defaultValue,
        String? localization,
      }) {
    if (dateTime == null) return defaultValue ?? '';
    try {
      return _dateTimeFormatter(localization: localization).format(dateTime);
    } catch (e) {
      if (kDebugMode) {
        print('pDateTimeToString error: $e');
      }
      return defaultValue ?? '00-00-0000';
    }
  }

  static String pGetDateTimeCustomFormat(
      DateTime? dateTime,
      String format, {
        String? defaultValue,
        String? localization,
      }) {
    if (dateTime == null) return defaultValue ?? '';
    try {
      final locale = localization ?? _currentLocale;
      _ensureInitialized(locale);

      return DateFormat(format, locale).format(dateTime);
    } catch (e) {
      if (kDebugMode) {
        print('pGetDateTimeCustomFormat error: $e');
      }
      return defaultValue ?? '00-00-0000';
    }
  }

  static DateTime pStringToDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      if (kDebugMode) {
        print('pStringToDate error: $e');
      }
      return DateTime(1970, 1, 1);
    }
  }

  static DateTime? tryParseFlexible(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;

    final formats = [
      pGetDateFormat,
      pGetShortDate,
      pGetLongDate,
      pGetDateTime,
      'yyyy/MM/dd HH:mm:ss',
      'yyyy-MM-dd HH:mm:ss',
    ];

    for (final f in formats) {
      try {
        return DateFormat(f).parse(dateStr);
      } catch (_) {}
    }
    return null;
  }
}
