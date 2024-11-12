
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';
import '../model/lead_pending_model_data.dart';

final leadShowViewModelProvider = ChangeNotifierProvider.autoDispose((ref) => LeadShowViewModel());

class LeadShowViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  List<Lead> _leads = [];

  List<Lead> get leads => _leads;

  Future<void> fetchLeads(BuildContext context) async {
    try {
      String? token = await SessionService.getToken();
      final Map<String, String> queryParam = {"status": "pending", "role": "generate"};
      final response = await _dio.get(
        Api.leadShowPendingList,
        queryParameters: queryParam,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        final data = response.data['items'] as List;
        _leads = data.map((leadJson) => Lead.fromJson(leadJson)).toList();
        notifyListeners(); // Notify listeners to update the UI
      } else {
        throw Exception('Failed to load pending lead');
      }
    } catch (e) {
      print("Error getting lead pending list: $e");
    }
  }
}



/*import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';
import '../model/lead_pending_model_data.dart';

final leadShowViewModelProvider = Provider((ref) => LeadShowViewModel());

class LeadShowViewModel {
  final Dio _dio = Dio();

  Future<void> leadFormSubmit(Lead leadData,BuildContext context) async {
    try {
      String? token = await SessionService.getToken();
      final Map<String, String> queryParam = {"status": "pending","role": "generate"};
    //  print('lead input ${leadData.toJson()}');
      final response = await _dio.post(Api.leadShowPendingList, // Replace with your API endpoint
        //  data: leadData.toJson(),
          queryParameters: queryParam,
          options: Options(headers: {"token": token})
      );

      if (response.statusCode == 200) {
        //log('Lead Generated Successfully');
        print('Lead Pending Show Response ${response.data}');
      //  showCustomSnackBar(context, 'Lead Generated Successfully', Colors.green);
        // Handle success response
      } else {
        throw Exception('Failed to load pending lead');
      }
    } catch (e) {
      // Handle error
      print("Error getting lead pending list: $e");
    }
  }
}*/



/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final leadProvider = StateNotifierProvider<LeadViewModel, List<Lead>>((ref) {
  return LeadViewModel();
});

class LeadViewModel extends StateNotifier<List<Lead>> {
  LeadViewModel() : super([]);

  final _dio = Dio();

  Future<void> fetchLeads() async {
    try {
      final response = await _dio.get('https://yourapiurl.com/leads');
      final data = response.data['items'] as List;
      state = data.map((leadJson) => Lead.fromJson(leadJson)).toList();
    } catch (e) {
      print("Error fetching leads: $e");
    }
  }
}*/
