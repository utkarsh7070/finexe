
class Api {
  static const String baseUrl = 'https://stageapi.fincooper.in/';
  static const String getAllProduct = '${baseUrl}v1/adminMaster/product/getAllProduct';
  static const String aadhaarNumber = '${baseUrl}v1/aadharDetail/aadhaarSendOtp';
  static const String aadhaarOtpVerify = '${baseUrl}v1/aadharDetail/aadhaarSubmitOtp';
  static const String panVerify = '${baseUrl}v1/panDetail/PanComprehensive';
  static const String aadhaarPhoto = '${baseUrl}v1/aadharDetail/aadhaarOCR';

  static Duration connectionTimeout = const Duration(milliseconds: 15000);
  static Duration receiveTimeout = const Duration(milliseconds: 15000);
}
