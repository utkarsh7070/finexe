

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration customInputDecoration(String label, {Widget? suffixIcon}) {
  return InputDecoration(
    labelText: label,
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Adjust vertical padding
    labelStyle: const TextStyle(color: Colors.grey),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.blue), // Replace with `AppColors.primary` if defined
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red),
    ),
    filled: true,
    fillColor: Colors.white,
    suffixIcon: suffixIcon, // Add suffix icon if provided
  );
}
