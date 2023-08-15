// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart';
import 'package:nim_track/core/utils/helpers/time_util.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/all_tracker_modules_or_one_tracker_module/all_tracker_modules_or_one_tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/home_screen_widgets/battery_level_icon_widget.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer_widgets/node_summary_bottom_card_shimmer_child.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer_widgets/shimmer_widget.dart';

class NodeSummaryBottomCard extends StatelessWidget {
  const NodeSummaryBottomCard({
    required this.cardType,
    super.key,
  });

  final CardType cardType;

  @override
  Widget build(BuildContext context) => BlocBuilder<
          AllTrackerModulesOrOneTrackerModuleBloc,
          AllTrackerModulesOrOneTrackerModuleState>(
        builder: (
          _,
          allTrackerModulesOrOneTrackerModuleState,
        ) =>
            Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: allTrackerModulesOrOneTrackerModuleState
                      is AllTrackerModulesState
                  ? Theme.of(context).dividerColor
                  : Theme.of(context).textTheme.bodyMedium!.color!,
            ),
            borderRadius: BorderRadius.circular(
              spacing,
            ),
          ),
          child: BlocBuilder<TrackerModuleBloc, TrackerModuleState>(
            builder: (_, trackerModuleState) =>
                BlocBuilder<TrackerModulesBloc, TrackerModulesState>(
              builder: (_, trackerModulesState) {
                if (trackerModuleState is GettingTrackerModuleState ||
                    trackerModulesState is ListingTrackerModulesState) {
                  return const ShimmerWidget(
                    child: NodeSummaryBottomCardShimmerChild(),
                  );
                } else if (trackerModuleState is GotTrackerModuleState ||
                    trackerModulesState is ListedTrackerModulesState) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.all(
                      smallSpacing,
                    ),
                    child: Row(
                      children: [
                        switch (allTrackerModulesOrOneTrackerModuleState) {
                          OneTrackerModuleState(id: final _)
                              when trackerModuleState
                                  is GotTrackerModuleState =>
                            switch (cardType) {
                              CardType.batteryLevel => BatteryLevelIconWidget(
                                  batteryLevel: trackerModuleState
                                      .trackerModuleEntity
                                      .data!
                                      .last
                                      .batteryLevel!,
                                ),
                              CardType.time => const Icon(
                                  Icons.access_time,
                                )
                            },
                          _ => Icon(
                              switch (cardType) {
                                CardType.batteryLevel => Icons.battery_unknown,
                                CardType.time => Icons.access_time
                              },
                              color: Theme.of(context).dividerColor,
                            ),
                        },
                        const SizedBox(
                          width: spacing,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                switch (cardType) {
                                  CardType.batteryLevel => batteryLevelLiteral,
                                  CardType.time => timeLiteral
                                },
                                style: allTrackerModulesOrOneTrackerModuleState
                                        is AllTrackerModulesState
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.merge(
                                          TextStyle(
                                            color:
                                                Theme.of(context).dividerColor,
                                          ),
                                        )
                                    : null,
                              ),
                              Text(
                                switch (
                                    allTrackerModulesOrOneTrackerModuleState) {
                                  OneTrackerModuleState(id: final _)
                                      when trackerModuleState
                                          is GotTrackerModuleState =>
                                    switch (cardType) {
                                      CardType.batteryLevel =>
                                        '${trackerModuleState.trackerModuleEntity.data!.last.batteryLevel!}$percentage',
                                      CardType.time =>
                                        TimeUtil.computeHourMinuteAmPm(
                                          trackerModuleState.trackerModuleEntity
                                              .data!.last.timestamp!,
                                        )
                                    },
                                  _ => notApplicableLiteral
                                },
                                overflow: TextOverflow.ellipsis,
                                maxLines: veryTinySpacing.toInt(),
                                style: allTrackerModulesOrOneTrackerModuleState
                                        is AllTrackerModulesState
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.merge(
                                          TextStyle(
                                            color:
                                                Theme.of(context).dividerColor,
                                          ),
                                        )
                                    : null,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const ShimmerWidget(
                    stopShimmer: true,
                    child: NodeSummaryBottomCardShimmerChild(),
                  );
                }
              },
            ),
          ),
        ),
      );
}
