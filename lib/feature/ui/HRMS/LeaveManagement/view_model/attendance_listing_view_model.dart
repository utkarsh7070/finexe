import 'package:dio/dio.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';
import '../../../Collection/Collection_home_dashboard/home_collection_viewmodel/fetchUserProfile.dart';
import '../model/attendance_listing_model.dart';


/*final roleName = Provider<RoleListModel>(
  (ref) {
    final prefs = ref.watch(sharedPreferencesHrmsProvider).asData?.value;
    List<String>? role = prefs?.getStringList('roleName');
    RoleListModel roleListModel = RoleListModel(role: role ?? []);
    return roleListModel;
  },
);

final sharedPreferencesHrmsProvider =
    FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});*/




class AttendanceState {
  final bool isLoading;
  final Map<String, dynamic>? data;
  final String? error;

  AttendanceState({this.isLoading = false, this.data, this.error});

  AttendanceState copyWith(
      {bool? isLoading, Map<String, dynamic>? data, String? error}) {
    return AttendanceState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

final attendanceListingProvider = StateNotifierProvider.family<
    AttendanceNotifier, AsyncValue<Map<String, dynamic>>, String>(
      (ref, employeeId) {
    final controllerNotifier = ref.read(controllerProvider);
    final notifier = AttendanceNotifier(controllerNotifier.monthController);
    notifier.fetchAttendanceRequests(employeeId);
    return notifier;
  },
);

class AttendanceNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final Dio _dio = Dio();

  final TextEditingController monthController;

  AttendanceNotifier(this.monthController) : super(const AsyncValue.loading());

  Future<void> fetchAttendanceRequests(String employeeId) async {
    try {
      state = const AsyncValue.loading();

      String? token = await SessionService.getToken();

      // Check if monthController.text is empty (no month selected)
      if (monthController.text.isEmpty) {
        // Set current month as default if no month is selected
        monthController.text = DateFormat('MMMM').format(DateTime.now());
      }

      // Get the selected month from the controller
      String selectedMonth = monthController.text;
      int monthNumber =
      _getMonthNumber(selectedMonth); // Convert to numeric representation

      final response = await _dio.get(
        Api.getAttendanceDetails,
        queryParameters: {
          "employeeId": employeeId,
          /*"month": currentMonth,*/
          "month": monthNumber.toString().padLeft(2, '0'), // Ensure two digits
        },
        options: Options(headers: {"token": token}),
      );

      print('Attendance Response $response');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];
        final attendanceList = (data?['attendanceRecords'] as List<dynamic>?)
            ?.map((e) => AttendanceRecord.fromJson(e))
            .toList() ??
            <AttendanceRecord>[];

        final counters = data != null ? AttendanceItems.fromJson(data) : null;

        state = AsyncValue.data({
          "counters": counters,
          "attendanceRecords": attendanceList,
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Helper method to convert month name to numeric value
  int _getMonthNumber(String monthName) {
    const monthMap = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12,
    };

    return monthMap[monthName] ??
        DateTime.now().month; // Default to current month if not found
  }
}

class ControllerNotifier extends StateNotifier<void> {
  final TextEditingController monthController = TextEditingController();

  ControllerNotifier() : super(null) {
    resetToCurrentMonth(); // Initialize with current month
  }

  final List<String> monthOptions = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'November',
    'December',
  ];

  void resetToCurrentMonth() {
    monthController.text = DateFormat('MMMM').format(DateTime.now());
  }

  @override
  void dispose() {
    monthController.dispose();
    super.dispose();
  }
}

final controllerProvider = Provider<ControllerNotifier>((ref) {
  final controllerNotifier = ControllerNotifier();
  ref.onDispose(() => controllerNotifier
      .dispose()); // Dispose the controller when the provider is no longer used
  return controllerNotifier;
});
