
import 'package:flutter/Material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/utils/widget/custom_snackbar.dart';

class CashfreePaymentState {
  final String status;
  final bool isLoading;
  final String? sessionId;
  final String? orderId;
  final String? error;


  CashfreePaymentState({
    required this.status,
    this.isLoading = false,
    this.sessionId,
    this.orderId,
    this.error,
  });

  CashfreePaymentState copyWith({
    String? status,
    bool? isLoading,
    String? sessionId,
    String? orderId,
    String? error,
  }) {
    return CashfreePaymentState(
      status: sessionId ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      sessionId: sessionId ?? this.sessionId,
      orderId: sessionId ?? this.orderId,
      error: error ?? this.error,
    );
  }
}

class CashfreePaymentNotifier extends StateNotifier<CashfreePaymentState> {


  final CFPaymentGatewayService _cfPaymentGatewayService = CFPaymentGatewayService();

  CashfreePaymentNotifier() : super(CashfreePaymentState(status: 'false')) {
    // Set up callbacks when the notifier is initialized
    _cfPaymentGatewayService.setCallback(_verifyPayment, _onError);
  }

  void _verifyPayment(String orderId) {
    print("Payment verified for Order ID: $orderId");
    state = state.copyWith(isLoading: false, orderId: orderId);
  }

  void _onError(CFErrorResponse errorResponse, String orderId) {
    print("Payment failed for Order ID: $orderId");
    print("Error: ${errorResponse.getMessage()}");
    state = state.copyWith(isLoading: false, error: errorResponse.getMessage());
  }
  Future<void> startPayment(String environment, String orderId, String paymentSessionId, BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // Create session
      var session = CFSessionBuilder()
          .setEnvironment(environment == 'PRODUCTION'
          ? CFEnvironment.PRODUCTION
          : CFEnvironment.SANDBOX)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();

      // Build payment request
      var cfWebCheckout = CFWebCheckoutPaymentBuilder().setSession(session).build();

      // Initiate payment
      _cfPaymentGatewayService.doPayment(cfWebCheckout);
    } on CFException catch (e) {
      print("Exception during payment: ${e.message}");
      state = state.copyWith(isLoading: false, error: e.message);
      showCustomSnackBar(context, e.message, Colors.red); // Handle error directly in UI
    }
  }
}



final cashfreePaymentProvider =
StateNotifierProvider<CashfreePaymentNotifier, CashfreePaymentState>(
      (ref) => CashfreePaymentNotifier(),
);




