// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/helpers/time_util.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/home_screen_widgets/battery_level_icon_widget.dart';

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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.only(
          top: spacing,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
            ),
            borderRadius: BorderRadius.circular(
              spacing,
            ),
          ),
          child: InkWell(
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
                      switch (faulty) {
                        true => Icons.developer_board_off,
                        false => Icons.developer_board
                      },
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
                            style:
                                Theme.of(context).textTheme.bodyMedium?.merge(
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
                                  TimeUtil.computeHourMinuteAmPm(
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
                              BatteryLevelIconWidget(
                                batteryLevel: batteryLevel,
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
          ),
        ),
      );
}
