import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/widget/stepper_content.dart';

final stepperProvider = StateNotifierProvider<StepperViewModel, int>((ref) {
  return StepperViewModel();
});
class StepperViewModel extends StateNotifier<int> {
  StepperViewModel() : super(0);

  // Increment step
  void nextStep(int totalSteps) {
    if (state < totalSteps - 1) {
      state = state + 1;
    }
  }

  // Decrement step
  void previousStep() {
    if (state > 0) {
      state = state - 1;
    }
  }

  // Set the current step explicitly
  void setStep(int step) {
    state = step;
  }
}
final optionRoleProvider = StateNotifierProvider<OptionRoleNotifier, OptionRole>((ref) {
  return OptionRoleNotifier();
});

class OptionRoleNotifier extends StateNotifier<OptionRole> {
  OptionRoleNotifier() : super(OptionRole.NON); // Default value for the radio buttons

  // Method to update the selected value
  void select(OptionRole value) {
    state = value;
  }
}

class AadhaarFocusViewModel extends StateNotifier<Map<String, bool>> {
  final FocusNode aadhaarFocusNode;
  // final FocusNode passFocusNode;

  AadhaarFocusViewModel()
      : aadhaarFocusNode = FocusNode(),
        // passFocusNode = FocusNode(),
        super({
        'aadhaarFocusNode': false,
        // 'passFocusNode': false,
      }) {
    aadhaarFocusNode
        .addListener(() => _focusListener('aadhaarFocusNode', aadhaarFocusNode));
    // passFocusNode
    //     .addListener(() => _focusListener('passFocusNode', passFocusNode));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    aadhaarFocusNode
        .removeListener(() => _focusListener('aadhaarFocusNode', aadhaarFocusNode));
    // passFocusNode
    //     .removeListener(() => _focusListener('passFocusNode', passFocusNode));
    aadhaarFocusNode.dispose();
    // passFocusNode.dispose();
    super.dispose();
  }
}