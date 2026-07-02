import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/services/permission_service.dart';

class MapsService {
  final PermissionService _permissionService;

  MapsService({PermissionService? permissionService})
      : _permissionService = permissionService ?? PermissionService.instance;

  /// Default center location (Indonesia)
  static const LatLng defaultCenter = LatLng(-6.2088, 106.8456);
  static const double defaultZoom = 12.0;

  /// Check and request location permission
  Future<bool> ensureLocationPermission() async {
    final hasPermission = await _permissionService.hasLocationPermission();
    if (hasPermission) return true;
    return await _permissionService.requestLocationPermission();
  }

  /// Get current position
  Future<LatLng?> getCurrentLocation() async {
    final hasPermission = await ensureLocationPermission();
    if (!hasPermission) return null;

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      );
      return LatLng(position.latitude, position.longitude);
    } catch (_) {
      return null;
    }
  }

  /// Calculate distance between two coordinates in meters
  static double calculateDistance(LatLng from, LatLng to) {
    return Geolocator.distanceBetween(
      from.latitude,
      from.longitude,
      to.latitude,
      to.longitude,
    );
  }
}