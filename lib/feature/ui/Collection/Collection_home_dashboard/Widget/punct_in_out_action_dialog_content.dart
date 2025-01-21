import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Sales/SalesProfile/view_model/sales_user_view_model.dart';
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
             punchOut.clickPunchOut(context).then((value) {
               Navigator.pop(context);
               ref.refresh(loginUserProfileProvider);
             },);

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