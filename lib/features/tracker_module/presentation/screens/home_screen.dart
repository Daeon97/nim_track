// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/core/utils/extensions.dart';
import 'package:nim_track/features/settings/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/all_tracker_modules_or_one_tracker_module/all_tracker_modules_or_one_tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/dashboard_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMap? _mapboxMapController;

  @override
  void initState() {
    BlocProvider.of<AllTrackerModulesOrOneTrackerModuleBloc>(
      context,
    ).add(
      const GetAllTrackerModulesEvent(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _mapboxMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ThemeBloc, ThemeState>(
        listener: (_, themeState) {
          _mapboxMapController?.loadStyleURI(
            switch (themeState.themeEntity.fakeBrightness) {
              enums.Brightness.light => MapboxStyles.MAPBOX_STREETS,
              enums.Brightness.dark => MapboxStyles.DARK
            },
          );
        },
        child: BlocListener<AllTrackerModulesOrOneTrackerModuleBloc,
            AllTrackerModulesOrOneTrackerModuleState>(
          listener: (
            _,
            allTrackerModulesOrOneTrackerModuleState,
          ) {
            if (allTrackerModulesOrOneTrackerModuleState
                is AllTrackerModulesState) {
              context.read<TrackerModulesBloc>().add(
                    const ListTrackerModulesEvent(),
                  );
            } else if (allTrackerModulesOrOneTrackerModuleState
                is OneTrackerModuleState) {
              context.read<TrackerModuleBloc>().add(
                    GetTrackerModuleEvent(
                      id: allTrackerModulesOrOneTrackerModuleState.id,
                    ),
                  );
            }
          },
          child: BlocListener<TrackerModuleBloc, TrackerModuleState>(
            listener: (_, trackerModuleState) async {
              if (trackerModuleState is GotTrackerModuleState) {
                final trackerModuleDataEntities =
                    trackerModuleState.trackerModuleEntity.data;

                for (var i = nil.toInt();
                    i < trackerModuleDataEntities.length;
                    i++) {
                  await _mapboxMapController?.addMarker(
                    lng: trackerModuleDataEntities[i].coordinates.latLng.last,
                    lat: trackerModuleDataEntities[i].coordinates.latLng.first,
                    imagePath: i ==
                            trackerModuleDataEntities.length -
                                veryTinySpacing.toInt()
                        ? markerGreenImagePath
                        : trailImagePath,
                  );
                }
              }
            },
            child: BlocListener<TrackerModulesBloc, TrackerModulesState>(
              listener: (_, trackerModulesState) async {
                // if (trackerModulesState is ListedTrackerModulesState) {
                //   for (final trackerModuleEntity
                //       in trackerModulesState.trackerModuleEntities) {
                //     await _mapboxMapController?.addMarker(
                //       lng:
                //           trackerModuleEntity.data.last.coordinates.latLng.last,
                //       lat: trackerModuleEntity
                //           .data.last.coordinates.latLng.first,
                //       imagePath: markerGreenImagePath,
                //     );
                //   }
                // }
              },
              child: Scaffold(
                body: SafeArea(
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      MapWidget(
                        onMapCreated: (mapboxMap) =>
                            _mapboxMapController = mapboxMap,
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
                        styleUri: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .themeEntity
                                    .fakeBrightness ==
                                enums.Brightness.light
                            ? MapboxStyles.MAPBOX_STREETS
                            : MapboxStyles.DARK,
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
                    ],
                  ),
                ),
                bottomSheet: const DashboardSheet(),
              ),
            ),
          ),
        ),
      );
}
