// ignore_for_file: public_member_api_docs

import 'package:latlong2/latlong.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';

extension TrackerModuleEntitiesConvenienceUtils on List<TrackerModuleEntity> {
  int get faultyNodes {
    return 3;
  }
}

extension TrackerModuleDataEntitiesConvenienceUtils
    on List<TrackerModuleDataEntity> {
  double get totalDistanceKilometer {
    final latLngs = map(
      (trackerModuleDataEntity) => [
        trackerModuleDataEntity.coordinates.latLng.first,
        trackerModuleDataEntity.coordinates.latLng.last,
      ],
    ).toList();

    var totalDistanceKilometer = nil;

    for (var i = nil.toInt();
        i < latLngs.length - veryTinySpacing.toInt();
        i++) {
      totalDistanceKilometer += const Distance(
        roundResult: false,
      ).as(
        LengthUnit.Kilometer,
        LatLng(
          latLngs[i].first.toDouble(),
          latLngs[i].last.toDouble(),
        ),
        LatLng(
          latLngs[i + veryTinySpacing.toInt()].first.toDouble(),
          latLngs[i + veryTinySpacing.toInt()].first.toDouble(),
        ),
      );
    }

    return double.parse(
      totalDistanceKilometer.toStringAsFixed(tinySpacing.toInt()),
    );
  }
}
