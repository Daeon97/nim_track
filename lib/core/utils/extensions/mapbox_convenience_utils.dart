// ignore_for_file: public_member_api_docs

import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';

extension MapboxConvenienceUtils on MapboxMap {
  Future<PointAnnotationManager> addMarker({
    required num lng,
    required num lat,
    required String imagePath,
  }) async {
    final pointAnnotationManager =
        await annotations.createPointAnnotationManager();
    await pointAnnotationManager.create(
      PointAnnotationOptions(
        geometry: Point(
          coordinates: Position(
            lng,
            lat,
          ),
        ).toJson(),
        image: (await rootBundle.load(
          imagePath,
        ))
            .buffer
            .asUint8List(),
      ),
    );

    return pointAnnotationManager;
  }

  Future<PolylineAnnotationManager> drawPolyline({
    required List<List<num>> lngLats,
  }) async {
    final polylineAnnotationManager =
        await annotations.createPolylineAnnotationManager();
    await polylineAnnotationManager.create(
      PolylineAnnotationOptions(
        geometry: MultiPoint(
          coordinates: lngLats
              .map(
                (lngLat) => Position(
                  lngLat.first,
                  lngLat.last,
                ),
              )
              .toList(),
        ).toJson(),
        lineColor: nodeAvailableColor.value,
        lineJoin: LineJoin.ROUND,
        lineWidth: veryTinySpacing + tinySpacing,
      ),
    );

    return polylineAnnotationManager;
  }

  Future<PolygonAnnotationManager> drawPolygon({
    required List<List<num>> lngLats,
    required Color fillColor,
  }) async {
    final polygonAnnotationManager =
        await annotations.createPolygonAnnotationManager();
    await polygonAnnotationManager.create(
      PolygonAnnotationOptions(
        geometry: Polygon(
          coordinates: [
            lngLats
                .map(
                  (lngLat) => Position(
                    lngLat.first,
                    lngLat.last,
                  ),
                )
                .toList(),
          ],
        ).toJson(),
        fillOutlineColor: fillColor.value,
        fillColor: fillColor.value,
      ),
    );

    return polygonAnnotationManager;
  }

  double calculateTotalDistanceKilometer({
    required List<List<num>> lngLats,
  }) {
    var totalDistanceKilometer = nil;
    var previousLatLng = const LatLng(nil, nil);

    for (var i = nil.toInt(); i < lngLats.length; i++) {
      if (i % tinySpacing.toInt() == nil.toInt()) {
        final distanceKilometer = const Distance(
          roundResult: false,
        ).as(
          LengthUnit.Kilometer,
          previousLatLng,
          LatLng(
            lngLats[i].last.toDouble(),
            lngLats[i].first.toDouble(),
          ),
        );
        totalDistanceKilometer += distanceKilometer;
        if (i != lngLats.length - veryTinySpacing.toInt()) {
          previousLatLng = LatLng(
            lngLats[i].last.toDouble(),
            lngLats[i].first.toDouble(),
          );
        }
      } else {
        if (i == lngLats.length - veryTinySpacing.toInt()) {
          final distanceKilometer = const Distance(
            roundResult: false,
          ).as(
            LengthUnit.Kilometer,
            previousLatLng,
            LatLng(
              lngLats[i].last.toDouble(),
              lngLats[i].first.toDouble(),
            ),
          );
          totalDistanceKilometer += distanceKilometer;
        } else {
          previousLatLng = LatLng(
            lngLats[i].last.toDouble(),
            lngLats[i].first.toDouble(),
          );
        }
      }
    }

    return totalDistanceKilometer;
  }
}
