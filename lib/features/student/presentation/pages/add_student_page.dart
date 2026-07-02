import 'package:flutter/material.dart';

import '../../services/student_service.dart';
import '../../data/models/student_model.dart';
import '../../../qr/services/qr_service.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/formatter.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/utils/extensions.dart';

class AddStudentPage extends StatefulWidget {
  final StudentModel? student;

  const AddStudentPage({super.key, this.student});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final StudentService _studentService = StudentService();
  final QrService _qrService = QrService();
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _majorController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _majorFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  double? _latitude;
  double? _longitude;

  bool _isSaving = false;

  bool get _isEditing => widget.student != null;
  

  @override
  void initState() {
    super.initState();
    _latitude = widget.student?.latitude;
    _longitude = widget.student?.longitude;
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _ageController = TextEditingController(
      text: widget.student?.age.toString() ?? '',
    );
    _majorController = TextEditingController(text: widget.student?.major ?? '');
    _phoneController = TextEditingController(text: widget.student?.phone ?? '');
    _emailController = TextEditingController(text: widget.student?.email ?? '');
    _addressController = TextEditingController(
      text: widget.student?.address ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _majorController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _nameFocus.dispose();
    _ageFocus.dispose();
    _majorFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.of(context).pushNamed(
      AppRoutes.pickLocation,
      arguments: {
        if (_latitude != null) 'latitude': _latitude,
        if (_longitude != null) 'longitude': _longitude,
      },
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _latitude = result['latitude'] as double;
        _longitude = result['longitude'] as double;
      });
    }
  }

  Widget _buildLocationPicker() {
    return AppCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: _pickLocation,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: _latitude != null
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.radiusButton),
                ),
                child: Icon(
                  _latitude != null
                      ? Icons.location_on
                      : Icons.add_location_outlined,
                  color: _latitude != null
                      ? AppColors.primary
                      : AppColors.textHint,
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.pickLocation,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      _latitude != null
                          ? '${Formatter.formatCoordinate(_latitude!)}, ${Formatter.formatCoordinate(_longitude!)}'
                          : 'Tap to select location on map',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if (_latitude != null)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _latitude = null;
                      _longitude = null;
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    size: AppSizes.iconSmall,
                    color: AppColors.textHint,
                  ),
                ),
              const Icon(Icons.chevron_right, color: AppColors.textHint),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final now = DateTime.now().toIso8601String();
      final student = StudentModel(
        id: widget.student?.id,
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        major: _majorController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        email: _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
        address: _addressController.text.trim().isEmpty
            ? null
            : _addressController.text.trim(),
        qrCode: widget.student?.qrCode ?? _generateQrCode(),
        latitude: _latitude,
        longitude: _longitude,
        createdAt: widget.student?.createdAt ?? now,
        updatedAt: _isEditing ? now : null,
      );

      if (_isEditing) {
        await _studentService.updateStudent(student);
        if (!mounted) return;
        context.showSuccessSnackBar(AppStrings.studentUpdated);
      } else {
        await _studentService.addStudent(student);
        if (!mounted) return;
        context.showSuccessSnackBar(AppStrings.studentAdded);
      }

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar(e.toString());
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  String _generateQrCode() {
    return _qrService.generateQrCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? AppStrings.editStudent : AppStrings.addStudent,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEditing
                    ? 'Edit student information'
                    : 'Fill in the student details below',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSizes.lg),
              AppTextField(
                controller: _nameController,
                label: '${AppStrings.studentName} *',
                hintText: 'Enter full name',
                prefixIcon: Icons.person_outline,
                validator: Validator.validateName,
                textInputAction: TextInputAction.next,
                focusNode: _nameFocus,
                onSubmitted: () => _ageFocus.requestFocus(),
              ),
              const SizedBox(height: AppSizes.md),
              AppTextField(
                controller: _ageController,
                label: '${AppStrings.studentAge} *',
                hintText: 'Enter age',
                prefixIcon: Icons.calendar_today,
                keyboardType: TextInputType.number,
                validator: Validator.validateAge,
                textInputAction: TextInputAction.next,
                focusNode: _ageFocus,
                onSubmitted: () => _majorFocus.requestFocus(),
              ),
              const SizedBox(height: AppSizes.md),
              AppTextField(
                controller: _majorController,
                label: '${AppStrings.studentMajor} *',
                hintText: 'e.g. Computer Science',
                prefixIcon: Icons.school_outlined,
                validator: Validator.validateMajor,
                textInputAction: TextInputAction.next,
                focusNode: _majorFocus,
                onSubmitted: () => _phoneFocus.requestFocus(),
              ),
              const SizedBox(height: AppSizes.md),
              AppTextField(
                controller: _phoneController,
                label: AppStrings.studentPhone,
                hintText: 'e.g. +628123456789',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: Validator.validatePhone,
                textInputAction: TextInputAction.next,
                focusNode: _phoneFocus,
                onSubmitted: () => _emailFocus.requestFocus(),
              ),
              const SizedBox(height: AppSizes.md),
              AppTextField(
                controller: _emailController,
                label: AppStrings.studentEmail,
                hintText: 'e.g. student@example.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: Validator.validateEmail,
                textInputAction: TextInputAction.next,
                focusNode: _emailFocus,
                onSubmitted: () => _addressFocus.requestFocus(),
              ),
              const SizedBox(height: AppSizes.md),
              AppTextField(
                controller: _addressController,
                label: AppStrings.studentAddress,
                hintText: 'Enter address (optional)',
                prefixIcon: Icons.location_on_outlined,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                focusNode: _addressFocus,
                onSubmitted: () => _save(),
              ),
              const SizedBox(height: AppSizes.md),
              _buildLocationPicker(),
              const SizedBox(height: AppSizes.xl),
              PrimaryButton(
                text: _isEditing ? AppStrings.update : AppStrings.save,
                isLoading: _isSaving,
                icon: _isEditing ? Icons.edit : Icons.save,
                onPressed: _save,
              ),
              const SizedBox(height: AppSizes.md),
              SecondaryButton(
                text: AppStrings.cancel,
                icon: Icons.close,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: AppSizes.xl),
            ],
          ),
        ),
      ),
    );
  }
}