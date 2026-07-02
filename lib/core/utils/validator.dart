import '../constants/app_strings.dart';

class Validator {
  Validator._();

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.nameRequired;
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return 'Name must be at most 100 characters';
    }
    final nameRegex = RegExp(r"^[a-zA-Z\s\-\.']+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Name contains invalid characters';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.ageRequired;
    }
    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'Age must be a valid number';
    }
    if (age < 1) {
      return 'Age must be at least 1';
    }
    if (age > 120) {
      return 'Age must be at most 120';
    }
    return null;
  }

  static String? validateMajor(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.majorRequired;
    }
    if (value.trim().length < 2) {
      return 'Major must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return 'Major must be at most 100 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (value.trim().length > 254) {
      return 'Email is too long';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final digitsOnly = value.trim().replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final phoneRegex = RegExp(r'^\+?\d{7,15}$');
    if (!phoneRegex.hasMatch(digitsOnly)) {
      return AppStrings.phoneInvalid;
    }
    return null;
  }
}