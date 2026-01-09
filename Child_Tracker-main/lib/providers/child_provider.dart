import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/child.dart';
import '../models/safe_zone.dart';
import '../models/location_history.dart';
import 'package:flutter/material.dart';

class ChildProvider with ChangeNotifier {
  List<Child> _children = [];
  List<SafeZone> _safeZones = [];
  List<LocationHistory> _locationHistory = [];
  Timer? _updateTimer;

  List<Child> get children => _children;
  List<SafeZone> get safeZones => _safeZones;
  List<LocationHistory> get locationHistory => _locationHistory;

  int get safeChildrenCount => 
    _children.where((child) => isChildSafe(child)).length;
  
  int get alertChildrenCount => 
    _children.where((child) => !isChildSafe(child)).length;

  ChildProvider() {
    _initializeDemoData();
    _startLocationUpdates();
  }

  void _initializeDemoData() {
    // Initialize safe zones based on HTML data
    _safeZones = [
      SafeZone(
        id: '1',
        name: 'Home',
        icon: '🏠',
        latitude: 28.6139,
        longitude: 77.2090,
        radiusMeters: 300,
        color: const Color(0xFF3FB950),
      ),
      SafeZone(
        id: '2',
        name: 'School',
        icon: '🏫',
        latitude: 28.6250,
        longitude: 77.2200,
        radiusMeters: 250,
        color: const Color(0xFF8B5CF6),
      ),
      SafeZone(
        id: '3',
        name: 'Park',
        icon: '🌳',
        latitude: 28.6100,
        longitude: 77.2300,
        radiusMeters: 200,
        color: const Color(0xFF6366F1),
      ),
    ];

    // Initialize children based on HTML data
    _children = [
      Child(
        id: '1',
        name: 'Rahul Kumar',
        age: 10,
        status: 'At School',
        latitude: 28.6255,
        longitude: 77.2195,
        lastUpdated: DateTime.now(),
      ),
      Child(
        id: '2',
        name: 'Sneha Singh',
        age: 8,
        status: 'At Park',
        latitude: 28.6105,
        longitude: 77.2295,
        lastUpdated: DateTime.now(),
      ),
      Child(
        id: '3',
        name: 'Aarav Patel',
        age: 12,
        status: 'At Home',
        latitude: 28.6142,
        longitude: 77.2088,
        lastUpdated: DateTime.now(),
      ),
    ];

    notifyListeners();
  }

  void _startLocationUpdates() {
    _updateTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _simulateLocationUpdates();
    });
  }

  void _simulateLocationUpdates() {
    final random = Random();
    
    for (var i = 0; i < _children.length; i++) {
      final child = _children[i];
      
      // Simulate different movement patterns for each child
      double latChange, lngChange;
      
      if (child.name == 'Rahul Kumar') {
        latChange = (random.nextDouble() - 0.3) * 0.0003;
        lngChange = (random.nextDouble() - 0.3) * 0.0003;
      } else if (child.name == 'Sneha Singh') {
        latChange = (random.nextDouble() - 0.2) * 0.0003;
        lngChange = (random.nextDouble() - 0.5) * 0.0003;
      } else {
        latChange = (random.nextDouble() - 0.5) * 0.0001;
        lngChange = (random.nextDouble() - 0.5) * 0.0001;
      }
      
      final newLat = child.latitude + latChange;
      final newLng = child.longitude + lngChange;
      final isSafe = isChildSafe(child);
      final closestZone = getClosestZone(child);
      
      _children[i] = child.copyWith(
        latitude: newLat,
        longitude: newLng,
        lastUpdated: DateTime.now(),
      );
      
      // Add to location history
      _locationHistory.insert(
        0,
        LocationHistory(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          childId: child.id,
          latitude: newLat,
          longitude: newLng,
          timestamp: DateTime.now(),
          isInSafeZone: isSafe,
          safeZoneName: closestZone.name,
          distanceFromZone: _calculateDistance(
            newLat,
            newLng,
            closestZone.latitude,
            closestZone.longitude,
          ),
        ),
      );
      
      // Keep only last 100 history records
      if (_locationHistory.length > 100) {
        _locationHistory.removeLast();
      }
    }
    
    notifyListeners();
  }

  bool isChildSafe(Child child) {
    for (var zone in _safeZones) {
      final distance = _calculateDistance(
        child.latitude,
        child.longitude,
        zone.latitude,
        zone.longitude,
      );
      if (distance <= zone.radiusMeters) {
        return true;
      }
    }
    return false;
  }

  SafeZone getClosestZone(Child child) {
    SafeZone? closest;
    double minDistance = double.infinity;
    
    for (var zone in _safeZones) {
      final distance = _calculateDistance(
        child.latitude,
        child.longitude,
        zone.latitude,
        zone.longitude,
      );
      if (distance < minDistance) {
        minDistance = distance;
        closest = zone;
      }
    }
    
    return closest!;
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000; // Earth's radius in meters
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _toRadians(double degrees) {
    return degrees * pi / 180;
  }

  List<LocationHistory> getChildHistory(String childId) {
    return _locationHistory
        .where((history) => history.childId == childId)
        .toList();
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }
}
