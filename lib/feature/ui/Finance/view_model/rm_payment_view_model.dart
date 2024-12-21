import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/api/dio.dart';

final rmPaymentController =
StateNotifierProvider<FormDataControllerNotifier, FormDataController>(
      (ref) => FormDataControllerNotifier(),
);

class FormDataController {
  final TextEditingController selectedClaimType;

  bool isLoanNoValid;
  bool isloanAmountValid;
  bool isTehsilNameValid;

  List<String> selectedOptions;
  List<String> selectedVendorOptions;// Added branch selection

  List<String> lenderOption = [
    "fin cooper capital pvt itd",
    "grow capital pvt itd",
    "ratnaa fin capital pvt itd",
    "Namdev capital pvt itd",
  ];

  List<String> vendorOptions = [
    "Vendor 1",
    "Vendor 2",
    "Vendor 3",
    "Vendor 4",
  ];



  FormDataController({
    required this.selectedClaimType,
    this.isLoanNoValid = false,
    this.isloanAmountValid = false,
    this.isTehsilNameValid = false,
    List<String>? selectedOptions,
    List<String>? selectedVendorOptions,
    List<String>? selectedBranchOptions,  // Initialize the branchOptions
  })  : selectedOptions = selectedOptions ?? [],
        selectedVendorOptions = selectedVendorOptions ?? [];

  FormDataController copyWith({
    TextEditingController? selectedClaimType,
    bool? isLoanNoValid,
    bool? isloanAmountValid,
    bool? isTehsilNameValid,
    List<String>? selectedOptions,
    List<String>? selectedVendorOptions,
  }) {
    return FormDataController(
      selectedClaimType: selectedClaimType ?? this.selectedClaimType,
      isLoanNoValid: isLoanNoValid ?? this.isLoanNoValid,
      isloanAmountValid: isloanAmountValid ?? this.isloanAmountValid,
      isTehsilNameValid: isTehsilNameValid ?? this.isTehsilNameValid,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      selectedVendorOptions: selectedVendorOptions ?? this.selectedVendorOptions,
    );
  }

  void dispose() {
    selectedClaimType.dispose();
  }
}


class FormDataControllerNotifier extends StateNotifier<FormDataController> {
  FormDataControllerNotifier()
      : super(
    FormDataController(
      selectedClaimType: TextEditingController(),
    ),
  );

  void selectedClaimTypeController (String radioOption){
    state = state.copyWith(
    selectedClaimType: TextEditingController(text: radioOption),
    );
  }

  // void updateLoanNo(String value) {
  //   state = state.copyWith(
  //     paymentForm_loanNo: TextEditingController(text: value),
  //     isLoanNoValid: value.isNotEmpty,
  //   );
  // }

  // void updateLoanAmount(String value) {
  //   state = state.copyWith(
  //     paymentForm_loanAmount: TextEditingController(text: value),
  //     isloanAmountValid: value.isNotEmpty,
  //   );
  // }

  // void updateTehsilName(String value) {
  //   state = state.copyWith(
  //     paymentForm_TehsilName: TextEditingController(text: value),
  //     isTehsilNameValid: value.isNotEmpty,
  //   );
  // }

  void updateSelectedLenderOptions(List<String> newOptions) {
    state = state.copyWith(selectedOptions: newOptions);
  }

  void updateSelectedVendorOptions(List<String> newOptions) {
    state = state.copyWith(selectedVendorOptions: newOptions);
  }


  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

// ----- Add form loan start ------
final loanViewModelProvider =
StateNotifierProvider<PaymentLoanViewModel, List<LoanFormState>>((ref) {
  final dio = ref.watch(dioProvider);
  return PaymentLoanViewModel(dio);
});

class LoanFormState {
  final int id;
  final TextEditingController paymentForm_loanNo;
  final TextEditingController paymentForm_loanAmount;
  final TextEditingController paymentForm_TehsilName;
  String selectedBranchOptions; // Change to String instead of List<String>

  List<String> branchOptions = [
    "Indore",
    "Dewas",
    "Guna",
    "Ujjain",
    "Bhopal",
  ];

  LoanFormState({
    required this.id,
    required this.paymentForm_loanNo,
    required this.paymentForm_loanAmount,
    required this.paymentForm_TehsilName,
    this.selectedBranchOptions = '', // Default to an empty string
  });

  LoanFormState copyWith({
    TextEditingController? paymentForm_loanNo,
    TextEditingController? paymentForm_loanAmount,
    TextEditingController? paymentForm_TehsilName,
    String? selectedBranchOptions, // Update type to String
  }) {
    return LoanFormState(
      id: id,
      paymentForm_loanNo: paymentForm_loanNo ?? this.paymentForm_loanNo,
      paymentForm_loanAmount: paymentForm_loanAmount ?? this.paymentForm_loanAmount,
      paymentForm_TehsilName: paymentForm_TehsilName ?? this.paymentForm_TehsilName,
      selectedBranchOptions: selectedBranchOptions ?? this.selectedBranchOptions,
    );
  }

  void dispose() {
    paymentForm_loanNo.dispose();
    paymentForm_loanAmount.dispose();
    paymentForm_TehsilName.dispose();
  }

}

class PaymentLoanViewModel extends StateNotifier<List<LoanFormState>> {
  final Dio dio;

  PaymentLoanViewModel(this.dio)
      : super([
    LoanFormState(
      id: 0,
      paymentForm_loanNo: TextEditingController(),
      paymentForm_loanAmount: TextEditingController(),
      paymentForm_TehsilName: TextEditingController(),
      selectedBranchOptions: 'Indore', // Default selected branch
    ),
  ]);


  void addForm() {
    final newId = state.isEmpty ? 0 : state.last.id + 1;
    state = [
      ...state,
      LoanFormState(
        id: newId,
        paymentForm_loanNo: TextEditingController(),
        paymentForm_loanAmount: TextEditingController(),
        paymentForm_TehsilName: TextEditingController(),
        selectedBranchOptions: '',
      ),
    ];
  }

  // void removeItem(int id) {
  //   final formToRemove = state.firstWhere((form) => form.id == id);
  //   // formToRemove.dispose(); // Dispose controllers
  //   state = state.where((form) => form.id != id).toList();
  // }

  void removeItem(int id) {
    // Find the form to remove
    final formToRemove = state.firstWhere((form) => form.id == id );
      _disposeControllers(formToRemove);
    state = state.where((form) => form.id != id).toList();
  }


  void updateLoanField(String value, int id, String fieldName) {
    state = state.map((form) {
      if (form.id == id) {
        switch (fieldName) {
          case 'loanNo':
            form.paymentForm_loanNo.text = value; // Update text directly
            break;
          case 'loanAmount':
            form.paymentForm_loanAmount.text = value; // Update text directly
            break;
          case 'tehsilName':
            form.paymentForm_TehsilName.text = value; // Update text directly
            break;
          case 'branch': // Handle branch selection
            form.selectedBranchOptions = value; // Update selectedBranch for this form
            break;
        }
      }
      return form;
    }).toList();
  }


  void updateSelectedBranch(int formId, String branch) {
    state = state.map((form) {
      if (form.id == formId) {
        return form.copyWith(selectedBranchOptions: branch); // Update selectedBranch for this form
      }
      return form;
    }).toList();
  }

  Future<bool> validateForm(int index) async {
    final form = state.firstWhere((form) => form.id == index);
    final isLoanNoValid = form.paymentForm_loanNo.text.isNotEmpty;
    final isLoanAmountValid = form.paymentForm_loanAmount.text.isNotEmpty;
    final isTehsilNameValid = form.paymentForm_TehsilName.text.isNotEmpty;
    return isLoanNoValid && isLoanAmountValid && isTehsilNameValid;
  }

  @override
  void dispose() {
    for (final form in state) {
      _disposeControllers(form);
    }
    super.dispose();
  }

  void _disposeControllers(LoanFormState form) {
    form.paymentForm_loanNo.dispose();
    form.paymentForm_loanAmount.dispose();
    form.paymentForm_TehsilName.dispose();
  }
}


// ----- Add form loan start ------





