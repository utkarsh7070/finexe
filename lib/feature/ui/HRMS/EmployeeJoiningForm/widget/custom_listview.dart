import 'package:flutter/material.dart';

class AppListview extends StatelessWidget {
  AppListview({super.key, required this.builder, required this.items, required this.scrollphysics});
  
  final Widget Function(BuildContext, int) builder;
  final int items;
  ScrollPhysics scrollphysics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: scrollphysics,
      shrinkWrap: true,
      itemCount: items,
      itemBuilder:builder,
       
 
    );
  }
}
