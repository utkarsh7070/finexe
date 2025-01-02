import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../../../base/api/api.dart';
// import '../../../../../../../base/api/dio.dart';
// import '../../../../../../../base/service/session_service.dart';
import '../../../../../base/api/dio_exception.dart';
import '../model/Submit Data Models/police_station_model.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';


class PDPoliceModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDPoliceModel(this.dio) : super(ApplicantState());

  Future<bool> submitpdPoloiceForm({
    required String customerId,
    required String pdType,
    required BuildContext context,
    String? policeStaionname,
    String? policeStaionaddress,
  }) async {
    state = state.copyWith(isLoading: true);

    // Add customerId and pdType to the payload
    final payload = {
      "policeStation": {
        "staionName": policeStaionname,
        "stationAdress": policeStaionaddress
      },
      'customerId': customerId,
      'pdType': pdType,
    };
    // if(state.isLoading==true){
    //   print('click second time');
    //   return false;
    // }
    final token = speciality.getToken();
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));

      if (response.statusCode == 200) {
        PoliceStation policeDtata = PoliceStation.fromJson(response.data);

        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting applicant form');
        return false;
      }
    }
    catch (error) {
      print(error);
      state = state.copyWith(isLoading: false);
      DioExceptions.fromDioError(error as DioException, context);
      // Handle exceptions and set state to error
      // state = AsyncValue.error(error, stackTrace);
      print('response.data.message ${error}');
      return false;
    }
  }
}

final pdPoliceSubmitDataProvider =
    StateNotifierProvider<PDPoliceModel, ApplicantState>((ref) {
  final dio = ref.read(dioProvider);
  return PDPoliceModel(dio);
});

// ------------ Get api -------------
final policeDetailsProvider =
    FutureProvider.autoDispose.family<PoliceStationModel,String>((ref,customerId) async {
  // modal class name
  final viewModel = PoliceFormDetailsProvider(); //Class name
  return await viewModel.fetchPoliceDetails(customerId);
});

class PoliceFormDetailsProvider {
  final Dio _dio = Dio();

  Future<PoliceStationModel> fetchPoliceDetails(String customerId) async {
    final token = speciality.getToken();
    PoliceStationModel details = PoliceStationModel();
    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        // print('API Response: ${response.data}');
         details = PoliceStationModel.fromJson(response.data);

        if (details.items?.policeStation != null) {
          print('Parsed PoliceStation: ${details.items!.policeStation}');
          return details; // Return the parsed object
        } else {
          throw Exception(
              "Failed to load application data: ${response.statusCode}"); // Return null if no data found
        }
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error fetching applicant details: $e");
      // throw Exception("Error fetching application data: $e");
      return details;
    }
  }
}

// --------------- Common Loader
class ApplicantState {
  final bool? isLoading;

  ApplicantState({
    this.isLoading,
  });

  ApplicantState.initial() : isLoading = false;

  ApplicantState copyWith({
    bool? isLoading,
  }) {
    return ApplicantState(
      isLoading: isLoading ?? this.isLoading,
      // selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
