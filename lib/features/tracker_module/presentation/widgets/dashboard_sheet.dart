// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_data_card.dart';

class DashboardSheet extends StatefulWidget {
  const DashboardSheet({super.key});

  @override
  State<DashboardSheet> createState() => _DashboardSheetState();
}

class _DashboardSheetState extends State<DashboardSheet> {
  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
        expand: false,
        snap: true,
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        builder: (_, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Container(
            height: 500,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NodeDataCard(),
              ],
            ),
          ),
        ),
      );
}
