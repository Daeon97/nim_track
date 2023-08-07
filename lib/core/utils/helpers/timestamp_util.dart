// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';

// Reference this class from BLOC not UI
final class TimestampUtil {
  static String computeHourMinuteAmPm(int timestamp) => DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp,
        ),
      );

  static String computeMonthYear(int timestamp) => DateFormat.yMMM().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp,
        ),
      );
}
