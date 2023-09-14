// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_name_get_bloc/tracker_module_name_get_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_name_update_bloc/tracker_module_name_update_bloc.dart';
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
    _getTrackerModuleName();
    _getTrackerModuleDetail();
    _listTrackerModulesDetail();
    super.initState();
  }

  void _getTrackerModuleName() => context.read<TrackerModuleNameGetBloc>().add(
        GetTrackerModuleNameEvent(
          id: widget.id,
          fields: const [
            enums.Field.name,
          ],
        ),
      );

  void _getTrackerModuleDetail() => context.read<TrackerModuleDetailBloc>().add(
        GetTrackerModuleDetailEvent(
          id: widget.id,
          fields: const [
            enums.Field.batteryLevel,
            enums.Field.hash,
            enums.Field.latLng,
            enums.Field.timestamp,
          ],
        ),
      );

  void _listTrackerModulesDetail() =>
      context.read<TrackerModulesDetailBloc>().add(
            const ListTrackerModulesDetailEvent(
              fields: [
                enums.Field.name,
                enums.Field.latLng,
              ],
            ),
          );

  @override
  Widget build(BuildContext context) =>
      BlocListener<TrackerModuleNameUpdateBloc, TrackerModuleNameUpdateState>(
        listener: (_, trackerModuleNameUpdateState) {
          if (trackerModuleNameUpdateState is UpdatedTrackerModuleNameState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '$nodeNameUpdatedToLiteral $singleQuote${trackerModuleNameUpdateState.result}$singleQuote',
                ),
                behavior: SnackBarBehavior.floating,
                dismissDirection: DismissDirection.horizontal,
              ),
            );
            _getTrackerModuleName();
          } else if (trackerModuleNameUpdateState
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
                    context.read<TrackerModuleNameUpdateBloc>().add(
                          UpdateTrackerModuleNameEvent(
                            id: trackerModuleNameUpdateState.id,
                            name: trackerModuleNameUpdateState.name,
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
            title: BlocBuilder<TrackerModuleNameGetBloc,
                TrackerModuleNameGetState>(
              builder: (_, trackerModuleNameGetState) =>
                  switch (trackerModuleNameGetState) {
                GettingTrackerModuleNameState() => const ShimmerWidget(
                    radius: nil,
                    child: FirstSectionCardShimmerChild(),
                  ),
                GotTrackerModuleNameState(
                  result: final name,
                ) =>
                  Text(
                    name ?? '$nodeLiteral ${widget.id}',
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
                  builder: (_, trackerModulesDetailState) => BlocBuilder<
                      TrackerModuleNameGetBloc, TrackerModuleNameGetState>(
                    builder: (_, trackerModuleNameGetState) {
                      if ((trackerModuleDetailState is FailedToGetTrackerModuleDetailState && trackerModulesDetailState is FailedToListTrackerModulesDetailState && trackerModuleNameGetState is FailedToGetTrackerModuleNameState) ||
                          (trackerModuleDetailState
                                  is FailedToGetTrackerModuleDetailState &&
                              trackerModulesDetailState
                                  is FailedToListTrackerModulesDetailState &&
                              trackerModuleNameGetState
                                  is GotTrackerModuleNameState) ||
                          (trackerModuleDetailState
                                  is FailedToGetTrackerModuleDetailState &&
                              trackerModulesDetailState
                                  is ListedTrackerModulesDetailState &&
                              trackerModuleNameGetState
                                  is FailedToGetTrackerModuleNameState) ||
                          (trackerModuleDetailState is FailedToGetTrackerModuleDetailState &&
                              trackerModulesDetailState
                                  is ListedTrackerModulesDetailState &&
                              trackerModuleNameGetState
                                  is GotTrackerModuleNameState) ||
                          (trackerModuleDetailState
                                  is GotTrackerModuleDetailState &&
                              trackerModulesDetailState
                                  is FailedToListTrackerModulesDetailState &&
                              trackerModuleNameGetState
                                  is FailedToGetTrackerModuleNameState) ||
                          (trackerModuleDetailState
                                  is GotTrackerModuleDetailState &&
                              trackerModulesDetailState
                                  is FailedToListTrackerModulesDetailState &&
                              trackerModuleNameGetState
                                  is GotTrackerModuleNameState) ||
                          (trackerModuleDetailState
                                  is GotTrackerModuleDetailState &&
                              trackerModulesDetailState
                                  is ListedTrackerModulesDetailState &&
                              trackerModuleNameGetState
                                  is FailedToGetTrackerModuleNameState)) {
                        return IconButton(
                          onPressed: () {
                            if (trackerModuleDetailState
                                    is FailedToGetTrackerModuleDetailState &&
                                trackerModulesDetailState
                                    is FailedToListTrackerModulesDetailState &&
                                trackerModuleNameGetState
                                    is FailedToGetTrackerModuleNameState) {
                              _getTrackerModuleName();
                              _getTrackerModuleDetail();
                              _listTrackerModulesDetail();
                            } else if (trackerModuleDetailState
                                    is FailedToGetTrackerModuleDetailState &&
                                trackerModulesDetailState
                                    is FailedToListTrackerModulesDetailState &&
                                trackerModuleNameGetState
                                    is GotTrackerModuleNameState) {
                              _getTrackerModuleDetail();
                              _listTrackerModulesDetail();
                            } else if (trackerModuleDetailState
                                    is FailedToGetTrackerModuleDetailState &&
                                trackerModulesDetailState
                                    is ListedTrackerModulesDetailState &&
                                trackerModuleNameGetState
                                    is FailedToGetTrackerModuleNameState) {
                              _getTrackerModuleName();
                              _getTrackerModuleDetail();
                            } else if (trackerModuleDetailState
                                    is FailedToGetTrackerModuleDetailState &&
                                trackerModulesDetailState
                                    is ListedTrackerModulesDetailState &&
                                trackerModuleNameGetState
                                    is GotTrackerModuleNameState) {
                              _getTrackerModuleDetail();
                            } else if (trackerModuleDetailState
                                    is GotTrackerModuleDetailState &&
                                trackerModulesDetailState
                                    is FailedToListTrackerModulesDetailState &&
                                trackerModuleNameGetState
                                    is FailedToGetTrackerModuleNameState) {
                              _getTrackerModuleName();
                              _listTrackerModulesDetail();
                            } else if (trackerModuleDetailState
                                    is GotTrackerModuleDetailState &&
                                trackerModulesDetailState
                                    is FailedToListTrackerModulesDetailState &&
                                trackerModuleNameGetState
                                    is GotTrackerModuleNameState) {
                              _listTrackerModulesDetail();
                            } else if (trackerModuleDetailState
                                    is GotTrackerModuleDetailState &&
                                trackerModulesDetailState
                                    is ListedTrackerModulesDetailState &&
                                trackerModuleNameGetState
                                    is FailedToGetTrackerModuleNameState) {
                              _getTrackerModuleName();
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
              ),
              BlocBuilder<TrackerModuleNameGetBloc, TrackerModuleNameGetState>(
                builder: (_, trackerModuleNameGetState) => BlocBuilder<
                    TrackerModuleNameUpdateBloc, TrackerModuleNameUpdateState>(
                  builder: (_, trackerModuleNameUpdateState) =>
                      switch (trackerModuleNameGetState) {
                    GotTrackerModuleNameState(
                      result: final name,
                    )
                        when trackerModuleNameUpdateState
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
                              name: name,
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
