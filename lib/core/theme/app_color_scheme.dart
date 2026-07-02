import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppColorScheme {
  AppColorScheme._();

  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.surface,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.surface,
    secondary: AppColors.secondary,
    onSecondary: AppColors.surface,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    error: AppColors.error,
    onError: AppColors.surface,
    outline: AppColors.border,
  );
}