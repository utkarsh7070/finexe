

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Sales/SalesProfile/model/login_user_profile.dart';


class BottomBar extends StatelessWidget {
 // final LoginUserProfile employee;
  String punchInTime;
  String punchOutTime;

  // BottomBar({Key? key, required this.employee}) : super(key: key);
  BottomBar({Key? key,required this.punchInTime,required this.punchOutTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatTime(String? dateTime) {
      if (dateTime == null) return 'N/A'; // Handle null case
      final parsedTime = DateTime.parse(dateTime);
      return DateFormat("hh:mm a").format(parsedTime); // Format as 09:30 AM/PM
    }
    final parsedTime = DateTime.parse(punchInTime);
    final parsedOutTime = DateTime.parse(punchOutTime);
    final punchIn=  DateFormat("hh:mm a").format(parsedTime);
    final punchOut=  DateFormat("hh:mm a").format(parsedOutTime);
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'PunchIn: $punchIn'??'',
           /* "Today's Work: ${employee.totalWork}",*/
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            'PunchOut: $punchOut'??'',
            /*"Break Time: ${employee.breakTime}",*/
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
