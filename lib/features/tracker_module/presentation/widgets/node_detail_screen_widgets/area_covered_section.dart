// ignore_for_file: public_member_api_docs, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/core/utils/extensions/mapbox_convenience_utils.dart';
import 'package:nim_track/features/settings/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';

class AreaCoveredSection extends StatefulWidget {
  const AreaCoveredSection({super.key});

  @override
  State<AreaCoveredSection> createState() => _AreaCoveredSectionState();
}

class _AreaCoveredSectionState extends State<AreaCoveredSection> {
  MapboxMap? _mapboxMap;
  PolygonAnnotationManager? _polygonAnnotationManager;

  // @override
  // void dispose() {
  //   _mapboxMap?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) =>
      BlocListener<TrackerModuleBloc, TrackerModuleState>(
        listener: (_, trackerModuleState) async {
          if (_polygonAnnotationManager != null) {
            await _polygonAnnotationManager?.deleteAll();
          }

          if (trackerModuleState is GotTrackerModuleState) {
            final trackerModuleDataEntities =
                trackerModuleState.trackerModuleEntity.data;
            _polygonAnnotationManager = await _mapboxMap?.drawPolygon(
              lngLats: trackerModuleDataEntities
                  .map(
                    (trackerModuleDataEntity) => [
                      trackerModuleDataEntity.coordinates.latLng.last,
                      trackerModuleDataEntity.coordinates.latLng.first,
                    ],
                  )
                  .toList(),
              fillColor: Theme.of(context).colorScheme.inversePrimary,
            );
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsetsDirectional.all(
            spacing,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
            ),
            borderRadius: BorderRadius.circular(
              spacing,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsetsDirectional.all(
                      smallSpacing,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.line_axis,
                    ),
                  ),
                  const SizedBox(
                    width: spacing,
                  ),
                  Expanded(
                    child: Text(
                      areaCoveredLiteral,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: largeSpacing,
              ),
              SizedBox(
                height: areaCoveredSectionMapHeight,
                child: MapWidget(
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
                  styleUri: BlocProvider.of<ThemeBloc>(context)
                              .state
                              .themeEntity
                              .fakeBrightness ==
                          enums.Brightness.light
                      ? MapboxStyles.MAPBOX_STREETS
                      : MapboxStyles.DARK,
                ),
              ),
            ],
          ),
        ),
      );
}
