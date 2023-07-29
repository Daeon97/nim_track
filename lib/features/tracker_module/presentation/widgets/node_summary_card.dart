// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_data_top_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/shimmer/shimmer_widget.dart';

class NodeSummaryCard extends StatefulWidget {
  const NodeSummaryCard({super.key});

  @override
  State<NodeSummaryCard> createState() => _NodeSummaryCardState();
}

class _NodeSummaryCardState extends State<NodeSummaryCard> {
  late final FixedExtentScrollController _listWheelScrollViewController;
  late final ValueNotifier<int?> _selectedNode;

  @override
  void initState() {
    _listWheelScrollViewController = FixedExtentScrollController();
    _selectedNode = ValueNotifier<int?>(null);
    super.initState();
  }

  @override
  void dispose() {
    _listWheelScrollViewController.dispose();
    _selectedNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: tinySpacing.toInt(),
                child: Container(
                  height: extraLargeSpacing,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      spacing,
                    ),
                  ),
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
                                if (_listWheelScrollViewController
                                        .selectedItem >
                                    _listWheelScrollViewController
                                        .initialItem) {
                                  _listWheelScrollViewController.animateToItem(
                                    _listWheelScrollViewController
                                            .selectedItem -
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
                                      child: InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(
                                          spacing,
                                        ),
                                        child: ValueListenableBuilder<int?>(
                                          valueListenable: _selectedNode,
                                          builder: (_, selectedNodeValue, __) =>
                                              ChoiceChip(
                                            label: Text(
                                              entities[index].name ??
                                                  '$nodeLiteral ${entities[index].id}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: tinySpacing.toInt(),
                                            ),
                                            selected:
                                                selectedNodeValue == index,
                                            onSelected: (selected) =>
                                                _selectedNode.value =
                                                    selected ? index : null,
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
                                if (_listWheelScrollViewController
                                        .selectedItem <
                                    entities.length - veryTinySpacing.toInt()) {
                                  _listWheelScrollViewController.animateToItem(
                                    _listWheelScrollViewController
                                            .selectedItem +
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
              ),
              const SizedBox(
                width: spacing,
              ),
              Expanded(
                child: NodeDataTopCard(
                  icon: Icons.developer_board,
                  iconColor: nodeAvailableColor,
                  headerText: availableLiteral,
                  valueText: smallSpacing.toInt().toString(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: spacing,
          ),
          Row(
            children: [
              Expanded(
                child: NodeDataTopCard(
                  icon: Icons.developer_board_off,
                  iconColor: nodeProblemsColor,
                  headerText: problemsLiteral,
                  valueText: veryTinySpacing.toInt().toString(),
                ),
              ),
              const SizedBox(
                width: spacing,
              ),
              Expanded(
                flex: tinySpacing.toInt(),
                child: Container(
                  height: extraLargeSpacing -
                      (veryTinySpacing + tinySpacing + tinySpacing),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      spacing,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
