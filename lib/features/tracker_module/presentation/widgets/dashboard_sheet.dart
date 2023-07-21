// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_data_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_summary_card.dart';

class DashboardSheet extends StatefulWidget {
  const DashboardSheet({super.key});

  @override
  State<DashboardSheet> createState() => _DashboardSheetState();
}

class _DashboardSheetState extends State<DashboardSheet> {
  late final DraggableScrollableController _dashboardSheetController;

  @override
  void initState() {
    _dashboardSheetController = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    _dashboardSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
        controller: _dashboardSheetController,
        expand: false,
        snap: true,
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        builder: (_, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsetsDirectional.all(
              spacing,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(
                  spacing,
                ),
              ),
            ),
            child: NodeSummaryCard(),
            // child: switch (_dashboardSheetController.isAttached) {
            //   true => switch (_dashboardSheetController.size) {
            //       initialChildSize => const NodeSummaryCard(),
            //       _ => const NodeDataCard()
            //     },
            //   false => const SizedBox.shrink()
            // },
          ),
        ),
      );
}
