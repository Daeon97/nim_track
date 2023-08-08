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
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).textTheme.bodyMedium!.color!,
          ),
          borderRadius: BorderRadius.circular(
            spacing,
          ),
        ),
        child: BlocBuilder<TrackerModulesBloc, TrackerModulesState>(
          builder: (_, trackerModulesState) => switch (trackerModulesState) {
            ListingTrackerModulesState() => const ShimmerWidget(
                child: NodeDataTopCardShimmerChild(),
              ),
            ListedTrackerModulesState(
              trackerModuleEntities: final entities,
            ) =>
              Padding(
                padding: const EdgeInsetsDirectional.all(
                  smallSpacing,
                ),
                child: Row(
                  children: [
                    Icon(
                      switch (indicator) {
                        Indicator.available => Icons.developer_board,
                        Indicator.faulty => Icons.developer_board_off
                      },
                      color: switch (indicator) {
                        Indicator.available => nodeAvailableColor,
                        Indicator.faulty => nodeProblemsColor
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
                            Indicator.faulty => problemsLiteral
                          },
                          maxLines: veryTinySpacing.toInt(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          switch (indicator) {
                            Indicator.available => '${entities.length}',
                            Indicator.faulty => '${entities.faultyNodes}'
                          },
                          maxLines: veryTinySpacing.toInt(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.merge(
                                const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            _ => const ShimmerWidget(
                stopShimmer: true,
                child: NodeDataTopCardShimmerChild(),
              ),
          },
        ),
      );
}
