import 'package:flutter/material.dart';

class DashBoardDrawerItem {
  final IconData? iconData;
  final String? title;
  final bool? isExpanded;

  DashBoardDrawerItem(
      {required this.iconData, required this.title, required this.isExpanded});
}
