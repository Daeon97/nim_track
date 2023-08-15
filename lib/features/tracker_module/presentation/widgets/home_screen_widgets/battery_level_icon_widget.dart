// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';

class BatteryLevelIconWidget extends StatelessWidget {
  const BatteryLevelIconWidget({
    required this.batteryLevel,
    super.key,
  });

  final int batteryLevel;

  @override
  Widget build(BuildContext context) {
    late IconData iconData;
    Color? color;

    if (batteryLevel <= twentyPercent) {
      iconData = Icons.battery_0_bar;
      color = batteryLowColor;
    } else if (batteryLevel > twentyPercent && batteryLevel <= thirtyPercent) {
      iconData = Icons.battery_1_bar;
      color = batteryLowColor;
    } else if (batteryLevel > thirtyPercent && batteryLevel <= fortyPercent) {
      iconData = Icons.battery_2_bar;
      color = batteryMidLowColor;
    } else if (batteryLevel > fortyPercent && batteryLevel <= fiftyPercent) {
      iconData = Icons.battery_3_bar;
      color = batteryMidLowColor;
    } else if (batteryLevel > fiftyPercent && batteryLevel <= sixtyPercent) {
      iconData = Icons.battery_4_bar;
      color = batteryMidHighColor;
    } else if (batteryLevel > sixtyPercent && batteryLevel <= seventyPercent) {
      iconData = Icons.battery_5_bar;
      color = batteryMidHighColor;
    } else if (batteryLevel > seventyPercent && batteryLevel <= eightyPercent) {
      iconData = Icons.battery_6_bar;
      color = batteryHighColor;
    } else {
      iconData = Icons.battery_full;
      color = batteryHighColor;
    }

    return Icon(
      iconData,
      color: color,
    );
  }
}
