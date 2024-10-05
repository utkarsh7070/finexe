import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../model/get_All_Product_model.dart';

// final dropdownValueProvider = StateProvider<String?>((ref) {
//
//   return null;
//   // Initial value is null (or you can set a default value)
// });
//
// final itemList = StateProvider<List<Item>?>((ref) {
//
//   return null;
//   // Initial value is null (or you can set a default value)
// });

final getAllProductsList =  StateProvider<List<Item>?>((ref) {
  return null;
  // Initial value is null (or you can set a default value)
});


final newLoanFocusProvider =
    StateNotifierProvider<NewLoanFocusProvider, Map<String, bool>>((ref) {
  return NewLoanFocusProvider();
});
final newLoanAmount =
StateNotifierProvider<LoneAmountSet, double>((ref) {
  return LoneAmountSet(0);
});

final newInterestRate =
StateNotifierProvider<InterestRate, double>((ref) {
  return InterestRate(0);
});

final newTenureRate =
StateNotifierProvider<TenureRate, double>((ref) {
  return TenureRate(0);
});

class LoneAmountSet extends StateNotifier<double>{
  LoneAmountSet(super.state);

  void updateLoanAmount(double newAmount) {
    state = newAmount;
  }
}
class InterestRate extends StateNotifier<double>{
  InterestRate(super.state);

  void updateInterestLone(double newAmount) {
    state = newAmount;
  }
}
class TenureRate extends StateNotifier<double>{
  TenureRate(super.state);

  void updateTenureRate(double newAmount) {
    state = newAmount;
  }
}
final personalDetailViewModelProvider =
    StateNotifierProvider<NewLoanViewModel, PhoneNumberState>(
        (ref) => NewLoanViewModel());

class NewLoanViewModel extends StateNotifier<PhoneNumberState> {
  NewLoanViewModel() : super(PhoneNumberState());
  final SingleValueDropDownController dropDownController = SingleValueDropDownController();

  // final getAllProduct = getAllProductsList.select((value) {
  //   value?.where((element) {
  //     return element.productName == dropDownController.dropDownValue?.name.toString();
  //   },);
  // },);


  @override
  void dispose() {
    dropDownController.dispose();
    super.dispose();
  }




  void updatePhoneNumber(String value) {
    final isValid = _validatePhoneNumber(value);
    state = state.copyWith(phoneNumber: value, isPhoneNumberValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateProduct(String value) {
    // final isValid = _validatePhoneNumber(value);
    state = state.copyWith(product: value,);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

}

bool _validatePhoneNumber(String phone) {
  return phone.isNotEmpty && phone.length >= 10;
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
    productFocusNode
        .addListener(() => _focusListener('productFocusNode', productFocusNode));
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
  final String tenure;
  final String loanAmount;
  final String product;
  final String phoneNumber;
  final bool isPhoneNumberValid;
  final bool isLoanAmountValid;

  PhoneNumberState({
    this.tenure='',
    this.loanAmount='',
    this.product='',
    this.phoneNumber = '',
    this.isPhoneNumberValid = true,
    this.isLoanAmountValid = true,
  });

  PhoneNumberState copyWith({String? phoneNumber, bool? isPhoneNumberValid,String? product,String? loanAmount,String? tenure}) {
    return PhoneNumberState(
      tenure: tenure?? this.tenure,
      loanAmount: loanAmount??this.loanAmount,
      product: product?? this.product,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
    );
  }
}

//-------------------------------Api--getAllProduct-------------------------------------------------


final fetchDataProvider = FutureProvider<GetAllProductModel>((ref) async {
  final dio = ref.read(dioProvider);
  final response = await dio.get(Api.getAllProduct);
  GetAllProductModel apiResponseList = GetAllProductModel.fromJson(response.data);
  print(response.statusMessage);
  print(response.statusCode);
  if (response.statusCode == 200) {
    ref.read(getAllProductsList.notifier).state= apiResponseList.items;
    return apiResponseList;
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
