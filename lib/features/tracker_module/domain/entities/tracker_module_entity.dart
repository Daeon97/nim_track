// ignore_for_file: public_member_api_docs

base class TrackerModuleEntity {
  const TrackerModuleEntity({
    required this.id,
    required this.data,
    this.name,
  });

  final String id;
  final List<TrackerModuleDataEntity> data;
  final String? name;
}

base class TrackerModuleDataEntity {
  const TrackerModuleDataEntity({
    required this.batteryLevel,
    required this.coordinates,
    required this.timestamp,
  });

  final int batteryLevel;
  final TrackerModuleCoordinatesEntity coordinates;
  final int timestamp;
}

base class TrackerModuleCoordinatesEntity {
  const TrackerModuleCoordinatesEntity({
    required this.geohash,
    required this.latLng,
  });

  final String geohash;
  final List<num> latLng;
}
