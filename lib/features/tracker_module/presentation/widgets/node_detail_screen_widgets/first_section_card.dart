// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart';
import 'package:nim_track/core/utils/helpers/timestamp_util.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/home_screen_widgets/battery_level_icon_widget.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer_widgets/first_section_card_shimmer_child.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer_widgets/shimmer_widget.dart';

class FirstSectionCard extends StatelessWidget {
  const FirstSectionCard({
    required this.cardType,
    super.key,
  });

  final CardType cardType;

  @override
  Widget build(BuildContext context) => Container(
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
            Text(
              switch (cardType) {
                CardType.batteryLevel => batteryLevelLiteral.toUpperCase(),
                CardType.time => timeLiteral.toUpperCase(),
              },
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: smallSpacing,
            ),
            BlocBuilder<TrackerModuleDetailBloc, TrackerModuleDetailState>(
              builder: (_, trackerModuleDetailState) => Row(
                children: [
                  switch (cardType) {
                    CardType.batteryLevel => switch (trackerModuleDetailState) {
                        GotTrackerModuleDetailState(
                          trackerModuleEntity: final entity,
                        ) =>
                          BatteryLevelIconWidget(
                            batteryLevel: entity.data.last.batteryLevel,
                          ),
                        _ => const Icon(
                            Icons.battery_unknown,
                          ),
                      },
                    CardType.time => const Icon(
                        Icons.access_time,
                      )
                  },
                  switch (cardType) {
                    CardType.batteryLevel => const SizedBox.shrink(),
                    CardType.time => const SizedBox(
                        width: tinySpacing + tinySpacing,
                      )
                  },
                  const SizedBox(
                    width: tinySpacing + tinySpacing,
                  ),
                  Expanded(
                    child: switch (trackerModuleDetailState) {
                      GettingTrackerModuleDetailState() => ShimmerWidget(
                          radius: nil,
                          child: FirstSectionCardShimmerChild(
                            cardType: cardType,
                          ),
                        ),
                      GotTrackerModuleDetailState(
                        trackerModuleEntity: final entity,
                      ) =>
                        Text(
                          switch (cardType) {
                            CardType.batteryLevel =>
                              '${entity.data.last.batteryLevel}$percentage',
                            CardType.time => TimestampUtil.computeMonthYear(
                                entity.data.last.timestamp,
                              )
                          },
                          maxLines: veryTinySpacing.toInt(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      _ => ShimmerWidget(
                          stopShimmer: true,
                          radius: nil,
                          child: FirstSectionCardShimmerChild(
                            cardType: cardType,
                          ),
                        ),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
