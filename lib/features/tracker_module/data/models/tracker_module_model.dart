// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';

part 'tracker_module_model.g.dart';

@JsonSerializable()
final class TrackerModuleModel extends TrackerModuleEntity {
  TrackerModuleModel({
    required super.id,
    this.mData,
    super.name,
  }) : super(
          data: mData,
        );

  factory TrackerModuleModel.fromJson(Map<String, dynamic> json) =>
      _$TrackerModuleModelFromJson(json);

  @JsonKey(name: dataJsonKey)
  final List<TrackerModuleDataModel>? mData;

  Map<String, dynamic> toJson() => _$TrackerModuleModelToJson(this);
}

@JsonSerializable()
final class TrackerModuleDataModel extends TrackerModuleDataEntity {
  const TrackerModuleDataModel({
    required this.mBatteryLevel,
    required this.mCoordinates,
    required super.timestamp,
  }) : super(
          batteryLevel: mBatteryLevel,
          coordinates: mCoordinates,
        );

  factory TrackerModuleDataModel.fromJson(Map<String, dynamic> json) =>
      _$TrackerModuleDataModelFromJson(json);

  @JsonKey(name: batteryLevelJsonKey)
  final int? mBatteryLevel;

  @JsonKey(name: coordinatesJsonKey)
  final TrackerModuleCoordinatesModel? mCoordinates;

  Map<String, dynamic> toJson() => _$TrackerModuleDataModelToJson(this);
}

@JsonSerializable()
final class TrackerModuleCoordinatesModel
    extends TrackerModuleCoordinatesEntity {
  const TrackerModuleCoordinatesModel({
    required this.mGeohash,
    required this.mLatLng,
  }) : super(
          geohash: mGeohash,
          latLng: mLatLng,
        );

  factory TrackerModuleCoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$TrackerModuleCoordinatesModelFromJson(json);

  @JsonKey(name: geohashJsonKey)
  final String? mGeohash;

  @JsonKey(name: latLngJsonKey)
  final List<num>? mLatLng;

  Map<String, dynamic> toJson() => _$TrackerModuleCoordinatesModelToJson(this);
}
