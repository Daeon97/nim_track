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
  late final ValueNotifier<bool> _isAttachedListenable;
  late final ValueNotifier<double> _sizeListenable;

  @override
  void initState() {
    _dashboardSheetController = DraggableScrollableController();
    _dashboardSheetController.addListener(
      _dashboardSheetControllerListener,
    );
    _isAttachedListenable = ValueNotifier<bool>(
      false,
    );
    _sizeListenable = ValueNotifier<double>(
      minChildSize,
    );
    super.initState();
  }

  @override
  void dispose() {
    _dashboardSheetController
      ..removeListener(
        _dashboardSheetControllerListener,
      )
      ..dispose();
    _isAttachedListenable.dispose();
    _sizeListenable.dispose();
    super.dispose();
  }

  void _dashboardSheetControllerListener() {
    _isAttachedListenable.value = _dashboardSheetController.isAttached;
    _sizeListenable.value = _dashboardSheetController.size;
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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(
                      spacing,
                    ),
                  ),
                  height: veryTinySpacing + tinySpacing,
                  width: largeSpacing,
                ),
                const SizedBox(
                  height: spacing,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isAttachedListenable,
                  builder: (_, isAttachedValue, __) =>
                      ValueListenableBuilder<double>(
                    valueListenable: _sizeListenable,
                    builder: (_, sizeValue, __) => switch (isAttachedValue) {
                      true when sizeValue > minChildSize =>
                        const NodeDataCard(),
                      _ => const NodeSummaryCard()
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
