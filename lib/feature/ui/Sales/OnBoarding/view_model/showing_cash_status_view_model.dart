
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/model/payment_initiate_cashfree_response_model.dart';
import 'package:flutter/Material.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/utils/widget/custom_snackbar.dart';
import '../../SalesOnBoardingForm/model/payment_initiate_response_model.dart';
import '../../SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/dialog/form_completed_dialog.dart';
import '../model/show_cashes_status_model.dart';


class ProcessStatusNotifier extends StateNotifier<AsyncValue<ProcessStatusResponse?>> {
  ProcessStatusNotifier() : super(const AsyncValue.loading());

  final Dio _dio = Dio();


  Future<PaymentInitiateResponseModel> paymentInitiate2(String customerId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    // final customerId = sharedPreferences.getString('customerId');
    final requestData = {'customerId': customerId.toString()};
    if (kDebugMode) {
      print(customerId);
      print(token);
    }

    print('Input requestData ${requestData.toString()}');

    final response = await _dio.post(Api.paymentAmount,
        data: requestData, options: Options(headers: {'token': token}));
    PaymentInitiateResponseModel responseModel =
    PaymentInitiateResponseModel.fromJson(response.data);
    if (kDebugMode) {
      print(response.data);
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return responseModel;
    } else {
      throw Exception('Failed to load data');
    }
  }

  /*Future<PaymentInitiateCashFreeResponseModel> cashFreePaymentInitiate(String customerId, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final requestData = {'customerId': customerId.toString()};

    if (kDebugMode) {
      print(customerId);
      print(token);
    }

    print('Input requestData ${requestData.toString()}');

    try {
      final response = await _dio.post(
        Api.cashfreePaymentAmount,
        *//*'https://prod.fincooper.in/v1/salesMan/CashFreePaymentInitiate',*//*
        data: requestData,

        options: Options(headers: {'token': token},validateStatus: (status) => true,),
      );

      if (kDebugMode) {
        print(response.data);
        print(response.statusCode);
      }

      final responseMessage=response.data['message'];
      print('response message cashfree ${responseMessage}');

      if (response.statusCode == 200) {
        return PaymentInitiateCashFreeResponseModel.fromJson(response.data);
      } else if(response.statusCode == 400){
        showCustomSnackBar(context, responseMessage, Colors.red);
        throw Exception('Bad Request: $responseMessage');
      }
      else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          // Handle 400 response
          final errorMessage = e.response?.data['message'] ?? 'Bad Request';
          print("400 Error: $errorMessage");
          showCustomSnackBar(context, errorMessage, Colors.red);
        }
        else if (e.response?.statusCode == 500) {
          // Handle 400 response
          final errorMessage = e.response?.data['message'] ?? 'Bad Request';
          print("500 Error: $errorMessage");
          showCustomSnackBar(context, errorMessage, Colors.red);
        }else {
          // Handle other Dio errors
          print("DioError: ${e.message}");
          showCustomSnackBar(
              context, "Something went wrong. Please try again.", Colors.red);
        }
      } else {
        // Handle non-Dio errors
        print("Error submitting form: $e");
        showCustomSnackBar(
            context, "An unexpected error occurred.", Colors.red);
      }

      // Rethrow or return a default value to satisfy return type
      throw Exception("Error in API call, unable to return data.");
    }
  }
*/

  Future<PaymentInitiateCashFreeResponseModel> cashFreePaymentInitiate(
      String customerId, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final requestData = {'customerId': customerId.toString()};

    if (kDebugMode) {
      print(customerId);
      print(token);
    }

    print('Input requestData ${requestData.toString()}');

    try {
      final response = await _dio.post(
        Api.cashfreePaymentAmount,
        data: requestData,
        options: Options(
          headers: {'token': token},
          validateStatus: (status) => true,
        ),
      );

      if (kDebugMode) {
        print(response.data);
        print(response.statusCode);
      }

      final responseMessage = response.data['message'] ?? 'Something went wrong';
      print('response message cashfree $responseMessage');

      if (response.statusCode == 200) {
        return PaymentInitiateCashFreeResponseModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        // Show Snackbar and return early
        showCustomSnackBar(context, responseMessage, Colors.red);
        return Future.error(Exception('Bad Request: $responseMessage'));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          final errorMessage = e.response?.data['message'] ?? 'Bad Request';
          print("400 Error: $errorMessage");
          showCustomSnackBar(context, errorMessage, Colors.red);
        } else if (e.response?.statusCode == 500) {
          final errorMessage = e.response?.data['message'] ?? 'Internal Server Error';
          print("500 Error: $errorMessage");
          showCustomSnackBar(context, errorMessage, Colors.red);
        } else {
          print("DioError: ${e.message}");
          showCustomSnackBar(
              context, "Something went wrong. Please try again.", Colors.red);
        }
      } else {
        print("Error submitting form: $e");
        showCustomSnackBar(context, "An unexpected error occurred.", Colors.red);
      }

      // Throw an exception to indicate failure
      throw Exception("Error in API call, unable to return data.");
    }
  }


  Future<void> fetchProcessStatus(String customerId) async {
    try {
      // Fetch the token (assuming you have a session service for this)
      String? token = speciality.getToken();

      // Make the API call using Dio
      final response = await _dio.get(
        Api.getCaseStatus,
        queryParameters: {'customerId': customerId},
        options: Options(headers: {"token": token}),
      );

      print('Case status response: ${response.data}');

      // Check for a successful response
      if (response.statusCode == 200 && response.data != null) {
        // Parse the data into your ProcessStatusResponse model
        final data = ProcessStatusResponse.fromJson(response.data);
        print('Parsed Data: ${data.toJson()}'); // Add this line
        // Update the state with the parsed data
        state = AsyncValue.data(data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e, stackTrace) {
      // Handle errors and update the state
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final processStatusProvider = StateNotifierProvider<ProcessStatusNotifier, AsyncValue<ProcessStatusResponse?>>(
      (ref) => ProcessStatusNotifier(),
);


/*
class ProcessStatusNotifier extends StateNotifier<AsyncValue<ProcessStatusResponse?>> {
  ProcessStatusNotifier() : super(const AsyncValue.loading());

  final Dio _dio = Dio();

  Future<void> fetchProcessStatus(String customerId) async {
    try {
      // Replace with your actual API call
<<<<<<< HEAD
      String? token = await SessionService.getToken();
=======
      String? token = speciality.getToken();
>>>>>>> origin/To_merge
      // Example using Dio
      final response = await _dio.get(Api.getCaseStatus,
          queryParameters: {'customerId': customerId},
          options: Options(headers: {"token": token})
      );

      print('Cashes status respons ${response}');


      if (response.statusCode == 200 && response.data != null) {
        final data = ProcessStatusResponse.fromJson(response.data);
        state = AsyncValue.data(data);
      } else {
        throw Exception("Failed to load data");
      }

    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final processStatusProvider = StateNotifierProvider<ProcessStatusNotifier, AsyncValue<ProcessStatusResponse?>>(
      (ref) => ProcessStatusNotifier(),
);
*/

final paymentCaseProvider = StateNotifierProvider.family<PaymentWithRazorPay,
    PaymentState, BuildContext>((ref, context) {
  return PaymentWithRazorPay(context);
});

class PaymentWithRazorPay extends StateNotifier<PaymentState> {
  final BuildContext context;
  final Razorpay _razorpay = Razorpay();

  PaymentWithRazorPay(this.context) : super(PaymentState(status: 'initial')) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void payWithRazorPay(
      {required int amount, required String mobile, required String orderId}) {
    print(mobile);
    // String mobileNo = mobile;
    var options = {
      'key': 'rzp_live_qFjwtsJR2qTnPA',
      'amount': amount * 100,
      'order_id': orderId,
      // 'name': 'Acme Corp.',
      'description': 'Login Fees',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': mobile, 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    print(options['prefill']);
    try {
      _razorpay.open(options);
    } catch (e) {
      state = PaymentState(status: 'error', errorMessage: e.toString());
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (kDebugMode) {
      print('payment success');
    }
    FormSubmitDialog().formSubmitDialog(context: context);
    state = PaymentState(status: 'success', transactionId: response.paymentId);
  }

// Handle payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    state = PaymentState(status: 'error', errorMessage: response.message);
  }

// Handle external wallet selection
  void _handleExternalWallet(ExternalWalletResponse response) {
    state = PaymentState(
        status: 'external_wallet', transactionId: response.walletName);
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

