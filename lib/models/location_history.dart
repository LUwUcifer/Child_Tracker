class LocationHistory {
  final String id;
  final String childId;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final bool isInSafeZone;
  final String? safeZoneName;
  final double? distanceFromZone;

  LocationHistory({
    required this.id,
    required this.childId,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.isInSafeZone,
    this.safeZoneName,
    this.distanceFromZone,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'childId': childId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'isInSafeZone': isInSafeZone,
      'safeZoneName': safeZoneName,
      'distanceFromZone': distanceFromZone,
    };
  }

  factory LocationHistory.fromJson(Map<String, dynamic> json) {
    return LocationHistory(
      id: json['id'],
      childId: json['childId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      timestamp: DateTime.parse(json['timestamp']),
      isInSafeZone: json['isInSafeZone'],
      safeZoneName: json['safeZoneName'],
      distanceFromZone: json['distanceFromZone'],
    );
  }
}
