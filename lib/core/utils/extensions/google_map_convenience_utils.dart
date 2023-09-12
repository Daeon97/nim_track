// ignore_for_file: public_member_api_docs

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';

extension GoogleMapConvenienceUtils on GoogleMapController {
  Set<Marker> showTrackerModuleEntitiesOnMap({
    required List<TrackerModuleEntity> trackerModuleEntities,
  }) {
    final markers = <Marker>{};

    if (trackerModuleEntities.isEmpty) {
      return markers;
    }

    for (final trackerModuleEntity in trackerModuleEntities) {
      markers.add(
        Marker(
          markerId: MarkerId(
            trackerModuleEntity.data!.last.coordinates!.geohash!,
          ),
          position: LatLng(
            trackerModuleEntity.data!.last.coordinates!.latLng!.first
                .toDouble(),
            trackerModuleEntity.data!.last.coordinates!.latLng!.last.toDouble(),
          ),
        ),
      );
    }

    return markers;
  }

  Future<void> animateToTrackerModuleEntitiesBoundingBox({
    required List<TrackerModuleEntity> trackerModuleEntities,
  }) async {
    if (trackerModuleEntities.isEmpty) {
      return;
    }
  }
}
