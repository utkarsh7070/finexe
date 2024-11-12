// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../authenticate/view_model/login_view_model.dart';
//
// final gridItem= StateProvider<List<GridItem>>((ref) {
// return <GridItem>[
//   GridItem(title: 'All Cases',subTitle: '1500+',icon: 'assets/images/job.png' ),
//   GridItem(title: 'Approved',subTitle: '1500+',icon: 'assets/images/check.png' ),
//   GridItem(title: 'Pending',subTitle: '1500+',icon: 'assets/images/pending.png' ),
//   GridItem(title: 'Rejected',subTitle: '1500+',icon: 'assets/images/reject.png' )
// ];
// },);
//
// final radiosProvider = StateNotifierProvider<RadiosNotifier, Roles>((ref) {
//   return RadiosNotifier();
// });
//
// class RadiosNotifier extends StateNotifier<Roles> {
//   RadiosNotifier() : super(Roles.All); // Default value for the radio buttons
//
//   // Method to update the selected value
//   void select(Roles value) {
//     state = value;
//   }
// }
//
// class GridItem{
//   final String icon;
//   final String title;
//   final String subTitle;
//   GridItem({required this.icon, required this.title, required this.subTitle});
//
// }
// enum Roles { All, Approved, Pending,Rejected,Incomplete }

// Define GridItem model
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';

class GridItem {
  final String icon;
  final String title;
  String subTitle; // Make subTitle mutable to update later

  GridItem({required this.icon, required this.title, required this.subTitle});
}

// Provider for storing grid items
final gridItemProvider = StateProvider<List<GridItem>>((ref) {
  return [
    GridItem(title: 'All Cases', subTitle: 'Loading...', icon: 'assets/images/job.png'),
    GridItem(title: 'Approved', subTitle: 'Loading...', icon: 'assets/images/check.png'),
    GridItem(title: 'Pending', subTitle: 'Loading...', icon: 'assets/images/pending.png'),
    GridItem(title: 'Rejected', subTitle: 'Loading...', icon: 'assets/images/reject.png'),
  ];
});

//  api call

// Provider for the dashboard view model
final dashboardShowViewModelProvider = ChangeNotifierProvider((ref) => DashboardShowViewModel());

// ViewModel for handling API call
class DashboardShowViewModel extends ChangeNotifier {
  final Dio _dio = Dio();

  Future<void> fetchLeads(BuildContext context, WidgetRef ref) async {
    try {
      String? token = await SessionService.getToken();
      final response = await _dio.get(
        Api.salesDashboardData,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        final data = response.data['items'];

        // Map API data to the grid items
        ref.read(gridItemProvider.notifier).state = [
          GridItem(title: 'All Cases', subTitle: '${data['totalLogin']}', icon: 'assets/images/job.png'),
          GridItem(title: 'Approved', subTitle: '${data['cibilOk']}', icon: 'assets/images/check.png'),
          GridItem(title: 'Pending', subTitle: '${data['totalPending']}', icon: 'assets/images/pending.png'),
          GridItem(title: 'Rejected', subTitle: '${data['cibilRejected']}', icon: 'assets/images/reject.png'),
        ];

        notifyListeners(); // Notify listeners to update the UI
      } else {
        throw Exception('Failed to load lead data');
      }
    } catch (e) {
      print("Error getting lead data: $e");
    }
  }
}