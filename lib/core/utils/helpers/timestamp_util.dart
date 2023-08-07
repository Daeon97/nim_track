// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';

// Reference this class from BLOC not UI
final class TimestampUtil {
  static String computeHourMinuteAmPm(int timestamp) => DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp,
        ),
      );

  static String computeDayMonthDate(int timestamp) => '${DateFormat.E().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp,
        ),
      )} ${DateFormat.LLL().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp,
        ),
      )} ${DateFormat.d().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp,
        ),
      )}';

  static DateTime computeDateTime(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(
        timestamp,
      );
}
