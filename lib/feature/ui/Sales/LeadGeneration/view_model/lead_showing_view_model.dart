
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../model/lead_approved_model_data.dart';
import '../model/lead_pending_model_data.dart';
import '../model/lead_rejected_model_data.dart';


final leadShowViewModelProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  String? token = speciality.getToken();
  final dio = ref.watch(dioProvider);
  /* final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
*/

  final response = await dio.get(
    Api.leadShowPendingList,
    queryParameters: {"status": "pending", "role": "generate"},
    options: Options(headers: {"token": token}),
  );

  print('Response Lead status: ${response.statusCode}');
  print('Response Lead body: ${response.data}');

  if (response.statusCode == 200) {
    final List items = response.data['items'];
    return items.map((item) => Lead.fromJson(item)).toList().reversed.toList();
  } else {
    throw Exception('Failed to load Lead details');
  }
} );


final leadAssignedProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  String? token = speciality.getToken();
  final dio = ref.watch(dioProvider);
  /* final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
*/

  final response = await dio.get(
    Api.leadShowPendingList,
    queryParameters: {"status": "approve", "role": "generate"},
    options: Options(headers: {"token": token}),
  );

  print('Response Assigned Lead status: ${response.statusCode}');
  print('Response Assigned Lead body: ${response.data}');

  if (response.statusCode == 200) {
    final List items = response.data['items'];
    return items.map((item) => LeadApprovedModelData.fromJson(item)).toList().reversed.toList();
  } else {
    throw Exception('Failed to load Lead details');
  }
} );


final leadRejectedProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  String? token = speciality.getToken();
  final dio = ref.watch(dioProvider);
  /* final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
*/

  final response = await dio.get(
    Api.leadShowPendingList,
    queryParameters: {"status": "reject", "role": "generate"},
    options: Options(headers: {"token": token}),
  );

  print('Response Rejected Lead status: ${response.statusCode}');
  print('Response Rejected Lead body: ${response.data}');

  if (response.statusCode == 200) {
    final List items = response.data['items'];
    return items.map((item) => LeadRejectedModelData.fromJson(item)).toList().reversed.toList();
  } else {
    throw Exception('Failed to load Lead details');
  }
} );


/*final leadShowViewModelProvider = ChangeNotifierProvider.autoDispose((ref) => LeadShowViewModel());

class LeadShowViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  List<Lead> _leads = [];

  List<Lead> get leads => _leads;

  Future<void> fetchLeads(BuildContext context) async {
    try {
<<<<<<< HEAD
      String? token = speciality.getToken();
=======
      String? token = speciality.getToken();
>>>>>>> origin/To_merge
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
}*/

