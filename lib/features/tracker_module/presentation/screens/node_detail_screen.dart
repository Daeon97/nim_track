// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/area_covered_section.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/battery_level_over_time_section.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/node_distances_section.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/overview_section.dart';

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
    BlocProvider.of<TrackerModuleBloc>(context).add(
      GetTrackerModuleEvent(
        id: widget.id,
      ),
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
        ),
        body: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: spacing,
          ),
          child: Column(
            children: [
              // const SizedBox(
              //   height: spacing,
              // ),
              // OverviewSection(),
              const SizedBox(
                height: spacing,
              ),
              BatteryLevelOverTimeSection(),
              const SizedBox(
                height: spacing,
              ),
              // NodeDistancesSection(),
              // const SizedBox(
              //   height: spacing,
              // ),
              AreaCoveredSection(),
              const SizedBox(
                height: spacing,
              ),
              const SizedBox(
                height: spacing,
              ),
            ],
          ),
        ),
      );
}
