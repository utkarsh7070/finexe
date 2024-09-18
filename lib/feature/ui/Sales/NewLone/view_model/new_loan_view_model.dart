import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newLoanFocusProvider =
    StateNotifierProvider<NewLoanFocusProvider, Map<String, bool>>((ref) {
  return NewLoanFocusProvider();
});

final personalDetailViewModelProvider =
    StateNotifierProvider<NewLoanViewModel, PhoneNumberState>(
        (ref) => NewLoanViewModel());

class NewLoanViewModel extends StateNotifier<PhoneNumberState> {
  NewLoanViewModel() : super(PhoneNumberState());

  void updatePhoneNumber(String value) {
    final isValid = _validatePhoneNumber(value);
    state = state.copyWith(phoneNumber: value, isPhoneNumberValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }
}

bool _validatePhoneNumber(String phone) {
  return phone.isNotEmpty && phone.length >= 10;
}

class NewLoanFocusProvider extends StateNotifier<Map<String, bool>> {
  final FocusNode aadhaarFocusNode;
  final FocusNode kycDocFocusNode;

  NewLoanFocusProvider()
      : aadhaarFocusNode = FocusNode(),
        kycDocFocusNode = FocusNode(),
        super({
          'aadhaarFocusNode': false,
          'kycDocFocusNode': false,
        }) {
    aadhaarFocusNode.addListener(
      () => _focusListener('aadhaarFocusNode', aadhaarFocusNode),
    );
    kycDocFocusNode
        .addListener(() => _focusListener('kycDocFocusNode', kycDocFocusNode));
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
      () => _focusListener('aadhaarFocusNode', aadhaarFocusNode),
    );
    kycDocFocusNode.removeListener(
        () => _focusListener('kycDocFocusNode', kycDocFocusNode));
    aadhaarFocusNode.dispose();
    kycDocFocusNode.dispose();
    super.dispose();
  }
}

class PhoneNumberState {
  final String phoneNumber;
  final bool isPhoneNumberValid;

  PhoneNumberState({
    this.phoneNumber = '',
    this.isPhoneNumberValid = true,
  });

  PhoneNumberState copyWith({String? phoneNumber, bool? isPhoneNumberValid}) {
    return PhoneNumberState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
    );
  }
}
