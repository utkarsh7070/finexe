

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/api/api.dart';
import '../model/leave_listing_model.dart';


final leaveRequestDetailsViewModelProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final viewModel = LeaveRequestDetailsViewModel();
  return viewModel.fetchLeaveRequests();
});

class LeaveRequestDetailsViewModel {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchLeaveRequests() async {
    try {
      String? token = speciality.getToken();

      final response = await _dio.get( Api.getLeaveDetails,
        options: Options(headers: {"token": token}),); // Replace with your endpoint.

      print('Leave Details Response ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];
        final counters = CountersModel.fromJson(data);

        final leaveRequests = (data['employeeLeave'] as List)
            .map((e) => LeaveRequestModel.fromJson(e))
            .toList();
        print('data leave request>>>>>>>> ${data['employeeLeave'].toString()}');



        return {
          "counters": counters,
          "leaveRequests": leaveRequests.reversed.toList(),
        };
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error fetching leave requests: $e");
    }
  }
}


//.................Filter Dialoge...........

//.................Filter by status...........
class LeaveStatusFilterNotifier extends StateNotifier<String?> {
  LeaveStatusFilterNotifier() : super(null);

  void selectFilter(String? filter) {
    state = filter;
  }

  void resetFilter() {
    state = null;
  }
}

final leaveStatusFilterProvider = StateNotifierProvider<LeaveStatusFilterNotifier, String?>((ref) {
  return LeaveStatusFilterNotifier();
});

//.................Filter by Type...........

class LeaveTypeFilterNotifier extends StateNotifier<String?> {
  LeaveTypeFilterNotifier() : super(null);

  void selectFilter(String? filter) {
    state = filter;
  }

  void resetFilter() {
    state = null;
  }
}

final leaveTypeFilterProvider = StateNotifierProvider<LeaveTypeFilterNotifier, String?>((ref) {
  return LeaveTypeFilterNotifier();
});
