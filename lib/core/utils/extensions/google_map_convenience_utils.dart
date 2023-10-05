// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nim_track/core/resources/numbers.dart';
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

  Set<Marker> showTrackerModuleDataEntitiesOnMap({
    required List<TrackerModuleDataEntity> trackerModuleDataEntities,
  }) {
    final markers = <Marker>{};

    if (trackerModuleDataEntities.isEmpty) {
      return markers;
    }

    for (final trackerModuleDataEntity in trackerModuleDataEntities) {
      markers.add(
        Marker(
          markerId: MarkerId(
            trackerModuleDataEntity.coordinates!.geohash!,
          ),
          position: LatLng(
            trackerModuleDataEntity.coordinates!.latLng!.first.toDouble(),
            trackerModuleDataEntity.coordinates!.latLng!.last.toDouble(),
          ),
        ),
      );
    }

    return markers;
  }

  Set<Polyline> trackTrackerModuleDataEntitiesOnMap({
    required List<TrackerModuleDataEntity> trackerModuleDataEntities,
    required Color color,
  }) {
    final polylines = <Polyline>{};

    if (trackerModuleDataEntities.isEmpty) {
      return polylines;
    }

    for (var i = nil.toInt(); i < trackerModuleDataEntities.length; i++) {
      polylines.add(
        Polyline(
          polylineId: PolylineId(
            trackerModuleDataEntities[i].coordinates!.geohash!,
          ),
          jointType: JointType.round,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          width: veryTinySpacing.toInt() + veryTinySpacing.toInt(),
          color: color,
          points: [
            LatLng(
              trackerModuleDataEntities[i]
                  .coordinates!
                  .latLng!
                  .first
                  .toDouble(),
              trackerModuleDataEntities[i].coordinates!.latLng!.last.toDouble(),
            ),
            if (i != trackerModuleDataEntities.length - veryTinySpacing.toInt())
              LatLng(
                trackerModuleDataEntities[i + veryTinySpacing.toInt()]
                    .coordinates!
                    .latLng!
                    .first
                    .toDouble(),
                trackerModuleDataEntities[i + veryTinySpacing.toInt()]
                    .coordinates!
                    .latLng!
                    .last
                    .toDouble(),
              ),
          ],
        ),
      );
    }

    return polylines;
  }

  Set<Polygon> plotTrackerModuleDataEntitiesOnMap({
    required List<TrackerModuleDataEntity> trackerModuleDataEntities,
    required Color color,
  }) {
    final polygons = <Polygon>{};

    if (trackerModuleDataEntities.isEmpty) {
      return polygons;
    }

    for (var i = nil.toInt(); i < trackerModuleDataEntities.length; i++) {
      polygons.add(
        Polygon(
          polygonId: PolygonId(
            trackerModuleDataEntities[i].coordinates!.geohash!,
          ),
          strokeWidth: veryTinySpacing.toInt() + veryTinySpacing.toInt(),
          fillColor: color,
          points: [
            LatLng(
              trackerModuleDataEntities[i]
                  .coordinates!
                  .latLng!
                  .first
                  .toDouble(),
              trackerModuleDataEntities[i].coordinates!.latLng!.last.toDouble(),
            ),
            if (i != trackerModuleDataEntities.length - veryTinySpacing.toInt())
              LatLng(
                trackerModuleDataEntities[i + veryTinySpacing.toInt()]
                    .coordinates!
                    .latLng!
                    .first
                    .toDouble(),
                trackerModuleDataEntities[i + veryTinySpacing.toInt()]
                    .coordinates!
                    .latLng!
                    .last
                    .toDouble(),
              ),
          ],
        ),
      );
    }

    return polygons;
  }

  Future<void> animateToTrackerModuleEntitiesBoundingBox({
    required List<TrackerModuleEntity> trackerModuleEntities,
  }) async {
    if (trackerModuleEntities.isEmpty) {
      return;
    }

    await animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBoundsConvenienceUtils.fromLatLngList(
          trackerModuleEntities
              .map(
                (trackerModuleEntity) => LatLng(
                  trackerModuleEntity.data!.last.coordinates!.latLng!.first
                      .toDouble(),
                  trackerModuleEntity.data!.last.coordinates!.latLng!.last
                      .toDouble(),
                ),
              )
              .toList(),
        ),
        veryLargeSpacing,
      ),
    );
  }

  Future<void> animateToTrackerModuleDataEntitiesBoundingBox({
    required List<TrackerModuleDataEntity> trackerModuleDataEntities,
    double? padding,
  }) async {
    if (trackerModuleDataEntities.isEmpty) {
      return;
    }

    await animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBoundsConvenienceUtils.fromLatLngList(
          trackerModuleDataEntities
              .map(
                (trackerModuleDataEntity) => LatLng(
                  trackerModuleDataEntity.coordinates!.latLng!.first.toDouble(),
                  trackerModuleDataEntity.coordinates!.latLng!.last.toDouble(),
                ),
              )
              .toList(),
        ),
        padding ?? veryLargeSpacing,
      ),
    );
  }
}

extension LatLngBoundsConvenienceUtils on LatLngBounds {
  static LatLngBounds fromLatLngList(
    List<LatLng> latLngList,
  ) {
    double? x0;
    late double x1;
    late double y0;
    late double y1;

    for (final latLng in latLngList) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(
        x1,
        y1,
      ),
      southwest: LatLng(
        x0!,
        y0,
      ),
    );
  }
}
