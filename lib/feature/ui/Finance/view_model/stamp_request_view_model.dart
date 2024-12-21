import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for FormDataControllerNotifier
final stampControllerProvider = StateNotifierProvider<FormDataControllerNotifier, FormDataController>(
      (ref) {
    return FormDataControllerNotifier();

  },
);

/// Main FormDataController class
class FormDataController {
  final List<String> lenderOptions;
  final List<String> vendorOptions;
  final List<String> denominator;
  final List<String> quantity;
  final List<TextEditingController> loanNoControllers;
  final FocusNode paymentFormLoanNoFocusNode;

  // Properties to store selected options
  final List<String> selectedLenderOptions;
  final List<String> selectedVendorOptions;
  final List<String> selectedDenominatorOptions;
  final List<String> selectedQuantityOptions;

  FormDataController({
    required this.lenderOptions,
    required this.vendorOptions,
    required this.denominator,
    required this.quantity,
    required this.loanNoControllers,
    required this.paymentFormLoanNoFocusNode,
    this.selectedLenderOptions = const [],
    this.selectedVendorOptions = const [],
    this.selectedDenominatorOptions = const [],
    this.selectedQuantityOptions = const [],
  });

  /// A method to return a modified copy of the current state
  FormDataController copyWith({
    List<String>? lenderOptions = const [ "fin cooper capital pvt ltd",
      "grow capital pvt ltd",
      "ratnaa fin capital pvt ltd",
      "Namdev capital pvt ltd"],
    List<String>? vendorOptions = const ["API Vendor 1",
      "API Vendor 2",
      "API Vendor 3",],
    List<String>? denominator = const  ["100", "1000", "2000", "500"],
    List<String>? quantity  = const ["1", "2", "3", "Other"],
    List<String>? selectedLenderOptions,
    List<String>? selectedVendorOptions,
    List<String>? selectedDenominatorOptions,
    List<String>? selectedQuantityOptions,
    List<TextEditingController>? loanNoControllers,
    FocusNode? paymentFormLoanNoFocusNode,
  }) {
    return FormDataController(
      lenderOptions: lenderOptions ?? this.lenderOptions,
      vendorOptions: vendorOptions ?? this.vendorOptions,
      denominator: denominator ?? this.denominator,
      quantity: quantity ?? this.quantity,
      selectedLenderOptions: selectedLenderOptions ?? this.selectedLenderOptions,
      selectedVendorOptions: selectedVendorOptions ?? this.selectedVendorOptions,
      selectedDenominatorOptions: selectedDenominatorOptions ?? this.selectedDenominatorOptions,
      selectedQuantityOptions: selectedQuantityOptions ?? this.selectedQuantityOptions,
      loanNoControllers: loanNoControllers ?? this.loanNoControllers,
      paymentFormLoanNoFocusNode:
      paymentFormLoanNoFocusNode ?? this.paymentFormLoanNoFocusNode,
    );
  }
}

/// State Notifier to manage state changes
class FormDataControllerNotifier extends StateNotifier<FormDataController> {
  FormDataControllerNotifier() : super(FormDataController(
    lenderOptions: ["fin cooper capital pvt ltd", "grow capital pvt ltd", "ratnaa fin capital pvt ltd", "Namdev capital pvt ltd"],
    vendorOptions: ["API Vendor 1", "API Vendor 2", "API Vendor 3"],
    denominator: ["100", "1000", "2000", "500"],
    quantity: ["1", "2", "3", "Other"],
    loanNoControllers: [TextEditingController()], // Initialize with one controller
    paymentFormLoanNoFocusNode: FocusNode(),
  ));



  // Method to fetch and initialize data from the API
  Future<void> initializeWithApiData() async {
    try {
      final apiData = await fetchApiData(); // Fetch data from the API
      state = state.copyWith(
        lenderOptions: apiData['lenderOptions'] ?? [],
        vendorOptions: apiData['vendorOptions'] ?? [],
        denominator: apiData['denominator'] ?? [],
        quantity: apiData['quantity'] ?? [],
      );
    } catch (e) {
      debugPrint('Error fetching API data: $e');
    }
  }
  // ------- just for demo get api
  Future<Map<String, List<String>>> fetchApiData() async {
    // Replace this with your actual API call logic
    await Future.delayed(const Duration(seconds: 2)); // Simulate API delay
    return {
      "lenderOptions": [
        "fin cooper capital pvt ltd",
        "grow capital pvt ltd",
        "ratnaa fin capital pvt ltd",
        "Namdev capital pvt ltd",
      ],
      "vendorOptions": [
        "API Vendor 1",
        "API Vendor 2",
        "API Vendor 3",
      ],
      "denominator": ["100", "1000", "2000", "500"],
      "quantity": ["1", "2", "3", "Other"],
    };
  }

  // Add a new loan number field
  void addLoanNoField() {
    final updatedControllers = List<TextEditingController>.from(state.loanNoControllers)
      ..add(TextEditingController());
    state = state.copyWith(loanNoControllers: updatedControllers);
  }



  // Remove a loan number field by index
  void removeLoanNoField(int index) {
    if (index >= 0 && index < state.loanNoControllers.length) {
      state.loanNoControllers[index].dispose();
      final updatedControllers = List<TextEditingController>.from(state.loanNoControllers)
        ..removeAt(index);

      state = state.copyWith(loanNoControllers: updatedControllers);
    }
  }

  // Update loan field value by index
  void updateLoanField(String value, int index) {
    if (index >= 0 && index < state.loanNoControllers.length) {
      state.loanNoControllers[index].text = value;
    }
  }

  // Update selected lender options
  void updateSelectedLenderOptions(String option, int index) {
    final updatedSelectedLenderOptions = List<String>.from(state.selectedLenderOptions);
    if (index < updatedSelectedLenderOptions.length) {
      updatedSelectedLenderOptions[index] = option;
    } else {
      updatedSelectedLenderOptions.add(option);
    }
    state = state.copyWith(selectedLenderOptions: updatedSelectedLenderOptions);
  }

  // Update selected vendor options
  void updateSelectedVendorOptions(String option, int index) {
    final updatedSelectedVendorOptions = List<String>.from(state.selectedVendorOptions);
    if (index < updatedSelectedVendorOptions.length) {
      updatedSelectedVendorOptions[index] = option;
    } else {
      updatedSelectedVendorOptions.add(option);
    }
    state = state.copyWith(selectedVendorOptions: updatedSelectedVendorOptions);
  }

  // Update selected denominator options
  void updateSelectedDenominatorOptions(String option, int index) {
    final updatedSelectedDenominatorOptions = List<String>.from(state.selectedDenominatorOptions);
    if (index < updatedSelectedDenominatorOptions.length) {
      updatedSelectedDenominatorOptions[index] = option;
    } else {
      updatedSelectedDenominatorOptions.add(option);
    }
    state = state.copyWith(selectedDenominatorOptions: updatedSelectedDenominatorOptions);
  }

  // Update selected quantity options
  void updateSelectedQuantityOptions(String option, int index) {
    final updatedSelectedQuantityOptions = List<String>.from(state.selectedQuantityOptions);
    if (index < updatedSelectedQuantityOptions.length) {
      updatedSelectedQuantityOptions[index] = option;
    } else {
      updatedSelectedQuantityOptions.add(option);
    }
    state = state.copyWith(selectedQuantityOptions: updatedSelectedQuantityOptions);
  }

  @override
  void dispose() {
    for (var controller in state.loanNoControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
