// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';

// Reference this class from BLOC not UI
final class TimestampUtil {
  static String computeDate(int timestamp) => DateFormat.yMMMEd().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp,
        ),
      );
}
