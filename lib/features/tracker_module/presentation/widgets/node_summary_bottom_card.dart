// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer/node_summary_bottom_card_shimmer_child.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer/shimmer_widget.dart';

class NodeSummaryBottomCard extends StatelessWidget {
  const NodeSummaryBottomCard({
    required this.icon,
    required this.headerText,
    this.bodyText,
    super.key,
  });

  final IconData icon;
  final String headerText;
  final String? bodyText;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(
            spacing,
          ),
        ),
        child: BlocBuilder<TrackerModulesBloc, TrackerModulesState>(
          builder: (_, trackerModulesState) => switch (trackerModulesState) {
            ListingTrackerModulesState() => const ShimmerWidget(
                child: NodeSummaryBottomCardShimmerChild(),
              ),
            ListedTrackerModulesState(trackerModuleEntities: final entities) =>
              Padding(
                padding: const EdgeInsetsDirectional.all(
                  smallSpacing,
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: bodyText == null
                          ? Theme.of(context).dividerColor
                          : null,
                    ),
                    const SizedBox(
                      width: spacing,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headerText,
                            style: bodyText == null
                                ? Theme.of(context).textTheme.bodyMedium?.merge(
                                      TextStyle(
                                        color: Theme.of(context).dividerColor,
                                      ),
                                    )
                                : null,
                          ),
                          Text(
                            bodyText ?? notApplicableLiteral,
                            style: bodyText == null
                                ? Theme.of(context).textTheme.bodyMedium?.merge(
                                      TextStyle(
                                        color: Theme.of(context).dividerColor,
                                      ),
                                    )
                                : null,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            _ => const ShimmerWidget(
                stopShimmer: true,
                child: NodeSummaryBottomCardShimmerChild(),
              ),
          },
        ),
      );
}
