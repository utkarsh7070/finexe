

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';
import '../model/attendance_listing_model.dart';




final attendanceListingProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>((ref, employeeId) async {
  final viewModel = AttendanceProvider();
  return viewModel.fetchAttendanceRequests(employeeId);
});

class AttendanceProvider {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchAttendanceRequests(String employeeId) async {
    try {
      String? token = await SessionService.getToken();

      // Get the current month in the required format
      String currentMonth = DateFormat('MM').format(DateTime.now());

      final response = await _dio.get(
        Api.getAttendanceDetails,
        queryParameters: {
          "employeeId": employeeId,
          "month": currentMonth,
        },
        options: Options(headers: {"token": token}),
      );

      print('Attendance Details Response ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];

        // Ensure `attendanceRecords` is handled safely
        final attendanceList = (data?['attendanceRecords'] as List<dynamic>?)
            ?.map((e) => AttendanceRecord.fromJson(e))
            .toList() ??
            <AttendanceRecord>[]; // Provide a default empty list if null

        final counters = data != null ? AttendanceItems.fromJson(data) : null;

        return {
          "counters": counters,
          "attendanceRecords": attendanceList,
        };
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error in fetchAttendanceRequests: $e");
      throw Exception("Error fetching attendance data: $e");
    }
  }
}



/*final attendanceListingProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final viewModel = AttendanceProvider();
  return viewModel.fetchAttendanceRequests();
});

class AttendanceProvider {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchAttendanceRequests() async {
    try {
      String? token = await SessionService.getToken();

      // Get the current month in the required format
      String currentMonth = DateFormat('MM').format(DateTime.now());

      final response = await _dio.get(
        Api.getAttendanceDetails,
        queryParameters: {
          "employeeId": "66981647db41e6bc29efcc77",
          "month": currentMonth,
        },
        options: Options(headers: {"token": token}),
      );

      print('Attendance Details Response ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];

        // Ensure `attendanceRecords` is handled safely
        final attendanceList = (data?['attendanceRecords'] as List<dynamic>?)
            ?.map((e) => AttendanceRecord.fromJson(e))
            .toList() ??
            <AttendanceRecord>[]; // Provide a default empty list if null

        final counters = data != null ? AttendanceItems.fromJson(data) : null;

        return {
          "counters": counters,
          "attendanceRecords": attendanceList,
        };
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error in fetchAttendanceRequests: $e");
      throw Exception("Error fetching attendance data: $e");
    }
  }


*//*Future<Map<String, dynamic>> fetchAttendanceRequests() async {
    try {
      String? token = await SessionService.getToken();

      // Get the current month in the required format
      String currentMonth = DateFormat('MM').format(DateTime.now());

      final response = await _dio.get( Api.getAttendanceDetails,
        queryParameters: {"employeeId": "66981647db41e6bc29efcc77", "month": currentMonth},
        options: Options(headers: {"token": token}),); // Replace with your endpoint.

      print('Attendance Details Response ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];

        AttendanceItems? counters = data != null ? AttendanceItems.fromJson(data) : null;

        final attendanceList = data != null && data['attendanceRecords'] != null
            ? (data['attendanceRecords'] as List)
            .map((e) => AttendanceRecord.fromJson(e))
            .toList()
            : <AttendanceRecord>[];

        return {
          "counters": counters,
          "attendanceRecords": attendanceList,
        };
      }else {
        throw Exception("Failed to load data");
      }


      *//**//* if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];
        final counters = AttendanceItems.fromJson(data);

        final attendanceList = (data['attendanceRecords'] as List)
            .map((e) => AttendanceRecord.fromJson(e))
            .toList();

        return {
          "counters": counters,
          "attendanceRecords": attendanceList,
        };
      } else {
        throw Exception("Failed to load data");
      }*//**//*
    } catch (e) {
      throw Exception("Error fetching leave requests: $e");
    }
  }*//*
}*/
