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
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/ui/Sales/OnBoarding/model/get_all_cases_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';

class GridItem {
  final String icon;
  final String title;
  String subTitle; // Make subTitle mutable to update later

  GridItem({required this.icon, required this.title, required this.subTitle});
}

// Provider for storing grid items
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});

final  customerName = Provider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).asData?.value;
    String? name =  prefs?.getString('name');
  return name;
},);

final roleName = Provider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).asData?.value;
  return  prefs?.getString('roleName');
},);



final gridItemProvider = StateProvider<List<GridItem>>((ref) {
  return [
    GridItem(
        title: 'All Cases',
        subTitle: 'Loading...',
        icon: 'assets/images/job.png'),
    GridItem(
        title: 'Approved',
        subTitle: 'Loading...',
        icon: 'assets/images/check.png'),
    GridItem(
        title: 'Pending',
        subTitle: 'Loading...',
        icon: 'assets/images/pending.png'),
    GridItem(
        title: 'Rejected',
        subTitle: 'Loading...',
        icon: 'assets/images/reject.png'),
  ];
});

//  api call

// Provider for the dashboard view model
final dashboardShowViewModelProvider = ChangeNotifierProvider((ref) {
  final dio = ref.watch(dioProvider);
  return DashboardShowViewModel(dio);
});

// ViewModel for handling API call
class DashboardShowViewModel extends ChangeNotifier {
  final Dio _dio;

  DashboardShowViewModel(this._dio);

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
          GridItem(
              title: 'All Cases',
              subTitle: '${data['totalLogin']}',
              icon: 'assets/images/job.png'),
          GridItem(
              title: 'Approved',
              subTitle: '${data['cibilOk']}',
              icon: 'assets/images/check.png'),
          GridItem(
              title: 'Pending',
              subTitle: '${data['totalPending']}',
              icon: 'assets/images/pending.png'),
          GridItem(
              title: 'Rejected',
              subTitle: '${data['cibilRejected']}',
              icon: 'assets/images/reject.png'),
        ];
        // ref.read(customerName.notifier).state = data['employeName'];

        notifyListeners(); // Notify listeners to update the UI
      } else {
        throw Exception('Failed to load lead data');
      }
    } catch (e) {
      print("Error getting lead data: $e");
    }
  }

}

final openDrawerProvider = StateProvider<bool>((ref) {
 return false;
},);


final getCasesData = StateNotifierProvider<AllCases, CaseModel>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return AllCases(dio);
  },
);

class AllCases extends StateNotifier<CaseModel> {
  final Dio dio;

  // List<Item> list =[];
  AllCases(this.dio) : super(CaseModel());



  // List<Item> listData = [];

  Future<void> switchTab(int value) async {
    switch (value) {
      case 1:
        await fetchAllCases();
        break;
      case 2:
        await fetchCibilOk();
        break;
      case 3:
        await fetchCibilPending();
      case 4:
        await fetchCibilReject();
        break;
      default:
        break;
    }
  }

  Future<void> fetchAllCases() async {
    state = state.copyWith(isLoading: true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    // String? token = await SessionService.getToken();
    try {
      final response = await dio.get(Api.allCases,
          options: Options(headers: {'token': token}));
      GetAllCasesResponseModel responseModel =
          GetAllCasesResponseModel.fromJson(response.data);
      print(responseModel);
      // state = responseModel.items;
      // list = responseModel.items;
      state = state.copyWith(listData: responseModel.items);
      print(response.statusCode);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception(e);
      print(e);
    }
  }

  Future<void> fetchCibilReject() async {
    state = state.copyWith(isLoading: true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    // String? token = await SessionService.getToken();
    try {
      final response = await dio.get(Api.cibilReject,
          options: Options(headers: {'token': token}));
      GetAllCasesResponseModel responseModel =
          GetAllCasesResponseModel.fromJson(response.data);
      print(responseModel);
      state = state.copyWith(isLoading: false);
      // state = responseModel.items;
      state = state.copyWith(listData: responseModel.items);
      print(response.statusCode);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception(e);
      print(e);
    }
  }

  Future<void> fetchCibilOk() async {
    state = state.copyWith(isLoading: true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    // String? token = await SessionService.getToken();
    try {
      final response = await dio.get(Api.cibilOk,
          options: Options(headers: {'token': token}));
      GetAllCasesResponseModel responseModel =
          GetAllCasesResponseModel.fromJson(response.data);
      print(responseModel.items.first.customerName);
      // state = responseModel.items;
      state = state.copyWith(listData: responseModel.items);
      print(response.statusCode);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception(e);
      print(e);
    }
  }

  Future<void> fetchCibilPending() async {
    state = state.copyWith(isLoading: true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    // String? token = await SessionService.getToken();
    try {
      final response = await dio.get(Api.cibilPending,
          options: Options(headers: {'token': token}));
      GetAllCasesResponseModel responseModel =
          GetAllCasesResponseModel.fromJson(response.data);
      print(responseModel);

      // state = responseModel.items;
      state = state.copyWith(listData: responseModel.items);
      print(response.statusCode);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false);
      throw Exception(e);
    }
  }
}

class CaseModel {
  final List<Item> listData;
  final bool isLoading;

  CaseModel({this.listData = const [], this.isLoading = false});

  CaseModel copyWith({List<Item>? listData, bool? isLoading}) {
    return CaseModel(
        listData: listData ?? this.listData,
        isLoading: isLoading ?? this.isLoading);
  }
}

// final getAllData =  StateProvider<List<Item>>((ref) {
//   final dio = ref.watch(dioProvider);
//   Future<List<Item>> fetchAllCases() async {
//     // state=state.copyWith(isLoading: true);
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? token = sharedPreferences.getString('token');
//     // String? token = await SessionService.getToken();
//     try {
//       final response = await dio.get(Api.allCases,
//           options: Options(headers: {'token': token}));
//       GetAllCasesResponseModel responseModel =
//       GetAllCasesResponseModel.fromJson(response.data);
//       print(responseModel);
//       return responseModel.items;
//       // list = responseModel.items;
//       // state = state.copyWith(listData: responseModel.items);
//       print(response.statusCode);
//       // state=state.copyWith(isLoading: false);
//     } catch (e) {
//       // state=state.copyWith(isLoading: false);
//       throw Exception(e);
//       print(e);
//     }
//   }
//
// },);
// final getAllData =  StateProvider((ref) {
//
// },);
