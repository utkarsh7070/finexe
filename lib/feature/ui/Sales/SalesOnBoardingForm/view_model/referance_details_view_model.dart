import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

final paymentProvider = StateNotifierProvider<PaymentWithRazorPay, PaymentState>((ref) {
  return PaymentWithRazorPay();
});

class PaymentWithRazorPay extends StateNotifier<PaymentState>{
  final Razorpay _razorpay = Razorpay();

  PaymentWithRazorPay():super(PaymentState(status:'initial')){
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void payWithRazorPay(int double){
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': 3000,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      state = PaymentState(status: 'error', errorMessage: e.toString());
    }
  }

  // Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    state = PaymentState(status: 'success', transactionId: response.paymentId);
  }

// Handle payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    state = PaymentState(status: 'error', errorMessage: response.message);
  }

// Handle external wallet selection
  void _handleExternalWallet(ExternalWalletResponse response) {
    state = PaymentState(status: 'external_wallet', transactionId: response.walletName);
  }

}


final referenceFocusProvider =
    StateNotifierProvider<ReferenceFocusProvider, Map<String, bool>>((ref) {
  return ReferenceFocusProvider();
});

final referenceViewModelProvider =
    StateNotifierProvider<ReferenceViewModel, ReferenceState>(
        (ref) => ReferenceViewModel());


class ReferenceViewModel extends StateNotifier<ReferenceState> {
  ReferenceViewModel() : super(ReferenceState());

  void updateReferenceName(String value) {
    final isValid = _validateReferenceName(value);
    state = state.copyWith(referenceName: value, isReferenceNameValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateRelationWithApplicant(String value) {
    final isValid = _validateRelationWithApplicant(value);
    state = state.copyWith(
        relationWithApplicant: value, isRelationWithApplicantValid: isValid);
  }

  void updateAddress(String value) {
    final isValid = _validateAddress(value);
    state = state.copyWith(address: value, isAddressValid: isValid);
  }

  void updateContact(String value) {
    final isValid = _validateContact(value);
    state = state.copyWith(contact: value, isContactValid: isValid);
  }

  void updateReferenceName2(String value) {
    final isValid = _validateReferenceName2(value);
    state =
        state.copyWith(referenceName2: value, isReferenceName2Valid: isValid);
  }

  void updateRelationWithApplicant2(String value) {
    final isValid = _validateRelationWithApplicant2(value);
    state = state.copyWith(
        relationWithApplicant2: value, isRelationWithApplicant2Valid: isValid);
  }

  void updateAddress2(String value) {
    final isValid = _validateAddress2(value);
    state = state.copyWith(address2: value, isAddress2Valid: isValid);
  }

  void updateContact2(String value) {
    final isValid = _validateContact2(value);
    state = state.copyWith(contact2: value, isContact2Valid: isValid);
  }
}

bool _validateContact2(String contact2) {
  return contact2.isNotEmpty;
}

bool _validateAddress2(String address2) {
  return address2.isNotEmpty;
}

bool _validateRelationWithApplicant2(String relationWithApplicant) {
  return relationWithApplicant.isNotEmpty;
}

bool _validateReferenceName2(String state) {
  return state.isNotEmpty;
}

bool _validateContact(String district) {
  return district.isNotEmpty;
}

bool _validateAddress(String pinCode) {
  return pinCode.isNotEmpty;
}

bool _validateRelationWithApplicant(String relationWithApplicant) {
  return relationWithApplicant.isNotEmpty;
}

bool _validateReferenceName(String state) {
  return state.isNotEmpty;
}

class ReferenceState {
  final String referenceName;
  final String relationWithApplicant;
  final String address;
  final String contact;
  final String referenceName2;
  final String relationWithApplicant2;
  final String address2;
  final String contact2;

  final bool isReferenceNameValid;
  final bool isRelationWithApplicantValid;
  final bool isAddressValid;
  final bool isContactValid;
  final bool isReferenceName2Valid;
  final bool isRelationWithApplicant2Valid;
  final bool isAddress2Valid;
  final bool isContact2Valid;

  ReferenceState(
      {this.referenceName = '',
      this.relationWithApplicant = '',
      this.address = '',
      this.contact = '',
      this.referenceName2 = '',
      this.relationWithApplicant2 = '',
      this.address2 = '',
      this.contact2 = '',
      this.isReferenceNameValid = true,
      this.isRelationWithApplicantValid = true,
      this.isAddressValid = true,
      this.isContactValid = true,
      this.isReferenceName2Valid = true,
      this.isRelationWithApplicant2Valid = true,
      this.isAddress2Valid = true,
      this.isContact2Valid = true});

  ReferenceState copyWith({
    String? referenceName,
    String? relationWithApplicant,
    String? address,
    String? contact,
    String? referenceName2,
    String? relationWithApplicant2,
    String? address2,
    String? contact2,
    bool? isReferenceNameValid,
    bool? isRelationWithApplicantValid,
    bool? isAddressValid,
    bool? isContactValid,
    bool? isReferenceName2Valid,
    bool? isRelationWithApplicant2Valid,
    bool? isAddress2Valid,
    bool? isContact2Valid,
  }) {
    return ReferenceState(
      referenceName: referenceName ?? this.referenceName,
      relationWithApplicant:
          relationWithApplicant ?? this.relationWithApplicant,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      referenceName2: referenceName2 ?? this.referenceName2,
      relationWithApplicant2:
          relationWithApplicant2 ?? this.relationWithApplicant2,
      address2: address2 ?? this.address2,
      contact2: contact2 ?? this.contact2,
      isReferenceNameValid: isReferenceNameValid ?? this.isReferenceNameValid,
      isRelationWithApplicantValid:
          isRelationWithApplicantValid ?? this.isRelationWithApplicantValid,
      isAddressValid: isAddressValid ?? this.isAddressValid,
      isContactValid: isContactValid ?? this.isContactValid,
      isReferenceName2Valid:
          isReferenceName2Valid ?? this.isReferenceName2Valid,
      isRelationWithApplicant2Valid:
          isRelationWithApplicant2Valid ?? this.isRelationWithApplicant2Valid,
      isAddress2Valid: isAddress2Valid ?? this.isAddress2Valid,
      isContact2Valid: isContact2Valid ?? this.isContact2Valid,
    );
  }
}

class ReferenceFocusProvider extends StateNotifier<Map<String, bool>> {
  final FocusNode referenceName;
  final FocusNode relationWithApplicant;
  final FocusNode address;
  final FocusNode contact;
  final FocusNode referenceName2;
  final FocusNode relationWithApplicant2;
  final FocusNode address2;
  final FocusNode contact2;

  ReferenceFocusProvider()
      : referenceName = FocusNode(),
        relationWithApplicant = FocusNode(),
        address = FocusNode(),
        contact = FocusNode(),
        referenceName2 = FocusNode(),
        relationWithApplicant2 = FocusNode(),
        address2 = FocusNode(),
        contact2 = FocusNode(),
        super({
          'referenceName': false,
          'relationWithApplicant': false,
          'address': false,
          'contact': false,
          'referenceName2': false,
          'relationWithApplicant2': false,
          'address2': false,
          'contact2': false,
        }) {
    referenceName.addListener(
      () => _focusListener('referenceName', referenceName),
    );
    relationWithApplicant.addListener(
        () => _focusListener('relationWithApplicant', relationWithApplicant));
    address.addListener(() => _focusListener('address', address));
    contact.addListener(() => _focusListener('contact', contact));
    referenceName2
        .addListener(() => _focusListener('referenceName2', referenceName2));
    relationWithApplicant2.addListener(
        () => _focusListener('relationWithApplicant2', relationWithApplicant2));
    address2.addListener(() => _focusListener('address2', address2));
    contact2.addListener(() => _focusListener('contact2', contact2));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    referenceName.removeListener(
      () => _focusListener('referenceName', referenceName),
    );
    relationWithApplicant.removeListener(
        () => _focusListener('relationWithApplicant', relationWithApplicant));
    address.removeListener(() => _focusListener('address', address));
    contact.removeListener(() => _focusListener('contact', contact));
    referenceName2
        .removeListener(() => _focusListener('referenceName2', referenceName2));
    relationWithApplicant2.removeListener(
        () => _focusListener('relationWithApplicant2', relationWithApplicant2));
    address2.removeListener(() => _focusListener('address2', address2));
    contact2.removeListener(() => _focusListener('contact2', contact2));
    referenceName.dispose();
    relationWithApplicant.dispose();
    address.dispose();
    contact.dispose();
    referenceName2.dispose();
    relationWithApplicant2.dispose();
    address2.dispose();
    contact2.dispose();
    super.dispose();
  }
}
class PaymentState {
  final String status;
  final String? transactionId;
  final String? errorMessage;

  PaymentState({
    required this.status,
    this.transactionId,
    this.errorMessage,
  });
}

