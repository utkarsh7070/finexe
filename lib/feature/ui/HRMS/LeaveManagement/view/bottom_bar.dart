import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../Sales/SalesProfile/model/login_user_profile.dart';

class BottomBar extends StatelessWidget {
  // final LoginUserProfile employee;
  final String punchInTime;
  final String punchOutTime;

  // BottomBar({Key? key, required this.employee}) : super(key: key);
  const BottomBar({Key? key, required this.punchInTime, required this.punchOutTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatTime(String time) {
      print(time);
      try {
        if (time.isEmpty) return 'N/A';
        DateFormat format = DateFormat("yyyy-MM-dd'T'hh:mm:ss a");
        DateTime dateTime = format.parse(time);// Handle empty strings
        // final parsedTime = DateTime.parse(time);
        print('parse time ${dateTime}');
        return DateFormat.jm()
            .format(dateTime); // Format as 09:30 AM/PM
      } catch (e) {
        // Log or handle invalid date format
        debugPrint("Error parsing date: $e");
        return 'Invalid Time';
      }
    }

    final punchIn = formatTime(punchInTime);
    final punchOut = formatTime(punchOutTime);

    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'PunchIn: $punchIn' ?? '',

            style: const TextStyle(color: Colors.white),
          ),
          Text(
            'PunchOut: $punchOut' ?? '',
            /*"Break Time: ${employee.breakTime}",*/
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
