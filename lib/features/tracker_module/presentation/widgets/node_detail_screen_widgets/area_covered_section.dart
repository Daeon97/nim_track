// ignore_for_file: public_member_api_docs, must_be_immutable, lines_longer_than_80_chars, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/extensions/google_map_convenience_utils.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';

class AreaCoveredSection extends StatefulWidget {
  const AreaCoveredSection({super.key});

  @override
  State<AreaCoveredSection> createState() => _AreaCoveredSectionState();
}

class _AreaCoveredSectionState extends State<AreaCoveredSection> {
  GoogleMapController? _googleMapController;

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<TrackerModuleDetailBloc, TrackerModuleDetailState>(
        listener: (_, trackerModuleDetailState) async {
          if (trackerModuleDetailState is GotTrackerModuleDetailState) {
            await _googleMapController
                ?.animateToTrackerModuleDataEntitiesBoundingBox(
              trackerModuleDataEntities:
                  trackerModuleDetailState.trackerModuleEntity.data!,
              padding: largeSpacing + spacing,
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
                    BlocBuilder<TrackerModuleDetailBloc,
                        TrackerModuleDetailState>(
                      builder: (_, trackerModuleDetailState) => GoogleMap(
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
                        polygons: trackerModuleDetailState
                                is GotTrackerModuleDetailState
                            ? _googleMapController
                                    ?.plotTrackerModuleDataEntitiesOnMap(
                                  trackerModuleDataEntities:
                                      trackerModuleDetailState
                                          .trackerModuleEntity.data!,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ) ??
                                const <Polygon>{}
                            : const <Polygon>{},
                      ),
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
                            when entity.data!.length >
                                veryTinySpacing.toInt() =>
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
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Padding(
                        padding: const EdgeInsets.all(
                          smallSpacing,
                        ),
                        child: BlocBuilder<TrackerModuleDetailBloc,
                            TrackerModuleDetailState>(
                          builder: (_, trackerModuleDetailState) => IconButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            onPressed: trackerModuleDetailState
                                    is GotTrackerModuleDetailState
                                ? () async {
                                    await _googleMapController
                                        ?.animateToTrackerModuleDataEntitiesBoundingBox(
                                      trackerModuleDataEntities:
                                          trackerModuleDetailState
                                              .trackerModuleEntity.data!,
                                      padding: largeSpacing + spacing,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
