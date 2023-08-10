// ignore_for_file: public_member_api_docs

import 'package:latlong2/latlong.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/core/utils/helpers/time_util.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';

extension TrackerModuleEntityConvenienceUtils on TrackerModuleEntity {
  bool get faulty => true;

  List<enums.Problem> get faults => [
        enums.Problem.noTransmissionWithinlastHour,
        enums.Problem.latestTransmissionBehindOthers,
      ];
}

extension TrackerModuleEntitiesConvenienceUtils on List<TrackerModuleEntity> {
  int get faultyNodesCount {
    var nodesWithLatestTransmissionBehindOthers = nil.toInt();
    var nodesWithNoTransmissionWithinLastHour = nil.toInt();

    if (length > tinySpacing.toInt()) {
      final latestTransmissionDateTime = <DateTime>[];
      var highestLatestDateTime = TimeUtil.computeDateTime(
        first.data.last.timestamp,
      );

      for (var i = nil.toInt(); i < length; i++) {
        final ithLatestDateTime = TimeUtil.computeDateTime(
          this[i].data.last.timestamp,
        );

        if (i > nil.toInt() &&
            ithLatestDateTime.isAfter(
              TimeUtil.computeDateTime(
                this[i - veryTinySpacing.toInt()].data.last.timestamp,
              ),
            )) {
          highestLatestDateTime = ithLatestDateTime;
        }

        latestTransmissionDateTime.add(
          ithLatestDateTime,
        );
      }

      nodesWithLatestTransmissionBehindOthers = latestTransmissionDateTime
          .where(
            (dateTime) => dateTime.isBefore(
              highestLatestDateTime,
            ),
          )
          .toList()
          .length;
    } else {
      final anHourAgo = TimeUtil.currentDateTime.subtract(
        Duration(
          hours: veryTinySpacing.toInt(),
        ),
      );

      for (final trackerModuleEntity in this) {
        final latestTransmissionDate = TimeUtil.computeDateTime(
          trackerModuleEntity.data.last.timestamp,
        );

        if (latestTransmissionDate.isBefore(anHourAgo)) {
          nodesWithNoTransmissionWithinLastHour++;
        }
      }
    }

    return nodesWithLatestTransmissionBehindOthers >
            nodesWithNoTransmissionWithinLastHour
        ? nodesWithLatestTransmissionBehindOthers
        : nodesWithNoTransmissionWithinLastHour;
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
      totalDistanceKilometer.toStringAsFixed(
        tinySpacing.toInt(),
      ),
    );
  }
}
