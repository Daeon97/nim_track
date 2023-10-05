// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';
import 'package:nim_track/core/resources/numbers.dart';

final class TimeUtil {
  static String computeHourMinuteAmPm(
    num timestamp,
  ) =>
      DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch(
          _computeAccurateTimestamp(
            timestamp,
          ),
        ),
      );

  static String computeDayMonthDate(
    num timestamp,
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
    num timestamp,
  ) =>
      DateTime.fromMillisecondsSinceEpoch(
        _computeAccurateTimestamp(
          timestamp,
        ),
      );

  static DateTime get currentDateTime => DateTime.now();

  static int _computeAccurateTimestamp(
    num timestamp,
  ) =>
      switch (timestamp.toInt().toString().length) {
        ten => timestamp.toInt() * timestampMultiplier,
        _ => timestamp.toInt()
      };
}
