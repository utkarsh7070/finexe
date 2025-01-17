
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/Material.dart';

InputDecoration neuMorphicCustomInputDecoration(String label, {Widget? suffixIcon}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: AppColors.lightTextColor), // Sets the label color
    border: InputBorder.none, // Removes default border
    enabledBorder: InputBorder.none, // Removes enabled state border
    focusedBorder: InputBorder.none, // Removes focused state border
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

    suffixIcon: suffixIcon, // Add suffix icon if provided// Adjust padding as needed
  );
}
