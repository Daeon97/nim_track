// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/all_tracker_modules_or_one_tracker_module/all_tracker_modules_or_one_tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/home_screen_widgets/node_summary_bottom_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/home_screen_widgets/shimmer/shimmer_widget.dart';

class NodeSummaryCard extends StatefulWidget {
  const NodeSummaryCard({super.key});

  @override
  State<NodeSummaryCard> createState() => _NodeSummaryCardState();
}

class _NodeSummaryCardState extends State<NodeSummaryCard> {
  late final FixedExtentScrollController _listWheelScrollViewController;

  @override
  void initState() {
    _listWheelScrollViewController = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _listWheelScrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: extraLargeSpacing,
            child: BlocBuilder<TrackerModulesBloc, TrackerModulesState>(
              builder: (_, trackerModulesState) =>
                  switch (trackerModulesState) {
                ListingTrackerModulesState() => const ShimmerWidget(),
                ListedTrackerModulesState(
                  trackerModuleEntities: final entities
                ) =>
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_listWheelScrollViewController.selectedItem >
                              _listWheelScrollViewController.initialItem) {
                            _listWheelScrollViewController.animateToItem(
                              _listWheelScrollViewController.selectedItem -
                                  veryTinySpacing.toInt(),
                              duration: const Duration(
                                milliseconds:
                                    nodeSummaryCardFirstCardListWheelScrollViewAnimationDurationMilliseconds,
                              ),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_left,
                        ),
                      ),
                      Expanded(
                        child: RotatedBox(
                          quarterTurns: -veryTinySpacing.toInt(),
                          child: ListWheelScrollView(
                            controller: _listWheelScrollViewController,
                            itemExtent: extraLargeSpacing + largeSpacing,
                            diameterRatio: tinySpacing + veryTinySpacing,
                            children: List<Widget>.generate(
                              entities.length,
                              (index) => RotatedBox(
                                quarterTurns: veryTinySpacing.toInt(),
                                child: BlocBuilder<
                                    AllTrackerModulesOrOneTrackerModuleBloc,
                                    AllTrackerModulesOrOneTrackerModuleState>(
                                  builder: (
                                    _,
                                    allTrackerModulesOrOneTrackerModuleState,
                                  ) =>
                                      BlocBuilder<TrackerModuleBloc,
                                          TrackerModuleState>(
                                    builder: (_, trackerModuleState) =>
                                        ChoiceChip(
                                      label: Text(
                                        entities[index].name ??
                                            '$nodeLiteral ${entities[index].id}',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: tinySpacing.toInt(),
                                      ),
                                      selected:
                                          allTrackerModulesOrOneTrackerModuleState
                                                  is OneTrackerModuleState &&
                                              trackerModuleState
                                                  is GotTrackerModuleState &&
                                              trackerModuleState
                                                      .trackerModuleEntity.id ==
                                                  entities[index].id,
                                      onSelected: (selected) =>
                                          trackerModuleState
                                                  is GettingTrackerModuleState
                                              ? null
                                              : switch (selected) {
                                                  true => context
                                                      .read<
                                                          AllTrackerModulesOrOneTrackerModuleBloc>()
                                                      .add(
                                                        GetOneTrackerModuleEvent(
                                                          id: entities[index]
                                                              .id,
                                                        ),
                                                      ),
                                                  false => context
                                                      .read<
                                                          AllTrackerModulesOrOneTrackerModuleBloc>()
                                                      .add(
                                                        const GetAllTrackerModulesEvent(),
                                                      )
                                                },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_listWheelScrollViewController.selectedItem <
                              entities.length - veryTinySpacing.toInt()) {
                            _listWheelScrollViewController.animateToItem(
                              _listWheelScrollViewController.selectedItem +
                                  veryTinySpacing.toInt(),
                              duration: const Duration(
                                milliseconds:
                                    nodeSummaryCardFirstCardListWheelScrollViewAnimationDurationMilliseconds,
                              ),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_right,
                        ),
                      ),
                    ],
                  ),
                _ => const ShimmerWidget(
                    stopShimmer: true,
                  ),
              },
            ),
          ),
          const SizedBox(
            height: spacing,
          ),
          const Row(
            children: [
              Expanded(
                child: NodeSummaryBottomCard(
                  nodeSummaryBottomCardType:
                      NodeSummaryBottomCardType.batteryLevel,
                ),
              ),
              SizedBox(
                width: spacing,
              ),
              Expanded(
                child: NodeSummaryBottomCard(
                  nodeSummaryBottomCardType: NodeSummaryBottomCardType.time,
                ),
              ),
            ],
          ),
        ],
      );
}
