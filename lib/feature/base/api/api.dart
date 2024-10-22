class Api {
  static const String baseUrl = 'https://stageapi.fincooper.in/';
  static const String login = '${baseUrl}v1/login/employe';

  //------------------------ Sales --------------------------------------------------------
  static const String getAllProduct = '${baseUrl}v1/adminMaster/product/getAllProduct';
  static const String aadhaarNumber = '${baseUrl}v1/aadharDetail/aadhaarSendOtp';
  static const String aadhaarOtpVerify = '${baseUrl}v1/aadharDetail/aadhaarSubmitOtp';
  static const String panVerify = '${baseUrl}v1/panDetail/PanComprehensive';
  static const String aadhaarPhoto = '${baseUrl}v1/aadharDetail/aadhaarOCR';
  static const String submitNewLoan = '${baseUrl}v1/salesMan/createDraftLoginFees';
  static const String submitApplicantForm = '${baseUrl}v1/salesMan/applicantAddDetail';
  static const String submitCoApplicantForm = '${baseUrl}v1/salesMan/coApplicantAddDetail';
  static const String submitGuarantorForm = '${baseUrl}v1/salesMan/guarantorAddDetail';
  static const String getApplicantForm = '${baseUrl}v1/salesMan/applicantDetail/:customerId';
  static const String collectionVisitPending = '${baseUrl}v1/googleSheet/overAllEmiData';
  static const String getAllModeOfCollection = '${baseUrl}v1/adminMaster/modeOfCollection/getAllModeOfCollection';
  static const String uploadImageCollection = '${baseUrl}v1/formData/ImageUpload';
  static const String visitFormSubmit = '${baseUrl}v1/googleSheet/visitFormAdd';
  // https://stageapi.fincooper.in/v1/googleSheet/visitFormAdd
  // https://stageapi.fincooper.in/v1/googleSheet/visitFormAdd

  //-------------------------------------------------------------------------------------------
  static Duration connectionTimeout = const Duration(milliseconds: 15000);
  static Duration receiveTimeout = const Duration(milliseconds: 15000);
}
