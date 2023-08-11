// ignore_for_file: public_member_api_docs

base class TrackerModuleEntity {
  const TrackerModuleEntity({
    required this.id,
    this.data,
    this.name,
  });

  final int id;
  final List<TrackerModuleDataEntity>? data;
  final String? name;
}

base class TrackerModuleDataEntity {
  const TrackerModuleDataEntity({
    this.batteryLevel,
    this.coordinates,
    this.timestamp,
  });

  final int? batteryLevel;
  final TrackerModuleCoordinatesEntity? coordinates;
  final int? timestamp;
}

base class TrackerModuleCoordinatesEntity {
  const TrackerModuleCoordinatesEntity({
    this.geohash,
    this.latLng,
  });

  final String? geohash;
  final List<num>? latLng;
}
