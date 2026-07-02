import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../services/maps_service.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/formatter.dart';

class PickLocationPage extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;

  const PickLocationPage({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  final MapsService _mapsService = MapsService();
  final MapController _mapController = MapController();

  LatLng? _selectedLocation;
  LatLng _center = MapsService.defaultCenter;
  bool _isGettingCurrentLocation = false;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      setState(() {
        _selectedLocation = LatLng(
          widget.initialLatitude!,
          widget.initialLongitude!,
        );
        _center = _selectedLocation!;
      });
    } else {
      await _mapsService.ensureLocationPermission();
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isGettingCurrentLocation = true);

    final location = await _mapsService.getCurrentLocation();
    if (!mounted) return;

    if (location != null) {
      setState(() {
        _selectedLocation = location;
        _center = location;
        _isGettingCurrentLocation = false;
      });
      _mapController.move(location, 15.0);
    } else {
      setState(() {
        _isGettingCurrentLocation = false;
      });
    }
  }

  void _onMapTapped(TapPosition tapPosition, LatLng point) {
    setState(() {
      _selectedLocation = point;
    });
  }

  void _onConfirm() {
    if (_selectedLocation == null) return;
    Navigator.of(context).pop({
      'latitude': _selectedLocation!.latitude,
      'longitude': _selectedLocation!.longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pickLocation),
        actions: [
          IconButton(
            onPressed: _getCurrentLocation,
            icon: _isGettingCurrentLocation
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
            tooltip: AppStrings.currentLocation,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildMap()),
          _buildBottomPanel(context),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _center,
            initialZoom: MapsService.defaultZoom,
            onTap: _onMapTapped,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.student_management',
            ),
            if (_selectedLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedLocation!,
                    width: 80,
                    height: 80,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.error,
                          size: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.sm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusButton,
                            ),
                          ),
                          child: Text(
                            'Selected',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
        // Crosshair in center when no location selected yet
        if (_selectedLocation == null && !_isGettingCurrentLocation)
          const Center(
            child: Icon(
              Icons.add_location,
              color: Colors.black54,
              size: 48,
            ),
          ),
        // Loading overlay
        if (_isGettingCurrentLocation)
          Container(
            color: Colors.black26,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildBottomPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedLocation != null) ...[
            Row(
              children: [
                Expanded(
                  child: _buildCoordinateChip(
                    'Lat',
                    Formatter.formatCoordinate(_selectedLocation!.latitude),
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: _buildCoordinateChip(
                    'Lng',
                    Formatter.formatCoordinate(_selectedLocation!.longitude),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.md),
          ],
          if (_selectedLocation == null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.touch_app,
                  color: AppColors.textHint,
                  size: AppSizes.iconSmall,
                ),
                const SizedBox(width: AppSizes.sm),
                Text(
                  'Tap on the map to select a location',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.md),
          ],
          PrimaryButton(
            text: _selectedLocation != null
                ? AppStrings.confirmLocation
                : AppStrings.selectOnMap,
            icon: _selectedLocation != null
                ? Icons.check
                : Icons.map_outlined,
            onPressed: _selectedLocation != null ? _onConfirm : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCoordinateChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.radiusButton),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}