extension StringExtensions on String {
  /// Converts a String to double with safe parsing
  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }
}