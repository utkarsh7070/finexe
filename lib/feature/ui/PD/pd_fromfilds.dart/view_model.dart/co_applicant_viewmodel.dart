import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FocusViewModel extends StateNotifier<Map<String, bool>> {
  final FocusNode coApplicantFocus;
  final FocusNode passFocusNode;

  FocusViewModel()
      : coApplicantFocus = FocusNode(),
        passFocusNode = FocusNode(),
        super({
          'coApplicantFocus': false,
          'passFocusNode': false,
        }) {
    coApplicantFocus.addListener(
        () => _focusListener('coApplicantFocus', coApplicantFocus));
    passFocusNode
        .addListener(() => _focusListener('passFocusNode', passFocusNode));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    coApplicantFocus.removeListener(
        () => _focusListener('userFocusNode', coApplicantFocus));
    passFocusNode
        .removeListener(() => _focusListener('passFocusNode', passFocusNode));
    coApplicantFocus.dispose();
    passFocusNode.dispose();
    super.dispose();
  }
}

final coappvalidation = StateNotifierProvider<CoAppValidation, bool>(
  (ref) {
    return CoAppValidation();
  },
);

class CoAppValidation extends StateNotifier<bool> {
  CoAppValidation() : super(false); // Default value for the radio buttons

  void checkUsername(value) {
    if (value == '' || value.isEmpty) {
      state = true;
      // return true;
    } else {
      state = false;
    }
  }
// Method to update the selected value
// void select(Role value) {
//   state = value;
// }
}
