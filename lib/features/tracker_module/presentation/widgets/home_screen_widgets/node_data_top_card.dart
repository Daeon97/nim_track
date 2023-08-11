// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart';
import 'package:nim_track/core/utils/extensions/tracker_module_related_entities_convenience_utils.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets//shimmer_widgets/shimmer_widget.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer_widgets/node_data_top_card_shimmer_child.dart';

class NodeDataTopCard extends StatelessWidget {
  const NodeDataTopCard({
    required this.indicator,
    super.key,
  });

  final Indicator indicator;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TrackerModulesBloc, TrackerModulesState>(
        builder: (_, trackerModulesState) => switch (trackerModulesState) {
          ListingTrackerModulesState() => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                ),
                borderRadius: BorderRadius.circular(
                  spacing,
                ),
              ),
              child: const ShimmerWidget(
                child: NodeDataTopCardShimmerChild(),
              ),
            ),
          ListedTrackerModulesState(
            trackerModuleEntities: final entities,
          ) =>
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: switch (indicator) {
                    Indicator.available when entities.isEmpty =>
                      Theme.of(context).dividerColor,
                    Indicator.potentiallyFaulty
                        when entities.potentiallyFaultyNodes == nil.toInt() =>
                      Theme.of(context).dividerColor,
                    _ => Theme.of(context).textTheme.bodyMedium!.color!
                  },
                ),
                borderRadius: BorderRadius.circular(
                  spacing,
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.all(
                  smallSpacing,
                ),
                child: Row(
                  children: [
                    Icon(
                      switch (indicator) {
                        Indicator.available when entities.isEmpty =>
                          Icons.developer_board_off,
                        Indicator.potentiallyFaulty
                            when entities.potentiallyFaultyNodes ==
                                nil.toInt() =>
                          Icons.developer_board_off,
                        _ => Icons.developer_board
                      },
                      color: switch (indicator) {
                        Indicator.available when entities.isNotEmpty =>
                          availableNodesColor,
                        Indicator.available when entities.isEmpty =>
                          noAvailableNodesColor,
                        Indicator.potentiallyFaulty
                            when entities.potentiallyFaultyNodes >
                                nil.toInt() =>
                          potentiallyFaultyNodesColor,
                        _ => noPotentiallyFaultyNodesColor
                      },
                    ),
                    const SizedBox(
                      width: spacing,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          switch (indicator) {
                            Indicator.available => availableLiteral,
                            Indicator.potentiallyFaulty => problemsLiteral
                          },
                          maxLines: veryTinySpacing.toInt(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.merge(
                                TextStyle(
                                  color: switch (indicator) {
                                    Indicator.available when entities.isEmpty =>
                                      Theme.of(context).dividerColor,
                                    Indicator.potentiallyFaulty
                                        when entities.potentiallyFaultyNodes ==
                                            nil.toInt() =>
                                      Theme.of(context).dividerColor,
                                    _ => null,
                                  },
                                ),
                              ),
                        ),
                        Text(
                          switch (indicator) {
                            Indicator.available => '${entities.length}',
                            Indicator.potentiallyFaulty =>
                              '${entities.potentiallyFaultyNodes}'
                          },
                          maxLines: veryTinySpacing.toInt(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.merge(
                                TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: switch (indicator) {
                                    Indicator.available when entities.isEmpty =>
                                      Theme.of(context).dividerColor,
                                    Indicator.potentiallyFaulty
                                        when entities.potentiallyFaultyNodes ==
                                            nil.toInt() =>
                                      Theme.of(context).dividerColor,
                                    _ => null,
                                  },
                                ),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          _ => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                ),
                borderRadius: BorderRadius.circular(
                  spacing,
                ),
              ),
              child: const ShimmerWidget(
                stopShimmer: true,
                child: NodeDataTopCardShimmerChild(),
              ),
            ),
        },
      );
}
