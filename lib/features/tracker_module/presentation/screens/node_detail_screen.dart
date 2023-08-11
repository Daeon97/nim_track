// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_name_bloc/tracker_module_name_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_detail_bloc/tracker_modules_detail_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/area_covered_section.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/battery_level_over_time_section.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/distances_travelled_section.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/edit_node_name_sheet.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/first_section_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_detail_screen_widgets/problems_section.dart';
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
    _getTrackerModuleDetail();
    _listTrackerModulesDetail();
    super.initState();
  }

  void _getTrackerModuleDetail() =>
      BlocProvider.of<TrackerModuleDetailBloc>(context).add(
        GetTrackerModuleDetailEvent(
          id: widget.id,
          fields: const [
            enums.Field.batteryLevel,
            enums.Field.latLng,
            enums.Field.timestamp,
          ],
        ),
      );

  void _listTrackerModulesDetail() =>
      BlocProvider.of<TrackerModulesDetailBloc>(context).add(
        const ListTrackerModulesDetailEvent(
          fields: [
            enums.Field.name,
            enums.Field.latLng,
          ],
        ),
      );

  @override
  Widget build(BuildContext context) =>
      BlocListener<TrackerModuleNameBloc, TrackerModuleNameState>(
        listener: (trackerModuleNameContext, trackerModuleNameState) {
          if (trackerModuleNameState is UpdatedTrackerModuleNameState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '$nodeNameUpdatedToLiteral $singleQuote${trackerModuleNameState.result}$singleQuote$fullStop $refreshToSeeLatestChanges',
                ),
                dismissDirection: DismissDirection.horizontal,
              ),
            );
          } else if (trackerModuleNameState
              is FailedToUpdateTrackerModuleNameState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  couldNotUpdateNodeNameLiteral,
                ),
                duration: const Duration(
                  seconds:
                      snackBarDurationOnFailedToUpdateTrackerModuleNameSeconds,
                ),
                dismissDirection: DismissDirection.horizontal,
                action: SnackBarAction(
                  label: retryLiteral,
                  onPressed: () {
                    trackerModuleNameContext.read<TrackerModuleNameBloc>().add(
                          UpdateTrackerModuleNameEvent(
                            id: trackerModuleNameState.id,
                            name: trackerModuleNameState.name,
                          ),
                        );
                    ScaffoldMessenger.of(context).clearSnackBars();
                  },
                ),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.vertical(
                bottom: Radius.circular(
                  spacing,
                ),
              ),
            ),
            title:
                BlocBuilder<TrackerModuleDetailBloc, TrackerModuleDetailState>(
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
            actions: [
              BlocBuilder<TrackerModuleDetailBloc, TrackerModuleDetailState>(
                builder: (_, trackerModuleDetailState) => BlocBuilder<
                    TrackerModulesDetailBloc, TrackerModulesDetailState>(
                  builder: (_, trackerModulesDetailState) {
                    if ((trackerModuleDetailState
                                is FailedToGetTrackerModuleDetailState &&
                            trackerModulesDetailState
                                is FailedToListTrackerModulesDetailState) ||
                        (trackerModuleDetailState
                                is FailedToGetTrackerModuleDetailState &&
                            trackerModulesDetailState
                                is ListedTrackerModulesDetailState) ||
                        (trackerModuleDetailState
                                is GotTrackerModuleDetailState &&
                            trackerModulesDetailState
                                is FailedToListTrackerModulesDetailState)) {
                      return IconButton(
                        onPressed: () {
                          if (trackerModuleDetailState
                                  is FailedToGetTrackerModuleDetailState &&
                              trackerModulesDetailState
                                  is FailedToListTrackerModulesDetailState) {
                            _getTrackerModuleDetail();
                            _listTrackerModulesDetail();
                          } else if (trackerModuleDetailState
                                  is FailedToGetTrackerModuleDetailState &&
                              trackerModulesDetailState
                                  is ListedTrackerModulesDetailState) {
                            _getTrackerModuleDetail();
                          } else if (trackerModuleDetailState
                                  is GotTrackerModuleDetailState &&
                              trackerModulesDetailState
                                  is FailedToListTrackerModulesDetailState) {
                            _listTrackerModulesDetail();
                          }
                        },
                        icon: const Icon(
                          Icons.refresh,
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              BlocBuilder<TrackerModuleDetailBloc, TrackerModuleDetailState>(
                builder: (_, trackerModuleDetailState) =>
                    BlocBuilder<TrackerModuleNameBloc, TrackerModuleNameState>(
                  builder: (_, trackerModuleNameState) =>
                      switch (trackerModuleDetailState) {
                    GotTrackerModuleDetailState(
                      trackerModuleEntity: final entity,
                    )
                        when trackerModuleNameState
                            is! UpdatingTrackerModuleNameState =>
                      IconButton(
                        onPressed: () => showModalBottomSheet<String>(
                          context: context,
                          isDismissible: false,
                          builder: (_) => Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: EditNodeNameSheet(
                              id: widget.id,
                              name: entity.name,
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    _ => const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.edit,
                        ),
                      ),
                  },
                ),
              ),
            ],
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
                const ProblemsSection(),
                const SizedBox(
                  height: spacing,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: FirstSectionCard(
                        cardType: enums.CardType.batteryLevel,
                      ),
                    ),
                    SizedBox(
                      width: spacing,
                    ),
                    Expanded(
                      child: FirstSectionCard(
                        cardType: enums.CardType.time,
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
        ),
      );
}
