import 'package:flutter/material.dart';

import '../../../student/data/models/student_model.dart';
import '../widgets/qr_code_widget.dart';
import '../../../student/presentation/widgets/student_info_tile.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';

class QrDetailPage extends StatelessWidget {
  final StudentModel student;

  const QrDetailPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.qrDetail),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large QR Code
            Center(
              child: QrCodeWidget(
                data: student.qrCode ?? 'N/A',
                size: 240,
                showLabel: true,
              ),
            ),
            const SizedBox(height: AppSizes.lg),
            // Student Info Summary
            Text(
              AppStrings.qrStudentInfo,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.sm),
            _buildStudentInfoCard(context),
            const SizedBox(height: AppSizes.lg),
            // Actions
            PrimaryButton(
              text: AppStrings.openStudentDetail,
              icon: Icons.person,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  '/student-detail',
                  arguments: student,
                );
              },
            ),
            const SizedBox(height: AppSizes.md),
            SecondaryButton(
              text: AppStrings.scanAnother,
              icon: Icons.qr_code_scanner,
              onPressed: () {
                Navigator.of(context).pushNamed('/qr-scanner');
              },
            ),
            const SizedBox(height: AppSizes.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentInfoCard(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primary,
                child: Text(
                  student.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      student.major,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: AppSizes.lg),
          StudentInfoTile(
            icon: Icons.calendar_today,
            label: AppStrings.studentAge,
            value: '${student.age} years old',
          ),
          if (student.phone != null) ...[
            const Divider(height: 1),
            StudentInfoTile(
              icon: Icons.phone_outlined,
              label: AppStrings.studentPhone,
              value: student.phone!,
            ),
          ],
          if (student.email != null) ...[
            const Divider(height: 1),
            StudentInfoTile(
              icon: Icons.email_outlined,
              label: AppStrings.studentEmail,
              value: student.email!,
            ),
          ],
        ],
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusButton),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: AppSizes.iconMedium),
              const SizedBox(width: AppSizes.sm),
            ],
            Text(text),
          ],
        ),
      ),
    );
  }
}