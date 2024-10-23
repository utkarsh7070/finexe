import 'package:finexe/feature/Punch_In_Out/viewmodel/viewmodel.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:finexe_attendance/feature/constant/namespase/app_colors.dart';
// import '../controller/attendance_controller.dart';
import 'dart:developer';

class AttendanceScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(attendanceProvider);
    log('loading: ' + controller.isLoading.toString());
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {
                      ref.read(attendanceProvider.notifier).clickPunch(context);
                    },
                    child: Text(
                      controller.punchStatus ? 'Punch In' : 'Punch Out',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
