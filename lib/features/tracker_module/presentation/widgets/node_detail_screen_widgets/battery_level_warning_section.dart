// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/home_screen_widgets/battery_level_icon_widget.dart';

class BatteryLevelWarningSection extends StatelessWidget {
  const BatteryLevelWarningSection({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TrackerModuleDetailBloc, TrackerModuleDetailState>(
        builder: (_, trackerModuleDetailState) => trackerModuleDetailState
                    is GotTrackerModuleDetailState &&
                trackerModuleDetailState
                        .trackerModuleEntity.data.last.batteryLevel <=
                    thirtyPercent
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BatteryLevelIconWidget(
                        batteryLevel: trackerModuleDetailState
                            .trackerModuleEntity.data.last.batteryLevel,
                      ),
                      const SizedBox(
                        width: tinySpacing + tinySpacing,
                      ),
                      Text(
                        trackerModuleDetailState.trackerModuleEntity.data.last
                                    .batteryLevel <=
                                tenPercent
                            ? batteryCriticalLiteral
                            : trackerModuleDetailState.trackerModuleEntity.data
                                            .last.batteryLevel >
                                        tenPercent &&
                                    trackerModuleDetailState.trackerModuleEntity
                                            .data.last.batteryLevel <=
                                        twentyPercent
                                ? batteryLowLiteral
                                : batteryGettingLowLiteral,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              const TextStyle(
                                color: batteryLowColor,
                              ),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: spacing + smallSpacing,
                  ),
                ],
              )
            : const SizedBox.shrink(),
      );
}
