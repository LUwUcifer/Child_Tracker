import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../providers/child_provider.dart';
import '../utils/colors.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  MapboxMap? mapboxMap;
  PointAnnotationManager? pointAnnotationManager;

  @override
  Widget build(BuildContext context) {
    final childProvider = context.watch<ChildProvider>();

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.8, 0.8),
          radius: 1.5,
          colors: [
            AppColors.primaryLight.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          // Mapbox Map
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.borderPurple,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: MapWidget(
                  key: ValueKey("mapWidget"),
                  cameraOptions: CameraOptions(
                    center: {
                      "coordinates": [77.1025, 28.7041], // [longitude, latitude] for Delhi
                    },
                    zoom: 12.0,
                  ),
                  styleUri: MapboxStyles.MAPBOX_STREETS,
                  onMapCreated: (MapboxMap map) {
                    mapboxMap = map;
                    _setupMap(childProvider);
                  },
                ),
              ),
            ),
          ),

          // Safe zones legend
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Safe Zones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: childProvider.safeZones.map((zone) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            zone.color.withOpacity(0.1),
                            AppColors.surface.withOpacity(0.4),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: zone.color.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            zone.icon,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                zone.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                '${zone.radiusMeters.round()}m radius',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setupMap(ChildProvider childProvider) async {
    if (mapboxMap == null) return;

    // Create point annotation manager for markers
    pointAnnotationManager = await mapboxMap!.annotations.createPointAnnotationManager();

    // Add markers for each child
    List<PointAnnotationOptions> annotations = [];

    for (int i = 0; i < childProvider.children.length; i++) {
      final child = childProvider.children[i];
      final isSafe = childProvider.isChildSafe(child);

      // Simulate different positions around Delhi
      // In a real app, you'd use actual GPS coordinates from the child's device
      double lat = 28.7041 + (i * 0.01) - 0.02;
      double lng = 77.1025 + (i * 0.01) - 0.02;

      annotations.add(
        PointAnnotationOptions(
          geometry: {
            "type": "Point",
            "coordinates": [lng, lat], // [longitude, latitude]
          },
          iconImage: isSafe ? "marker-safe" : "marker-alert",
          iconSize: 1.5,
          textField: child.name.split(' ')[0],
          textOffset: [0.0, 1.5],
          textSize: 14.0,
          textColor: isSafe ? Colors.green.value : Colors.red.value,
        ),
      );
    }

    await pointAnnotationManager?.createMulti(annotations);

    // Add circle layers for safe zones
    for (var zone in childProvider.safeZones) {
      try {
        // Add a circle layer for each safe zone
        // Note: You'll need to implement this based on your safe zone coordinates
        // This is a simplified example
        await mapboxMap!.style.addLayer(
          CircleLayer(
            id: "safe-zone-${zone.name}",
            sourceId: "safe-zone-source-${zone.name}",
          ),
        );
      } catch (e) {
        debugPrint("Error adding safe zone layer: $e");
      }
    }
  }

  @override
  void dispose() {
    pointAnnotationManager?.deleteAll();
    super.dispose();
  }
}

class _InstructionText extends StatelessWidget {
  final String text;

  const _InstructionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: AppColors.textSecondary,
        height: 1.4,
      ),
    );
  }
}