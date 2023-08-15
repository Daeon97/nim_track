// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/helpers/time_util.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BatteryLevelOverTimeSection extends StatelessWidget {
  const BatteryLevelOverTimeSection({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.all(
          spacing,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).textTheme.bodyMedium!.color!,
          ),
          borderRadius: BorderRadius.circular(
            spacing,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.all(
                    smallSpacing,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.battery_std,
                  ),
                ),
                const SizedBox(
                  width: spacing,
                ),
                Expanded(
                  child: Text(
                    batteryLevelOverTimeLiteral,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: spacing + smallSpacing,
            ),
            SizedBox(
              height: batteryLevelOverTimeSectionGraphHeight,
              child: BlocBuilder<TrackerModuleDetailBloc,
                  TrackerModuleDetailState>(
                builder: (_, trackerModuleDetailState) =>
                    switch (trackerModuleDetailState) {
                  GettingTrackerModuleDetailState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  GotTrackerModuleDetailState(
                    trackerModuleEntity: final entity,
                  )
                      when entity.data!.length > veryTinySpacing.toInt() =>
                    SfCartesianChart(
                      margin: EdgeInsets.zero,
                      primaryXAxis: DateTimeAxis(
                        isVisible: true,
                        dateFormat: DateFormat.MMMd().add_jm(),
                      ),
                      primaryYAxis: NumericAxis(
                        isVisible: true,
                        numberFormat: NumberFormat.percentPattern(),
                      ),
                      tooltipBehavior: TooltipBehavior(
                        activationMode: ActivationMode.singleTap,
                        enable: true,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        elevation: smallSpacing,
                        textStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                      crosshairBehavior: CrosshairBehavior(
                        activationMode: ActivationMode.singleTap,
                        enable: true,
                        lineColor:
                            Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      series: <LineSeries<TrackerModuleDataEntity, DateTime>>[
                        LineSeries<TrackerModuleDataEntity, DateTime>(
                          dataSource: entity.data!,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          xAxisName: batteryLevelLiteral,
                          yAxisName: timeLiteral,
                          xValueMapper: (trackerModuleDataEntity, _) =>
                              TimeUtil.computeDateTime(
                            trackerModuleDataEntity.timestamp!,
                          ),
                          yValueMapper: (trackerModuleDataEntity, _) =>
                              trackerModuleDataEntity.batteryLevel! /
                              hundredPercent,
                          width: tinySpacing,
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            height: tinySpacing + tinySpacing,
                            width: tinySpacing + tinySpacing,
                            shape: DataMarkerType.circle,
                            borderWidth: veryTinySpacing + tinySpacing,
                            borderColor:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                          ),
                        )
                      ],
                    ),
                  GotTrackerModuleDetailState(
                    trackerModuleEntity: final entity,
                  )
                      when entity.data!.length <= veryTinySpacing.toInt() =>
                    const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning,
                            size: largeSpacing + spacing,
                          ),
                          SizedBox(
                            height: smallSpacing,
                          ),
                          Text(
                            notEnoughDataLiteral,
                          ),
                        ],
                      ),
                    ),
                  _ => const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            size: largeSpacing + spacing,
                          ),
                          SizedBox(
                            height: smallSpacing,
                          ),
                          Text(
                            errorDisplayingDataLiteral,
                          ),
                        ],
                      ),
                    ),
                },
              ),
            ),
          ],
        ),
      );
}
