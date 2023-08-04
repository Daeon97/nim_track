// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets//shimmer_widgets/shimmer_widget.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer_widgets/node_data_top_card_shimmer_child.dart';

class NodeDataTopCard extends StatelessWidget {
  const NodeDataTopCard({
    required this.icon,
    required this.iconColor,
    required this.headerText,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String headerText;

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
                      icon,
                      color: iconColor,
                    ),
                    const SizedBox(
                      width: spacing,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          headerText,
                          maxLines: veryTinySpacing.toInt(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          entities.length.toString(),
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
