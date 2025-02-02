import 'package:flutter/material.dart';

import '../contracts/themeable.dart';
import '../utils/namespase/app_colors.dart';

class AppTheme extends Themeable {
  @override
  ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );
  }

  @override
  ThemeData light() {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary)),
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: AppColors.primary,
        backgroundColor: AppColors.white,
      ),
      useMaterial3: true,
      brightness: Brightness.light,
    );
  }
}
