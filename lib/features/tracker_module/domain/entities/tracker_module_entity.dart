// ignore_for_file: public_member_api_docs

class TrackerModuleEntity {
  const TrackerModuleEntity({
    required this.nodeId,
    required this.coordinates,
    required this.batteryLevel,
    required this.timestamp,
    this.nodeName,
  });

  final String nodeId;
  final Coordinates coordinates;
  final num batteryLevel;
  final int timestamp;
  final String? nodeName;
}

class Coordinates {
  const Coordinates({
    required this.geohash,
    required this.latLng,
  });

  final String geohash;
  final List<num> latLng;
}
