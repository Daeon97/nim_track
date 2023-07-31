// ignore_for_file: public_member_api_docs

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/strings.dart';

extension Marker on MapboxMap {
  Future<PointAnnotation> addMarker({
    required num lng,
    required num lat,
  }) async =>
      (await annotations.createPointAnnotationManager()).create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              lng,
              lat,
            ),
          ).toJson(),
          image: (await rootBundle.load(
            markerGreenImagePath,
          ))
              .buffer
              .asUint8List(),
          // textField: 'jgsdfjgssgd',
          // textColor: nodeAvailableColor.value,
          // iconColor: Colors.red.value,
        ),
      );

  // Future<PointAnnotationOptions> _getAnnotation({
  //   required num lng,
  //   required num lat,
  // }) async =>
  //     PointAnnotationOptions(
  //       geometry: Point(
  //         coordinates: Position(
  //           lng,
  //           lat,
  //         ),
  //       ).toJson(),
  //       image: (await rootBundle.load(
  //         markerYellowImagePath,
  //       ))
  //           .buffer
  //           .asUint8List(),
  //       // iconColor: Colors.red.value,
  //     );
}
