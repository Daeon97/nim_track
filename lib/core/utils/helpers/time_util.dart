// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';
import 'package:nim_track/core/resources/numbers.dart';

final class TimeUtil {
  static String computeHourMinuteAmPm(
    int timestamp,
  ) =>
      DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch(
          _computeAccurateTimestamp(
            timestamp,
          ),
        ),
      );

  static String computeDayMonthDate(
    int timestamp,
  ) =>
      '${DateFormat.E().format(
        DateTime.fromMillisecondsSinceEpoch(
          _computeAccurateTimestamp(
            timestamp,
          ),
        ),
      )} ${DateFormat.LLL().format(
        DateTime.fromMillisecondsSinceEpoch(
          _computeAccurateTimestamp(
            timestamp,
          ),
        ),
      )} ${DateFormat.d().format(
        DateTime.fromMillisecondsSinceEpoch(
          _computeAccurateTimestamp(
            timestamp,
          ),
        ),
      )}';

  static DateTime computeDateTime(
    int timestamp,
  ) =>
      DateTime.fromMillisecondsSinceEpoch(
        _computeAccurateTimestamp(
          timestamp,
        ),
      );

  static DateTime get currentDateTime => DateTime.now();

  static int _computeAccurateTimestamp(
    int timestamp,
  ) =>
      switch (timestamp.toString().length) {
        ten => timestamp * timestampMultiplier,
        _ => timestamp
      };
}
