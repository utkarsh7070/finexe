import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/model/Aadhaar_Model/aadhaar_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view/Personal Details/view/personal_details.dart';
import '../view/widget/stepper_content.dart';

final checkBoxTermsCondition = StateProvider(
  (ref) {
    return false;
  },
);
final stepperProvider = StateNotifierProvider<StepperViewModel, int>((ref) {
  return StepperViewModel();
});
// class TermsConditionCheckboxViewModel extends StateNotifier<bool> {
//   TermsConditionCheckboxViewModel() : super(false);
//
//   void changeValue(bool value) {
//     if (value) {
//       state = false;
//     } else {
//       state = true;
//     }
//   }
// }

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

final optionRoleProvider =
    StateNotifierProvider<OptionRoleNotifier, OptionRole>((ref) {
  return OptionRoleNotifier();
});

class OptionRoleNotifier extends StateNotifier<OptionRole> {
  OptionRoleNotifier()
      : super(OptionRole.NON); // Default value for the radio buttons

  // Method to update the selected value
  void select(OptionRole value,int index) {
    state= value;
  }
}

final aadhaarFocusProvider =
    StateNotifierProvider<AadhaarFocusViewModel, Map<String, bool>>((ref) {
  return AadhaarFocusViewModel();
});

class AadhaarFocusViewModel extends StateNotifier<Map<String, bool>> {
  final FocusNode aadhaarFocusNode;

  AadhaarFocusViewModel()
      : aadhaarFocusNode = FocusNode(),
        super({
          'aadhaarFocusNode': false,
        }) {
    aadhaarFocusNode.addListener(
        () => _focusListener('aadhaarFocusNode', aadhaarFocusNode));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    aadhaarFocusNode.removeListener(
        () => _focusListener('aadhaarFocusNode', aadhaarFocusNode));
    aadhaarFocusNode.dispose();
    super.dispose();
  }
}

// Provider for form state and validation
final formViewModelProvider =
    StateNotifierProvider<FormViewModel, AadhaarFormState>(
        (ref) => FormViewModel());

class FormViewModel extends StateNotifier<AadhaarFormState> {
  FormViewModel() : super(const AadhaarFormState());

  // Update email field
  void updateAadhaar(String value) {
    final isValid = _validateAadhaar(value);
    state = state.copyWith(aadhaar: value, isAadhaarValid: isValid);
  }

  // Update password field
  // void updatePassword(String value) {
  //   final isValid = _validatePassword(value);
  //   state = state.copyWith(password: value, isPasswordValid: isValid);
  // }

  // Validate the form
  bool validateForm() {
    final isAadhaarValid = _validateAadhaar(state.aadhaar);
    // final isPasswordValid = _validatePassword(state.password);
    state = state.copyWith(
      isAadhaarValid: isAadhaarValid,
      // isPasswordValid: isPasswordValid
    );
    return isAadhaarValid;
    // && isPasswordValid;
  }

  // Email validation logic
  bool _validateAadhaar(String aadhaar) {
    return aadhaar.length >= 12 && aadhaar.isEmpty;
  }

// Password validation logic
// bool _validatePassword(String password) {
//   return password.length >= 6;
// }
}

class AadhaarFormState {
  final String aadhaar;

  // final String password;
  final bool isAadhaarValid;

  // final bool isPasswordValid;

  const AadhaarFormState({
    this.aadhaar = '',
    // this.password = '',
    this.isAadhaarValid = true,
    // this.isPasswordValid = true,
  });

  AadhaarFormState copyWith({
    String? aadhaar,
    // String? password,
    bool? isAadhaarValid,
    // bool? isPasswordValid,
  }) {
    return AadhaarFormState(
      aadhaar: aadhaar ?? this.aadhaar,
      // password: password ?? this.password,
      isAadhaarValid: isAadhaarValid ?? this.isAadhaarValid,
      // isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }
}

// // // ViewModel to manage the text field values and validation
// // class TextFieldsViewModel extends StateNotifier<List<TextFieldModel>> {
// //   TextFieldsViewModel() : super(List.generate(10, (_) => TextFieldModel(value: '')));
// //
// //   void updateFieldValue(int index, String newValue) {
// //     state = [
// //       for (int i = 0; i < state.length; i++)
// //         if (i == index)
// //           TextFieldModel(
// //             value: newValue,
// //             isValid: validate(newValue),
// //             errorMessage: validate(newValue) ? null : "Field cannot be empty",
// //           )
// //         else
// //           state[i]
// //     ];
// //   }
// //
// //   bool validate(String value) {
// //     return value.isNotEmpty; // Example validation: non-empty field
// //   }
// //
// //   bool validateAll() {
// //     bool isValid = true;
// //     state = [
// //       for (final field in state)
// //         if (field.value.isEmpty)
// //           TextFieldModel(
// //             value: field.value,
// //             isValid: false,
// //             errorMessage: "Field cannot be empty",
// //           )
// //         else
// //           field
// //     ];
// //
// //     for (final field in state) {
// //       if (!field.isValid) {
// //         isValid = false;
// //         break;
// //       }
// //     }
// //     return isValid;
// //   }
// // }
// //
// // // Riverpod provider
// // final textFieldsProvider = StateNotifierProvider<TextFieldsViewModel, List<TextFieldModel>>((ref) {
// //   return TextFieldsViewModel();
// // });



