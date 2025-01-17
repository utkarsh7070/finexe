import 'dart:async';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/dio_exception.dart';
import '../model/Submit Data Models/pd_response_model.dart';

class PDPoliceModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDPoliceModel(this.dio) : super(ApplicantState());

  Future<void> UpdateInitialValue(PdResponseModel pdDetails) async =>
      state = state.copyWith(
          stationAddress: pdDetails.items?.policeStation?.stationAdress,
          stationName: pdDetails.items?.policeStation?.staionName);

  void updateStationName(String value) {
    final valid = _validString(value);
    state = state.copyWith(stationName: value, isStationName: valid);
  }

  void updateStationAddress(String value) {
    final valid = _validString(value);
    state = state.copyWith(stationAddress: value, isStationAddress: valid);
  }

  Future<bool> submitpdPoloiceForm({
    required String customerId,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);

    // Add customerId and pdType to the payload
    final payload = {
      "policeStation": {
        "staionName": state.stationName,
        "stationAdress": state.stationAddress
      },
      'customerId': customerId,
      'pdType': 'creditPd',
    };
    final token = speciality.getToken();
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));

      if (response.statusCode == 200) {
        // PoliceStation policeDtata = PoliceStation.fromJson(response.data);

        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting applicant form');
        return false;
      }
    } catch (error) {
      print(error);
      state = state.copyWith(isLoading: false);
      DioExceptions.fromDioError(error as DioException, context);
      // Handle exceptions and set state to error
      // state = AsyncValue.error(error, stackTrace);
      print('response.data.message $error');
      return false;
    }
  }
}

bool _validString(String val) {
  return val.isNotEmpty;
}

final pdPoliceSubmitDataProvider =
    StateNotifierProvider<PDPoliceModel, ApplicantState>((ref) {
  final dio = ref.read(dioProvider);
  return PDPoliceModel(dio);
});

// ------------ Get api -------------
// final policeDetailsProvider =
//     FutureProvider.autoDispose.family<PoliceStationModel,String>((ref,customerId) async {
//   // modal class name
//   final viewModel = PoliceFormDetailsProvider(); //Class name
//   return await viewModel.fetchPoliceDetails(customerId);
// });

final policeDetailsProvider = AsyncNotifierProvider.family<
    PoliceFormDetailsProvider, PdResponseModel, String>(
  () {
    return PoliceFormDetailsProvider();
  },
);

class PoliceFormDetailsProvider
    extends FamilyAsyncNotifier<PdResponseModel, String> {
  @override
  FutureOr<PdResponseModel> build(String arg) {
    final dio = ref.watch(dioProvider);
    final updateInitialData = ref.read(pdPoliceSubmitDataProvider.notifier);
    return fetchPoliceDetails(arg, dio, updateInitialData);
  }

  Future<PdResponseModel> fetchPoliceDetails(
      String customerId, Dio dio, PDPoliceModel pdPoliceModel) async {
    final token = speciality.getToken();
    PdResponseModel details = PdResponseModel();
    try {
      final response = await dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        details = PdResponseModel.fromJson(response.data);
        pdPoliceModel.UpdateInitialValue(details);
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
  final bool isLoading;
  final String stationName;
  final String stationAddress;
  final bool isStationName;
  final bool isStationAddress;

  ApplicantState({
    this.stationAddress = '',
    this.stationName = '',
    this.isLoading = false,
    this.isStationName = true,
    this.isStationAddress = true,
  });

  ApplicantState copyWith({
    bool? isLoading,
    bool? isStationName,
    bool? isStationAddress,
    String? stationName,
    String? stationAddress,
  }) {
    return ApplicantState(
      isStationAddress: isStationAddress ?? this.isStationAddress,
      isStationName: isStationName ?? this.isStationName,
      stationAddress: stationAddress ?? this.stationAddress,
      stationName: stationName ?? this.stationName,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
