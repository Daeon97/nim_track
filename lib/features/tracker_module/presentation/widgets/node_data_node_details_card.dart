// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/extensions.dart';
import 'package:nim_track/core/utils/helpers/timestamp_util.dart';

class NodeDataNodeDetailsCard extends StatelessWidget {
  const NodeDataNodeDetailsCard({
    required this.id,
    required this.name,
    required this.batteryLevel,
    required this.faulty,
    required this.lastTransmissionDate,
    super.key,
  });

  final int id;
  final String name;
  final int batteryLevel;
  final bool faulty;
  final int lastTransmissionDate;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(
          spacing,
        ),
        onTap: () => Navigator.of(context).pushNamed(
          nodeDetailScreenRoute,
          arguments: id,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(
            smallSpacing,
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Icon(
                  Icons.developer_board,
                  color: !faulty ? nodeAvailableColor : nodeProblemsColor,
                ),
                const SizedBox(
                  width: spacing,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: veryTinySpacing.toInt(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                          ),
                          const SizedBox(
                            width: tinySpacing + tinySpacing,
                          ),
                          Expanded(
                            child: Text(
                              TimestampUtil.computeDate(
                                lastTransmissionDate,
                              ),
                              maxLines: veryTinySpacing.toInt(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        batteryLevelLiteral,
                      ),
                      Row(
                        children: [
                          Icon(
                            _getBatteryLevelIcon(
                              batteryLevel: batteryLevel,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '$batteryLevel$percentage',
                              maxLines: veryTinySpacing.toInt(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: spacing,
                ),
                const Icon(
                  Icons.navigate_next,
                ),
              ],
            ),
          ),
        ),
      );

  IconData _getBatteryLevelIcon({
    required int batteryLevel,
  }) {
    late IconData iconData;

    if (batteryLevel < twentyPercent) {
      iconData = Icons.battery_0_bar;
    } else if (batteryLevel >= twentyPercent && batteryLevel < thirtyPercent) {
      iconData = Icons.battery_1_bar;
    } else if (batteryLevel >= thirtyPercent && batteryLevel < fortyPercent) {
      iconData = Icons.battery_2_bar;
    } else if (batteryLevel >= fortyPercent && batteryLevel < fiftyPercent) {
      iconData = Icons.battery_3_bar;
    } else if (batteryLevel >= fiftyPercent && batteryLevel < sixtyPercent) {
      iconData = Icons.battery_4_bar;
    } else if (batteryLevel >= sixtyPercent && batteryLevel < seventyPercent) {
      iconData = Icons.battery_5_bar;
    } else if (batteryLevel >= seventyPercent && batteryLevel < eightyPercent) {
      iconData = Icons.battery_6_bar;
    } else {
      iconData = Icons.battery_full;
    }

    return iconData;
  }
}
