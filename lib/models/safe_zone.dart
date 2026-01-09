import 'package:flutter/material.dart';

class SafeZone {
  final String id;
  final String name;
  final String icon;
  final double latitude;
  final double longitude;
  final double radiusMeters;
  final Color color;

  SafeZone({
    required this.id,
    required this.name,
    required this.icon,
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'latitude': latitude,
      'longitude': longitude,
      'radiusMeters': radiusMeters,
      'color': color.value,
    };
  }

  factory SafeZone.fromJson(Map<String, dynamic> json) {
    return SafeZone(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radiusMeters: json['radiusMeters'],
      color: Color(json['color']),
    );
  }
}
