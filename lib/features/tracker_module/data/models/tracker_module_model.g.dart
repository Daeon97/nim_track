// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracker_module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackerModuleModel _$TrackerModuleModelFromJson(Map<String, dynamic> json) =>
    TrackerModuleModel(
      id: json['id'] as int,
      mData: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => TrackerModuleDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TrackerModuleModelToJson(TrackerModuleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'data': instance.mData,
    };

TrackerModuleDataModel _$TrackerModuleDataModelFromJson(
        Map<String, dynamic> json) =>
    TrackerModuleDataModel(
      mBatteryLevel: json['battery_level'] as int?,
      mCoordinates: json['coordinates'] == null
          ? null
          : TrackerModuleCoordinatesModel.fromJson(
              json['coordinates'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$TrackerModuleDataModelToJson(
        TrackerModuleDataModel instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'battery_level': instance.mBatteryLevel,
      'coordinates': instance.mCoordinates,
    };

TrackerModuleCoordinatesModel _$TrackerModuleCoordinatesModelFromJson(
        Map<String, dynamic> json) =>
    TrackerModuleCoordinatesModel(
      mGeohash: json['hash'] as String?,
      mLatLng:
          (json['lat_lng'] as List<dynamic>?)?.map((e) => e as num).toList(),
    );

Map<String, dynamic> _$TrackerModuleCoordinatesModelToJson(
        TrackerModuleCoordinatesModel instance) =>
    <String, dynamic>{
      'hash': instance.mGeohash,
      'lat_lng': instance.mLatLng,
    };
