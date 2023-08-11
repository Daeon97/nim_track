// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';
import 'package:nim_track/core/resources/numbers.dart';

final class TimeUtil {
  static String computeHourMinuteAmPm(int timestamp) => DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp * timestampMultiplier,
        ),
      );

  static String computeDayMonthDate(int timestamp) => '${DateFormat.E().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp * timestampMultiplier,
        ),
      )} ${DateFormat.LLL().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp * timestampMultiplier,
        ),
      )} ${DateFormat.d().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp * timestampMultiplier,
        ),
      )}';

  static DateTime computeDateTime(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(
        timestamp * timestampMultiplier,
      );

  static DateTime get currentDateTime => DateTime.now();
}
