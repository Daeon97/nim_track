// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';

final class TimeUtil {
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

  static DateTime get currentDateTime => DateTime.now();
}
