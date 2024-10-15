import 'package:dio/dio.dart';

class LoanFormData {
  final String productId;
  final String mobileNo;
  final String loanAmount;
  final String roi;
  final String tenure;
  final String emi;

  LoanFormData({
    required this.productId,
    required this.mobileNo,
    required this.loanAmount,
    required this.roi,
    required this.tenure,
    required this.emi,
  });

  // Convert model to FormData for Dio
  FormData toFormData() {
    return FormData.fromMap({
      'productId': productId,
      'mobileNo': mobileNo,
      'loanAmount': loanAmount,
      'roi': roi,
      'tenure': tenure,
      'emi': emi,
    });
  }
}
