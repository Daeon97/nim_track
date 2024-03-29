// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart';
import 'package:nim_track/core/utils/extensions/tracker_module_related_entities_convenience_utils.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/home_screen_widgets/node_data_node_details_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/home_screen_widgets/node_data_top_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer_widgets/shimmer_widget.dart';

class NodeDataCard extends StatelessWidget {
  const NodeDataCard({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: NodeDataTopCard(
                  indicator: Indicator.available,
                ),
              ),
              SizedBox(
                width: spacing,
              ),
              Expanded(
                child: NodeDataTopCard(
                  indicator: Indicator.potentiallyFaulty,
                ),
              ),
            ],
          ),
          BlocBuilder<TrackerModulesBloc, TrackerModulesState>(
            builder: (_, trackerModulesState) => switch (trackerModulesState) {
              ListingTrackerModulesState() => const ShimmerWidget(),
              ListedTrackerModulesState(
                trackerModuleEntities: final entities,
              )
                  when entities.isNotEmpty =>
                Column(
                  children: List<Widget>.generate(
                    entities.length,
                    (index) => NodeDataNodeDetailsCard(
                      id: entities[index].id,
                      name: entities[index].name ??
                          '$nodeLiteral ${entities[index].id}',
                      batteryLevel: entities[index].data!.last.batteryLevel!,
                      potentiallyFaulty: entities[index].potentiallyFaulty,
                      lastTransmissionDate:
                          entities[index].data!.last.timestamp!,
                    ),
                    growable: false,
                  ),
                ),
              ListedTrackerModulesState(
                trackerModuleEntities: final entities,
              )
                  when entities.isEmpty =>
                SizedBox(
                  height: MediaQuery.of(context).size.height / twoDotFive,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: spacing,
                      ),
                      Icon(
                        Icons.developer_board_off,
                        size: largeSpacing + spacing,
                        color: Theme.of(context).dividerColor,
                      ),
                      const SizedBox(
                        height: smallSpacing,
                      ),
                      Text(
                        noNodesLiteral,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              TextStyle(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              _ => const ShimmerWidget(
                  stopShimmer: true,
                )
            },
          ),
        ],
      );
}
