// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/core/utils/extensions/mapbox_convenience_utils.dart';
import 'package:nim_track/features/settings/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/all_tracker_modules_or_one_tracker_module/all_tracker_modules_or_one_tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_name_update_bloc/tracker_module_name_update_bloc.dart';
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
  MapboxMap? _mapboxMap;
  late final List<PointAnnotationManager> _pointAnnotationManagers;
  PolylineAnnotationManager? _polylineAnnotationManager;
  late final ValueNotifier<bool> _showRefreshMessageHeadsUp;

  @override
  void initState() {
    _pointAnnotationManagers = [];
    _showRefreshMessageHeadsUp = ValueNotifier<bool>(
      false,
    );
    context.read<AllTrackerModulesOrOneTrackerModuleBloc>().add(
          const GetAllTrackerModulesEvent(),
        );
    super.initState();
  }

  void _listTrackerModules() => context.read<TrackerModulesBloc>().add(
        ListTrackerModulesEvent(
          fields: _fields,
        ),
      );

  List<enums.Field> get _fields => [
        enums.Field.name,
        enums.Field.batteryLevel,
        enums.Field.latLng,
        enums.Field.timestamp,
      ];

  @override
  void dispose() {
    _mapboxMap?.dispose();
    _showRefreshMessageHeadsUp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<ThemeBloc, ThemeState>(
            listener: (_, themeState) {
              _mapboxMap?.loadStyleURI(
                switch (themeState.themeEntity.fakeBrightness) {
                  enums.Brightness.light => MapboxStyles.MAPBOX_STREETS,
                  enums.Brightness.dark => MapboxStyles.DARK
                },
              );
            },
          ),
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
              if (_pointAnnotationManagers.isNotEmpty) {
                for (final pointAnnotationManager in _pointAnnotationManagers) {
                  await pointAnnotationManager.deleteAll();
                }
                _pointAnnotationManagers.clear();
              }

              if (_polylineAnnotationManager != null) {
                await _polylineAnnotationManager?.deleteAll();
              }

              if (trackerModuleState is GotTrackerModuleState) {
                final trackerModuleDataEntities =
                    trackerModuleState.trackerModuleEntity.data;

                for (var i = nil.toInt();
                    i < trackerModuleDataEntities!.length;
                    i++) {
                  final pointAnnotationManager = await _mapboxMap?.addMarker(
                    lng: trackerModuleDataEntities[i].coordinates!.latLng!.last,
                    lat:
                        trackerModuleDataEntities[i].coordinates!.latLng!.first,
                    imagePath: i ==
                            trackerModuleDataEntities.length -
                                veryTinySpacing.toInt()
                        ? markerGreenImagePath
                        : trailImagePath,
                  );
                  _pointAnnotationManagers.add(
                    pointAnnotationManager!,
                  );
                }

                final lngLats = trackerModuleDataEntities
                    .map(
                      (trackerModuleDataEntity) => [
                        trackerModuleDataEntity.coordinates!.latLng!.last,
                        trackerModuleDataEntity.coordinates!.latLng!.first,
                      ],
                    )
                    .toList();

                _polylineAnnotationManager = await _mapboxMap?.drawPolyline(
                  lngLats: lngLats,
                );

                await _mapboxMap?.easeToBounds(
                  lngLats: lngLats,
                );
              }
            },
          ),
          BlocListener<TrackerModulesBloc, TrackerModulesState>(
            listener: (_, trackerModulesState) async {
              if (_pointAnnotationManagers.isNotEmpty) {
                for (final pointAnnotationManager in _pointAnnotationManagers) {
                  await pointAnnotationManager.deleteAll();
                }
                _pointAnnotationManagers.clear();
              }

              if (_polylineAnnotationManager != null) {
                await _polylineAnnotationManager?.deleteAll();
              }

              if (trackerModulesState is ListedTrackerModulesState &&
                  trackerModulesState.trackerModuleEntities.isNotEmpty) {
                for (final trackerModuleEntity
                    in trackerModulesState.trackerModuleEntities) {
                  final pointAnnotationManager = await _mapboxMap?.addMarker(
                    lng: trackerModuleEntity
                        .data!.last.coordinates!.latLng!.last,
                    lat: trackerModuleEntity
                        .data!.last.coordinates!.latLng!.first,
                    imagePath: markerGreenImagePath,
                  );
                  _pointAnnotationManagers.add(
                    pointAnnotationManager!,
                  );
                }

                await _mapboxMap?.easeToBounds(
                  lngLats: trackerModulesState.trackerModuleEntities
                      .map(
                        (trackerModuleEntity) => [
                          trackerModuleEntity
                              .data!.last.coordinates!.latLng!.last,
                          trackerModuleEntity
                              .data!.last.coordinates!.latLng!.first,
                        ],
                      )
                      .toList(),
                );
              }
            },
          ),
          BlocListener<TrackerModuleNameUpdateBloc,
              TrackerModuleNameUpdateState>(
            listener: (_, trackerModuleNameUpdateState) {
              if (trackerModuleNameUpdateState
                  is UpdatedTrackerModuleNameState) {
                _showRefreshMessageHeadsUp.value = true;
              }
            },
          ),
        ],
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                MapWidget(
                  onMapCreated: (mapboxMap) => _mapboxMap = mapboxMap,
                  cameraOptions: CameraOptions(
                    center: Point(
                      coordinates: Position(
                        defaultLng,
                        defaultLat,
                      ),
                    ).toJson(),
                    zoom: defaultZoom,
                  ),
                  key: const ValueKey(
                    mapboxMapKey,
                  ),
                  resourceOptions: ResourceOptions(
                    accessToken: dotenv.env[mapboxSecretTokenKeyName]!,
                  ),
                  styleUri: switch (context
                      .read<ThemeBloc>()
                      .state
                      .themeEntity
                      .fakeBrightness) {
                    enums.Brightness.light => MapboxStyles.MAPBOX_STREETS,
                    enums.Brightness.dark => MapboxStyles.DARK
                  },
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(
                    spacing,
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      settingsScreenRoute,
                    ),
                    icon: const Icon(
                      Icons.settings,
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _showRefreshMessageHeadsUp,
                  builder: (_, showRefreshMessageHeadsUpValue, __) =>
                      showRefreshMessageHeadsUpValue
                          ? Container(
                              padding: const EdgeInsetsDirectional.all(
                                spacing,
                              ),
                              margin: const EdgeInsetsDirectional.only(
                                start: spacing,
                                end: extraLargeSpacing + spacing,
                                top: spacing,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadiusDirectional.circular(
                                  spacing,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      someDataChangedLiteral,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: spacing,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _listTrackerModules();
                                      _showRefreshMessageHeadsUp.value = false;
                                    },
                                    icon: const Icon(
                                      Icons.refresh,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: smallSpacing,
                                  ),
                                  IconButton(
                                    onPressed: () => _showRefreshMessageHeadsUp
                                        .value = false,
                                    icon: const Icon(
                                      Icons.close,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          bottomSheet: const DashboardSheet(),
        ),
      );
}
