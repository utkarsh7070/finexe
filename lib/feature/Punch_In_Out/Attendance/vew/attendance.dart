import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
      Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: displayHeight(context),
        width: displayWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Welcome'),
            const Text('Singh, Utkarsh'),
            Container(
                child: Card(
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Last Check in Time'),
                      Text('8:30'),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
