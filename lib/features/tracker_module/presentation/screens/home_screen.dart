// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/core/utils/extensions/google_map_convenience_utils.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/all_tracker_modules_or_one_tracker_module/all_tracker_modules_or_one_tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/home_screen_widgets/dashboard_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _googleMapController;

  @override
  void initState() {
    context.read<AllTrackerModulesOrOneTrackerModuleBloc>().add(
          const GetAllTrackerModulesEvent(),
        );
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  void _listTrackerModules() => context.read<TrackerModulesBloc>().add(
        ListTrackerModulesEvent(
          fields: _fields,
        ),
      );

  List<enums.Field> get _fields => [
        enums.Field.name,
        enums.Field.batteryLevel,
        enums.Field.hash,
        enums.Field.latLng,
        enums.Field.timestamp,
      ];

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<AllTrackerModulesOrOneTrackerModuleBloc,
              AllTrackerModulesOrOneTrackerModuleState>(
            listener: (
              _,
              allTrackerModulesOrOneTrackerModuleState,
            ) {
              if (allTrackerModulesOrOneTrackerModuleState
                  is AllTrackerModulesState) {
                _listTrackerModules();
              } else if (allTrackerModulesOrOneTrackerModuleState
                  is OneTrackerModuleState) {
                context.read<TrackerModuleBloc>().add(
                      GetTrackerModuleEvent(
                        id: allTrackerModulesOrOneTrackerModuleState.id,
                        fields: _fields,
                      ),
                    );
              }
            },
          ),
          BlocListener<TrackerModuleBloc, TrackerModuleState>(
            listener: (_, trackerModuleState) async {
              if (trackerModuleState is GotTrackerModuleState &&
                  trackerModuleState.trackerModuleEntity.data!.isNotEmpty) {
                await _googleMapController
                    ?.animateToTrackerModuleDataEntitiesBoundingBox(
                  trackerModuleDataEntities:
                      trackerModuleState.trackerModuleEntity.data!,
                );
              }
            },
          ),
          BlocListener<TrackerModulesBloc, TrackerModulesState>(
            listener: (_, trackerModulesState) async {
              if (trackerModulesState is ListedTrackerModulesState &&
                  trackerModulesState.trackerModuleEntities.isNotEmpty) {
                await _googleMapController
                    ?.animateToTrackerModuleEntitiesBoundingBox(
                  trackerModuleEntities:
                      trackerModulesState.trackerModuleEntities,
                );
              }
            },
          ),
        ],
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                BlocBuilder<AllTrackerModulesOrOneTrackerModuleBloc,
                    AllTrackerModulesOrOneTrackerModuleState>(
                  builder: (_, allTrackerModulesOrOneTrackerModuleState) =>
                      BlocBuilder<TrackerModulesBloc, TrackerModulesState>(
                    builder: (_, trackerModulesState) =>
                        BlocBuilder<TrackerModuleBloc, TrackerModuleState>(
                      builder: (_, trackerModuleState) => GoogleMap(
                        mapType: MapType.hybrid,
                        zoomControlsEnabled: false,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(
                            defaultLat,
                            defaultLng,
                          ),
                          zoom: defaultZoom,
                        ),
                        onMapCreated: (googleMapController) =>
                            _googleMapController = googleMapController,
                        markers: allTrackerModulesOrOneTrackerModuleState
                                    is AllTrackerModulesState &&
                                trackerModulesState is ListedTrackerModulesState
                            ? _googleMapController
                                    ?.showTrackerModuleEntitiesOnMap(
                                  trackerModuleEntities:
                                      trackerModulesState.trackerModuleEntities,
                                ) ??
                                const <Marker>{}
                            : allTrackerModulesOrOneTrackerModuleState
                                        is OneTrackerModuleState &&
                                    trackerModuleState is GotTrackerModuleState
                                ? _googleMapController
                                        ?.showTrackerModuleDataEntitiesOnMap(
                                      trackerModuleDataEntities:
                                          trackerModuleState
                                              .trackerModuleEntity.data!,
                                    ) ??
                                    const <Marker>{}
                                : const <Marker>{},
                        polylines: allTrackerModulesOrOneTrackerModuleState
                                    is OneTrackerModuleState &&
                                trackerModuleState is GotTrackerModuleState
                            ? _googleMapController
                                    ?.trackTrackerModuleDataEntitiesOnMap(
                                  trackerModuleDataEntities: trackerModuleState
                                      .trackerModuleEntity.data!,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ) ??
                                const <Polyline>{}
                            : const <Polyline>{},
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.all(
                    spacing,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadiusDirectional.circular(
                      spacing,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: _listTrackerModules,
                        icon: const Icon(
                          Icons.refresh,
                        ),
                      ),
                      const SizedBox(
                        width: smallSpacing,
                      ),
                      BlocBuilder<AllTrackerModulesOrOneTrackerModuleBloc,
                          AllTrackerModulesOrOneTrackerModuleState>(
                        builder:
                            (_, allTrackerModulesOrOneTrackerModuleState) =>
                                BlocBuilder<TrackerModulesBloc,
                                    TrackerModulesState>(
                          builder: (_, trackerModulesState) => BlocBuilder<
                              TrackerModuleBloc, TrackerModuleState>(
                            builder: (_, trackerModuleState) => IconButton(
                              onPressed:
                                  allTrackerModulesOrOneTrackerModuleState
                                              is AllTrackerModulesState &&
                                          trackerModulesState
                                              is ListedTrackerModulesState
                                      ? () async {
                                          await _googleMapController
                                              ?.animateToTrackerModuleEntitiesBoundingBox(
                                            trackerModuleEntities:
                                                trackerModulesState
                                                    .trackerModuleEntities,
                                          );
                                        }
                                      : allTrackerModulesOrOneTrackerModuleState
                                                  is OneTrackerModuleState &&
                                              trackerModuleState
                                                  is GotTrackerModuleState
                                          ? () async {
                                              await _googleMapController
                                                  ?.animateToTrackerModuleDataEntitiesBoundingBox(
                                                trackerModuleDataEntities:
                                                    trackerModuleState
                                                        .trackerModuleEntity
                                                        .data!,
                                              );
                                            }
                                          : null,
                              icon: const Icon(
                                Icons.gps_fixed,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: smallSpacing,
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                          settingsScreenRoute,
                        ),
                        icon: const Icon(
                          Icons.settings,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: const DashboardSheet(),
        ),
      );
}
