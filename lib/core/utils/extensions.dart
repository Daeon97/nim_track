// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';

extension Marker on MapboxMap {
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
        // textField: 'jgsdfjgssgd',
        // textColor: nodeAvailableColor.value,
        // iconColor: Colors.red.value,
      ),
    );

    return pointAnnotationManager;
  }
}
