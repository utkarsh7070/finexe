import 'package:flutter/material.dart' show ThemeData;

abstract class Themeable {
  ThemeData light();
  ThemeData dark();
}