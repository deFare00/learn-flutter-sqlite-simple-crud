import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../services/student_service.dart';
import '../../data/models/student_model.dart';
import '../widgets/student_header.dart';
import '../widgets/student_info_tile.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/confirmation_dialog.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/formatter.dart';
import '../../../../core/utils/extensions.dart';

class StudentDetailPage extends StatefulWidget {
  final StudentModel student;

  const StudentDetailPage({super.key, required this.student});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  final StudentService _studentService = StudentService();
  late StudentModel _student;

  @override
  void initState() {
    super.initState();
    _student = widget.student;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.studentDetail),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.qrScanner),
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: AppStrings.scanQR,
          ),
          IconButton(
            onPressed: () => _navigateToEdit(context),
            icon: const Icon(Icons.edit_outlined),
            tooltip: AppStrings.editStudent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentHeader(student: _student),
            const SizedBox(height: AppSizes.lg),
            Text(
              'Personal Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.sm),
            _buildInfoSection(context),
            const SizedBox(height: AppSizes.lg),
            Text(
              AppStrings.studentLocation,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.sm),
            _buildLocationSection(context),
            const SizedBox(height: AppSizes.lg),
            Text(
              AppStrings.qrCode,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.sm),
            _buildQrSection(context),
            const SizedBox(height: AppSizes.lg),
            PrimaryButton(
              text: AppStrings.deleteStudent,
              icon: Icons.delete_outline,
              onPressed: () => _deleteStudent(context),
            ),
            const SizedBox(height: AppSizes.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          StudentInfoTile(
            icon: Icons.calendar_today,
            label: AppStrings.studentAge,
            value: '${_student.age} years old',
          ),
          const Divider(height: 1),
          StudentInfoTile(
            icon: Icons.school_outlined,
            label: AppStrings.studentMajor,
            value: _student.major,
          ),
          if (_student.phone != null) ...[
            const Divider(height: 1),
            StudentInfoTile(
              icon: Icons.phone_outlined,
              label: AppStrings.studentPhone,
              value: _student.phone!,
            ),
          ],
          if (_student.email != null) ...[
            const Divider(height: 1),
            StudentInfoTile(
              icon: Icons.email_outlined,
              label: AppStrings.studentEmail,
              value: _student.email!,
            ),
          ],
          if (_student.address != null) ...[
            const Divider(height: 1),
            StudentInfoTile(
              icon: Icons.location_on_outlined,
              label: AppStrings.studentAddress,
              value: _student.address!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    final hasLocation =
        _student.latitude != null && _student.longitude != null;

    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasLocation) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusCard),
              child: SizedBox(
                height: 180,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                      _student.latitude!,
                      _student.longitude!,
                    ),
                    initialZoom: 15.0,
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
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            _student.latitude!,
                            _student.longitude!,
                          ),
                          width: 80,
                          height: 80,
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.error,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.md),
          ],
          Row(
            children: [
              Expanded(
                child: StudentInfoTile(
                  icon: Icons.map_outlined,
                  label: 'Latitude',
                  value: hasLocation
                      ? Formatter.formatCoordinate(_student.latitude!)
                      : '-',
                ),
              ),
              Expanded(
                child: StudentInfoTile(
                  icon: Icons.map_outlined,
                  label: 'Longitude',
                  value: hasLocation
                      ? Formatter.formatCoordinate(_student.longitude!)
                      : '-',
                ),
              ),
            ],
          ),
          if (!hasLocation)
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.sm),
              child: EmptyState(
                icon: Icons.map_outlined,
                title: AppStrings.locationNotAvailable,
                subtitle: 'No location data for this student',
              ),
            ),
          const SizedBox(height: AppSizes.sm),
          if (hasLocation) ...[
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () => _navigateToViewLocation(context),
                icon: const Icon(Icons.map_outlined),
                label: const Text(AppStrings.openMap),
              ),
            ),
          ],
          Text(
            'Created: ${Formatter.formatDateTime(_student.createdAt)}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          if (_student.updatedAt != null)
            Text(
              'Updated: ${Formatter.formatDateTime(_student.updatedAt!)}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
        ],
      ),
    );
  }

  Widget _buildQrSection(BuildContext context) {
    if (_student.qrCode == null) {
      return AppCard(
        margin: EdgeInsets.zero,
        child: EmptyState(
          icon: Icons.qr_code,
          title: 'QR Code not available',
          subtitle: 'No QR code generated for this student',
        ),
      );
    }

    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusCard),
              border: Border.all(color: AppColors.border),
            ),
            child: QrImageView(
              data: _student.qrCode!,
              version: QrVersions.auto,
              size: 200,
              backgroundColor: Colors.white,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: AppColors.textPrimary,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radiusButton),
            ),
            child: Text(
              _student.qrCode!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            'Scan this QR to view student details',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: AppSizes.md),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () => _navigateToQrDetail(context),
              icon: const Icon(Icons.qr_code),
              label: const Text('View Full QR Page'),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.of(context)
        .pushNamed('/edit-student', arguments: _student)
        .then((_) => _refreshStudent());
  }

  void _navigateToQrDetail(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.qrDetail, arguments: _student);
  }

  void _navigateToViewLocation(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.maps,
      arguments: {
        'latitude': _student.latitude,
        'longitude': _student.longitude,
        'studentName': _student.name,
      },
    );
  }

  Future<void> _refreshStudent() async {
    if (_student.id == null) return;
    try {
      final updated = await _studentService.getStudentById(_student.id!);
      if (!mounted) return;
      if (updated != null) {
        setState(() => _student = updated);
      }
    } catch (_) {}
  }

  Future<void> _deleteStudent(BuildContext context) async {
    await ConfirmationDialog.show(
      context,
      title: AppStrings.deleteStudent,
      message: '${AppStrings.deleteConfirmation}\n\n${_student.name}',
      onConfirm: () async {
        try {
          await _studentService.deleteStudent(_student.id!);
          if (!context.mounted) return;
          context.showSuccessSnackBar(AppStrings.studentDeleted);
          Navigator.of(context).pop();
        } catch (e) {
          if (!context.mounted) return;
          context.showErrorSnackBar(e.toString());
        }
      },
    );
  }
}