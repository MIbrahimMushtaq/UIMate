import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ui_mate/utils/utils.dart';

class Dates {
  Dates._(); // Private constructor for utility class

  // Common date/time patterns
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
  static const String pGetMonthDayAndTimeForDifference = 'dd-MM-yyyy, hh:mm a';

  /// Initializes date formatting for a given [localization] (default: 'en').
  static Future<void> initializeDateFormat({String? localization}) async {
    final locale = localization ?? 'en';
    await initializeDateFormatting(locale, null);
  }

  /// Returns a [DateFormat] for date-only patterns.
  static DateFormat pDateFormatter({String? localization}) {
    final format = Static.defaultDateFormat ?? pGetDate;
    final locale = localization ?? 'en';
    return DateFormat(format, locale);
  }

  /// Returns a [DateFormat] for date and time patterns.
  static DateFormat pDateTimeFormatter({String? localization}) {
    final format = Static.defaultDateTimeFormat ?? pGetDateTime;
    final locale = localization ?? 'en';
    return DateFormat(format, locale);
  }

  /// Converts a [DateTime] object to a formatted date string.
  static String pDateToString(DateTime? dateTime,
      {String? defaultValue, String? localization}) {
    if (dateTime == null) return defaultValue ?? '';
    try {
      return pDateFormatter(localization: localization).format(dateTime);
    } catch (e) {
      if (kDebugMode) print('pDateToString error: $e');
      return defaultValue ?? '00-00-0000';
    }
  }

  /// Converts a [DateTime] object to a formatted date-time string.
  static String pDateTimeToString(DateTime? dateTime,
      {String? defaultValue, String? localization}) {
    if (dateTime == null) return defaultValue ?? '';
    try {
      return pDateTimeFormatter(localization: localization).format(dateTime);
    } catch (e) {
      if (kDebugMode) print('pDateTimeToString error: $e');
      return defaultValue ?? '00-00-0000';
    }
  }

  /// Formats [dateTime] with a custom [format].
  static String pGetDateTimeCustomFormat(DateTime? dateTime, String format,
      {String? defaultValue, String? localization}) {
    if (dateTime == null) return defaultValue ?? '';
    try {
      final locale = localization ?? 'en';
      return DateFormat(format, locale).format(dateTime);
    } catch (e) {
      if (kDebugMode) print('pGetDateTimeCustomFormat error: $e');
      return defaultValue ?? '00-00-0000';
    }
  }

  /// Parses a [String] into a [DateTime] safely.
  /// Returns a fallback date if parsing fails.
  static DateTime pStringToDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      if (kDebugMode) print('pStringToDate error: $e');
      // Return a clearly invalid past date as fallback
      return DateTime(1970, 1, 1);
    }
  }

  static DateTime? tryParseFlexible(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    final possibleFormats = [
      pGetDateFormat,
      pGetShortDate,
      pGetLongDate,
      pGetDateTime,
      'yyyy/MM/dd HH:mm:ss',
      'yyyy-MM-dd HH:mm:ss',
    ];

    for (final format in possibleFormats) {
      try {
        return DateFormat(format).parse(dateStr);
      } catch (_) {}
    }
    return null;
  }
}
