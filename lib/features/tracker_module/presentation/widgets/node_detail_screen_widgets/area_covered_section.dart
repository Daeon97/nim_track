// ignore_for_file: public_member_api_docs, must_be_immutable, lines_longer_than_80_chars, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/core/utils/extensions/mapbox_convenience_utils.dart';
import 'package:nim_track/features/settings/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';

class AreaCoveredSection extends StatelessWidget {
  AreaCoveredSection({super.key});

  MapboxMap? _mapboxMap;
  PolygonAnnotationManager? _polygonAnnotationManager;

  @override
  Widget build(BuildContext context) =>
      BlocListener<TrackerModuleDetailBloc, TrackerModuleDetailState>(
        listener: (_, trackerModuleDetailState) async {
          if (_polygonAnnotationManager != null) {
            await _polygonAnnotationManager?.deleteAll();
          }

          if (trackerModuleDetailState is GotTrackerModuleDetailState &&
              trackerModuleDetailState.trackerModuleEntity.data!.length >
                  veryTinySpacing.toInt()) {
            final trackerModuleDataEntities =
                trackerModuleDetailState.trackerModuleEntity.data!;
            _polygonAnnotationManager = await _mapboxMap?.drawPolygon(
              lngLats: trackerModuleDataEntities
                  .map(
                    (trackerModuleDataEntity) => [
                      trackerModuleDataEntity.coordinates!.latLng!.last,
                      trackerModuleDataEntity.coordinates!.latLng!.first,
                    ],
                  )
                  .toList(),
              fillColor: Theme.of(context).colorScheme.inversePrimary,
            );

            await _mapboxMap?.easeToBounds(
              lngLats: trackerModuleDetailState.trackerModuleEntity.data!
                  .map(
                    (trackerModuleDataEntity) => [
                      trackerModuleDataEntity.coordinates!.latLng!.last,
                      trackerModuleDataEntity.coordinates!.latLng!.first,
                    ],
                  )
                  .toList(),
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
                height: spacing,
              ),
              SizedBox(
                height: areaCoveredSectionMapHeight,
                child: Stack(
                  alignment: AlignmentDirectional.center,
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
                      styleUri: BlocProvider.of<ThemeBloc>(context)
                                  .state
                                  .themeEntity
                                  .fakeBrightness ==
                              enums.Brightness.light
                          ? MapboxStyles.MAPBOX_STREETS
                          : MapboxStyles.DARK,
                    ),
                    BlocBuilder<TrackerModuleDetailBloc,
                        TrackerModuleDetailState>(
                      builder: (_, trackerModuleDetailState) =>
                          switch (trackerModuleDetailState) {
                        GettingTrackerModuleDetailState() =>
                          const CircularProgressIndicator(),
                        GotTrackerModuleDetailState(
                          trackerModuleEntity: final entity,
                        )
                            when entity.data!.length > veryTinySpacing.toInt() =>
                          const SizedBox.shrink(),
                        GotTrackerModuleDetailState(
                          trackerModuleEntity: final entity,
                        )
                            when entity.data!.length <=
                                veryTinySpacing.toInt() =>
                          const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.warning,
                                  size: largeSpacing + spacing,
                                ),
                                SizedBox(
                                  height: smallSpacing,
                                ),
                                Text(
                                  notEnoughDataLiteral,
                                ),
                              ],
                            ),
                          ),
                        _ => const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error,
                                  size: largeSpacing + spacing,
                                ),
                                SizedBox(
                                  height: smallSpacing,
                                ),
                                Text(
                                  errorDisplayingDataLiteral,
                                ),
                              ],
                            ),
                          ),
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
