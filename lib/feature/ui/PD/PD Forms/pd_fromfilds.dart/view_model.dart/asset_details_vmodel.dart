import 'dart:async';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/asset_detail_model.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/pd_response_model.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/dio_exception.dart';

class PDAssetDetails extends StateNotifier<AssetsApplicationState> {
  final Dio dio;

  PDAssetDetails(this.dio) : super(AssetsApplicationState());

  Future<void> UpdateInitialValue(PdResponseModel data) async {
    print(data.items?.assetDetails?.length);
    final List<AssetsDetailsModel> modifiableList = [];
    if (data.items?.assetDetails?.length != null) {
      for (int i = 0; i < data.items!.assetDetails!.length; i++) {
        if (kDebugMode) {
          print(data.items?.assetDetails?[i].purchaseValue);
        }
        modifiableList.add(AssetsDetailsModel(
          id: data.items?.assetDetails?[i].id ?? '',
          purchaseValue: data.items?.assetDetails?[i].purchaseValue ?? '',
          marketValue: data.items?.assetDetails?[i].marketValue ?? '',
          name: data.items?.assetDetails?[i].name ?? '',
        ));
      }
      state = state.copyWith(assetsList: modifiableList);
      calculateTotalPurchaseValue(modifiableList);
      calculateTotalMarketValue(modifiableList);
    }
  }

  int calculateTotalPurchaseValue(List<AssetsDetailsModel> assetsList) {
    int total = 0;
    for (var asset in assetsList) {
      final num = int.tryParse(asset.purchaseValue);
      print('num $num');
      total += num!;
      print(total);
      state = state.copyWith(totalPurchaseValue: total);
    }

    return total;
  }

  int calculateTotalMarketValue(List<AssetsDetailsModel> assetsList) {
    int total = 0;
    for (var asset in assetsList) {
      final num = int.tryParse(asset.marketValue);
      print('num $num');
      total += num!;
      print(total);
      state = state.copyWith(totalMarketValue: total);
    }

    return total;
  }

  void updateMarketValue(String value, int index) {
    state = state.copyWith(assetsList: [
      for (int i = 0; i < state.assetsList.length; i++)
        if (i == index)
          state.assetsList[i].copyWith(marketValue: value)
        else
          state.assetsList[i],
    ]);
  }

  void updateName(String value, int index) {
    state = state.copyWith(assetsList: [
      for (int i = 0; i < state.assetsList.length; i++)
        if (i == index)
          state.assetsList[i].copyWith(name: value)
        else
          state.assetsList[i],
    ]);
  }

  void updatePurchase(String value, int index) {
    state = state.copyWith(assetsList: [
      for (int i = 0; i < state.assetsList.length; i++)
        if (i == index)
          state.assetsList[i].copyWith(purchaseValue: value)
        else
          state.assetsList[i],
    ]);
    calculateTotalPurchaseValue(state.assetsList);
  }

  void updateMarket(String value, int index) {
    state = state.copyWith(assetsList: [
      for (int i = 0; i < state.assetsList.length; i++)
        if (i == index)
          state.assetsList[i].copyWith(marketValue: value)
        else
          state.assetsList[i],
    ]);
    calculateTotalMarketValue(state.assetsList);
  }

  void addAssets() {
    state =
        state.copyWith(assetsList: [...state.assetsList, AssetsDetailsModel()]);
  }

  void removeTodo(String todoId) {
    state = state.copyWith(assetsList: [
      for (final todo in state.assetsList)
        if (todo.id != todoId) todo,
    ]);
  }

  Future<bool> submitpdAssetDetailsForm(
      {required String customerId,
      required String pdType,
      required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    final payload = {
      'assetDetails': state.assetsList.toList(),
      'customerId': customerId,
      'pdType': pdType,
      "total": {
        "totalPurchaseValue": state.totalPurchaseValue,
        "totalMarketValue": state.totalMarketValue
      },
    };

    String? token = speciality.getToken();
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(token);
      print(payload);
      print(response.data);
      print('Payload: $payload');

      if (response.statusCode == 200) {
        final List<dynamic> assets = response.data['items']['assetDetails'];
        final List<AssetDetails> assetDetails =
            assets.map((e) => AssetDetails.fromJson(e)).toList();
        print('assetDetails form submitted: ${assetDetails.length}');

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
      print('response.data.message $error');
      return false;
    }
  }
}

final pdassetDetailsiewModelProvider =
    StateNotifierProvider<PDAssetDetails, AssetsApplicationState>((ref) {
  final dio = ref.read(dioProvider);
  return PDAssetDetails(dio);
});

class AssetsApplicationState {
  final bool isLoading;
  final List<AssetsDetailsModel> assetsList;
  final int totalMarketValue;
  final int totalPurchaseValue;

  AssetsApplicationState({
    this.isLoading = false,
    this.assetsList = const [],
    this.totalMarketValue = 0,
    this.totalPurchaseValue = 0,
  });

  AssetsApplicationState copyWith({
    bool? isLoading,
    List<AssetsDetailsModel>? assetsList,
    int? totalMarketValue,
    int? totalPurchaseValue,
  }) {
    return AssetsApplicationState(
      totalMarketValue: totalMarketValue ?? this.totalMarketValue,
      totalPurchaseValue: totalPurchaseValue ?? this.totalPurchaseValue,
      isLoading: isLoading ?? this.isLoading,
      assetsList: assetsList ?? this.assetsList,
    );
  }
}

final assetsDetailsProvider =
    AsyncNotifierProvider.family<AssetsInitialApiCall, PdResponseModel, String>(
  () {
    return AssetsInitialApiCall();
  },
);

class AssetsInitialApiCall
    extends FamilyAsyncNotifier<PdResponseModel, String> {
  @override
  FutureOr<PdResponseModel> build(String arg) {
    final dio = ref.watch(dioProvider);
    final assetsUpdateViewModel =
        ref.read(pdassetDetailsiewModelProvider.notifier);
    return fetchAssetDetails(arg, dio, assetsUpdateViewModel);
  }

  Future<PdResponseModel> fetchAssetDetails(
      String customerId, Dio dio, PDAssetDetails pdAssetViewModel) async {
    String? token = speciality.getToken();
    // final details = AssetFormModel.fromJson(responseData);
    PdResponseModel details = PdResponseModel();

    try {
      final response = await dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        details = PdResponseModel.fromJson(responseData);
        await pdAssetViewModel.UpdateInitialValue(details);
        if (details.items?.assetDetails != null) {
          return details;
        } else {
          // throw Exception("Asset details not found in the response.");
          print('Asset details not found in the response.');
          // return details;
          return details;
        }
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        // throw Exception("Resource not found. statusCode == 404", );
        print('Resource not found. statusCode == 404');
      }
      print("Error fetching Asset Details: $e");
      // throw Exception("An error occurred: ${e.toString()}");
      print('details:: ${details.items?.assetDetails}');
      return details;
    }
    return details;
  }
}

class AssetsDetailsModel {
  final String name;
  final String purchaseValue;
  final String marketValue;
  final String id;

  AssetsDetailsModel(
      {this.name = '',
      this.purchaseValue = '',
      this.marketValue = '',
      this.id = ''});

  AssetsDetailsModel copyWith({
    String? name,
    String? purchaseValue,
    String? marketValue,
    String? id,
  }) {
    return AssetsDetailsModel(
        id: id ?? this.id,
        purchaseValue: purchaseValue ?? this.purchaseValue,
        name: name ?? this.name,
        marketValue: marketValue ?? this.marketValue);
  }
}
