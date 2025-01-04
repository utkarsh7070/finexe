
import 'package:flutter/material.dart';

InputDecoration dropdownDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.grey), // Match the label color with buildForm
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Adjust vertical padding
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.grey, // Color for the initial border
        width: 0.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.blue, // Color for the focused border
        width: 2.0,
      ),
    ),
  );
}

