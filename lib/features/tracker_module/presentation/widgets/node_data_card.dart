// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_data_node_details_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_data_top_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer/shimmer_widget.dart';

class NodeDataCard extends StatelessWidget {
  const NodeDataCard({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: NodeDataTopCard(
                  icon: Icons.developer_board,
                  iconColor: nodeAvailableColor,
                  headerText: availableLiteral,
                ),
              ),
              const SizedBox(
                width: spacing,
              ),
              Expanded(
                child: NodeDataTopCard(
                  icon: Icons.developer_board_off,
                  iconColor: nodeProblemsColor,
                  headerText: problemsLiteral,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: spacing,
          ),
          BlocBuilder<TrackerModulesBloc, TrackerModulesState>(
            builder: (_, trackerModulesState) => switch (trackerModulesState) {
              ListingTrackerModulesState() => const ShimmerWidget(),
              ListedTrackerModulesState(
                trackerModuleEntities: final entities,
              ) =>
                Column(
                  children: List<Widget>.generate(
                    entities.length,
                    (index) => NodeDataNodeDetailsCard(
                      nodeName: entities[index].name ??
                          '$nodeLiteral ${entities[index].id}',
                      batteryLevel: entities[index].data.last.batteryLevel,
                      faulty: false,
                      lastTransmissionDate: entities[index].data.last.timestamp,
                    ),
                    growable: false,
                  ),
                ),
              _ => const ShimmerWidget()
            },
          ),
        ],
      );
}
