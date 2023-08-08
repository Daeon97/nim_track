// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_detail_bloc/tracker_modules_detail_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/area_covered_section.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/battery_level_over_time_section.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/distances_travelled_section.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/first_section_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer_widgets/first_section_card_shimmer_child.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer_widgets/shimmer_widget.dart';

class NodeDetailScreen extends StatefulWidget {
  const NodeDetailScreen({
    required this.id,
    super.key,
  });

  final int id;

  @override
  State<NodeDetailScreen> createState() => _NodeDetailScreenState();
}

class _NodeDetailScreenState extends State<NodeDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<TrackerModuleDetailBloc>(context).add(
      GetTrackerModuleDetailEvent(
        id: widget.id,
      ),
    );
    BlocProvider.of<TrackerModulesDetailBloc>(context).add(
      const ListTrackerModulesDetailEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.vertical(
              bottom: Radius.circular(
                spacing,
              ),
            ),
          ),
          title: BlocBuilder<TrackerModuleDetailBloc, TrackerModuleDetailState>(
            builder: (_, trackerModuleDetailState) =>
                switch (trackerModuleDetailState) {
              GettingTrackerModuleDetailState() => const ShimmerWidget(
                  radius: nil,
                  child: FirstSectionCardShimmerChild(),
                ),
              GotTrackerModuleDetailState(
                trackerModuleEntity: final entity,
              ) =>
                Text(
                  entity.name ?? '$nodeLiteral ${entity.id}',
                  maxLines: veryTinySpacing.toInt(),
                  overflow: TextOverflow.ellipsis,
                ),
              _ => const ShimmerWidget(
                  stopShimmer: true,
                  radius: nil,
                  child: FirstSectionCardShimmerChild(),
                ),
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: spacing,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: spacing,
              ),
              const Row(
                children: [
                  Expanded(
                    child: FirstSectionCard(
                      cardType: CardType.batteryLevel,
                    ),
                  ),
                  SizedBox(
                    width: spacing,
                  ),
                  Expanded(
                    child: FirstSectionCard(
                      cardType: CardType.time,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: spacing,
              ),
              DistancesTravelledSection(
                id: widget.id,
              ),
              const SizedBox(
                height: spacing,
              ),
              AreaCoveredSection(),
              const SizedBox(
                height: spacing,
              ),
              const BatteryLevelOverTimeSection(),
              const SizedBox(
                height: spacing,
              ),
            ],
          ),
        ),
      );
}
