// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';

@JsonSerializable()
class TrackerModuleModel extends TrackerModuleEntity {
  TrackerModuleModel({
    required super.nodeId,
    required super.coordinates,
    required super.batteryLevel,
    required super.timestamp,
  });

  // factory TrackerModuleModel.fromJson(Map<String, dynamic> json) =>
  //     _$TrackerModuleModelFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$TrackerModuleModelToJson(this);
}
