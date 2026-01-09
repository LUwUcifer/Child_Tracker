class Child {
  final String id;
  final String name;
  final int age;
  final String status;
  final double latitude;
  final double longitude;
  final String? imageUrl;
  final DateTime lastUpdated;

  Child({
    required this.id,
    required this.name,
    required this.age,
    required this.status,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
    required this.lastUpdated,
  });

  Child copyWith({
    String? id,
    String? name,
    int? age,
    String? status,
    double? latitude,
    double? longitude,
    String? imageUrl,
    DateTime? lastUpdated,
  }) {
    return Child(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      status: json['status'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      imageUrl: json['imageUrl'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}
