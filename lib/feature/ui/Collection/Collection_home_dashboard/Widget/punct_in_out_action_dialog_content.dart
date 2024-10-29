import 'package:finexe/feature/base/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../home_collection_viewmodel/fetchUserProfile.dart';

class PunchOutActionContent extends ConsumerWidget{
  const PunchOutActionContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
final punchOut = ref.read(apiResponseProvider.notifier);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: const Text(
            'PunchOut',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: ()  {
             punchOut.clickPunchOut(context);
             Navigator.pop(context);

            // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.attendance, (route) => true,);
          },
        ),
        ElevatedButton(
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();

          },
        ),
      ],
    );
  }

}