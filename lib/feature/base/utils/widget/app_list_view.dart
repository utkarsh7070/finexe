import 'package:flutter/material.dart';

class AppListview extends StatelessWidget {
  const AppListview({super.key, required this.builder, required this.items, required this.scrollPhysics});

  final Widget Function(BuildContext, int) builder;
  final int items;
  final ScrollPhysics scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:scrollPhysics,
      shrinkWrap: true,
      itemCount: items,
      itemBuilder: builder,

    );
  }
}
