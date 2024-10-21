import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/ui/Sales/NewLone/model/submit_new_loan_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../model/get_All_Product_model.dart';
import '../model/submit_new_loan_form_data.dart';

// final getAllProductsList = StateProvider<List<Item>?>((ref) {
//   return null;
// });

final itemList = StateProvider<Item?>((ref) {
  return Item(
      loanAmount: LoanAmount(min: 0, max: 0),
      roi: LoanAmount(min: 0, max: 0),
      tenure: LoanAmount(min: 0, max: 0),
      id: '0',
      productName: 'productName',
      loginFees: 0,
      status: 'status',
      createdAt: DateTime(000),
      updatedAt: DateTime(000),
      v: 0,
      permissionFormId: 'permissionFormId',
      productFinId: 'productFinId');
});

final newLoanFocusProvider =
    StateNotifierProvider<NewLoanFocusProvider, Map<String, bool>>((ref) {
  return NewLoanFocusProvider();
});

final personalDetailViewModelProvider =
    StateNotifierProvider<NewLoanViewModel, PhoneNumberState>((ref) {
  final dio = ref.read(dioProvider);

  return NewLoanViewModel(dio);
});

class NewLoanViewModel extends StateNotifier<PhoneNumberState> {
  final Dio dio;

  NewLoanViewModel(this.dio) : super(PhoneNumberState());
  final SingleValueDropDownController dropDownController =
      SingleValueDropDownController();

  @override
  void dispose() {
    dropDownController.dispose();
    super.dispose();
  }

  Future<bool> submitNewLoan(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    if (kDebugMode) {
      print('product ${id}');
    }
    print('loanAmount ${state.loanAmount}');
    print('emi ${state.emi}');

    final formData = LoanFormData(
        productId: id,
        mobileNo: state.phoneNumber,
        loanAmount: state.loanAmount.toString(),
        roi: state.roi.toString(),
        emi: state.emi.toString(),
        tenure: state.tenure.toString());
    FormData dioFormData = formData.toFormData();
    final response = await dio.post(Api.submitNewLoan,
        data: dioFormData, options: Options(headers: {'token': token}));
    print(response.statusMessage);
    print(response.statusCode);
    if (response.statusCode == 200) {
      SubmitNewLoanResponseModel submitNewLoanResponseModel =
          SubmitNewLoanResponseModel.fromJson(response.data);
      SessionService.customerIdSave(
          customerId: submitNewLoanResponseModel.items.id);
      return true;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void updateEmi() {
    double monthlyRate = state.roi / (12 * 100);
    double emi = (state.loanAmount *
            monthlyRate *
            (pow((1 + monthlyRate), state.tenure.toInt()))) /
        (pow((1 + monthlyRate), state.tenure.toInt()) - 1);
    String formattedNumber = emi.toStringAsFixed(1);
    final emiState = double.parse(formattedNumber);
    print(emi);
    state = state.copyWith(emi: emiState);
  }

  void updateLoanAmount(double newAmount) {
    state = state.copyWith(loanAmount: newAmount);
  }

  void updateInterestLone(double newAmount) {
    state = state.copyWith(roi: newAmount);
  }

  void updateTenureRate(double newAmount) {
    state = state.copyWith(tenure: newAmount);
  }

  void updatePhoneNumber(String value) {
    final isValid = _validatePhoneNumber(value);
    state = state.copyWith(phoneNumber: value, isPhoneNumberValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateProduct(String value) {
    // final isValid = _validatePhoneNumber(value);
    state = state.copyWith(
      product: value,
    );
    // copyWith(kycDocument: value, isKycValid: isValid);
  }
}

bool _validatePhoneNumber(String phone) {
  return phone.isNotEmpty && phone.length >= 9;
}

class NewLoanFocusProvider extends StateNotifier<Map<String, bool>> {
  final FocusNode phoneNumberFocusNode;
  final FocusNode productFocusNode;

  NewLoanFocusProvider()
      : phoneNumberFocusNode = FocusNode(),
        productFocusNode = FocusNode(),
        super({
          'phoneNumberFocusNode': false,
          'productFocusNode': false,
        }) {
    phoneNumberFocusNode.addListener(
      () => _focusListener('phoneNumberFocusNode', phoneNumberFocusNode),
    );
    productFocusNode.addListener(
        () => _focusListener('productFocusNode', productFocusNode));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    phoneNumberFocusNode.removeListener(
      () => _focusListener('phoneNumberFocusNode', phoneNumberFocusNode),
    );
    productFocusNode.removeListener(
        () => _focusListener('productFocusNode', productFocusNode));
    phoneNumberFocusNode.dispose();
    productFocusNode.dispose();
    super.dispose();
  }
}

class PhoneNumberState {
  final double emi;
  final double roi;
  final double tenure;
  final double loanAmount;
  final String product;
  final String phoneNumber;
  final bool isPhoneNumberValid;
  final bool isLoanAmountValid;

  PhoneNumberState({
    this.emi = 0.0,
    this.roi = 0.0,
    this.tenure = 0.0,
    this.loanAmount = 0.0,
    this.product = '',
    this.phoneNumber = '',
    this.isPhoneNumberValid = true,
    this.isLoanAmountValid = true,
  });

  PhoneNumberState copyWith(
      {double? emi,
      double? roi,
      String? phoneNumber,
      bool? isPhoneNumberValid,
      String? product,
      double? loanAmount,
      double? tenure}) {
    return PhoneNumberState(
      emi: emi ?? this.emi,
      roi: roi ?? this.roi,
      tenure: tenure ?? this.tenure,
      loanAmount: loanAmount ?? this.loanAmount,
      product: product ?? this.product,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
    );
  }
}

//-------------------------------Api--getAllProduct-------------------------------------------------

final fetchDataProvider = FutureProvider<List<Item>>((ref) async {
  final dio = ref.read(dioProvider);
  final response = await dio.get(Api.getAllProduct);
  print(response.statusMessage);
  print(response.statusCode);
  if (response.statusCode == 200) {
    GetAllProductModel apiResponseList =
        GetAllProductModel.fromJson(response.data);
    // ref.read(personalDetailViewModelProvider.notifier).list =
    //     apiResponseList.items;
    return apiResponseList.items;
  } else {
    throw Exception('Failed to load data');
  }
});

// class DataNotifier extends StateNotifier<AsyncValue<List<dynamic>>> {
//   final Dio dio;
//
//   DataNotifier(this.dio) : super(const AsyncValue.loading());
//
//   // Function to fetch data
//   Future<void> fetchData() async {
//     try {
//       state = const AsyncValue.loading();  // Set loading state
//       final response = await dio.get(Api.getAllProduct);
//       List<GetAllProductModel> apiResponseList = (response.data as List)
//           .map((item) => GetAllProductModel.fromJson(item))
//           .toList();  // Parse JSON into model
//
//       state = AsyncValue.data(apiResponseList);  // Set data state
//     } catch (error, stackTrace) {
//       state = AsyncValue.error(error, stackTrace);  // Set error state
//     }
//   }
// }
//
// final dataProvider = StateNotifierProvider<DataNotifier, AsyncValue<List<dynamic>>>((ref) {
//   final dio = ref.watch(dioProvider);  // Get Dio instance
//   return DataNotifier(dio);
// });
