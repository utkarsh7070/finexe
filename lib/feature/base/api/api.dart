class Api {
  static const String baseUrlProduction = 'https://prod.fincooper.in/';
  static const String baseUrl = 'https://stageapi.fincooper.in/';
  static const String baseUrlStageCollection = 'https://stageapi.fincooper.in/';
  static const String baseUrlStageProduction ='https://prod.fincooper.in/';

  static const String login = '${baseUrl}v1/login/employe';
  // https://prod.fincooper.in

  //------------------------ Sales --------------------------------------------------------
  static const String getAllProduct =
      '${baseUrl}v1/adminMaster/product/getAllProduct';
  static const String aadhaarNumber =
      '${baseUrl}v1/aadharDetail/aadhaarSendOtp';
  static const String aadhaarOtpVerify =
      '${baseUrl}v1/aadharDetail/aadhaarSubmitOtp';
  static const String panVerify = '${baseUrl}v1/panDetail/PanComprehensive';
  static const String aadhaarPhoto = '${baseUrl}v1/aadharDetail/aadhaarOCR';

  static const String punchOut =
      '${baseUrl}v1/adminMaster/employe/punch?action=out';
  static const String punchIn =
      '${baseUrl}v1/adminMaster/employe/punch?action=in';
  static const String checkPunchIn =
      '${baseUrl}v1/adminMaster/employe/attendanceCheck';
  static const String submitNewLoan =
      '${baseUrl}v1/salesMan/createDraftLoginFees';
  static const String submitApplicantForm =
      '${baseUrl}v1/salesMan/applicantAddDetail';
  static const String submitCoApplicantForm =
      '${baseUrl}v1/salesMan/coApplicantAddDetail';
  static const String submitGuarantorForm =
      '${baseUrl}v1/salesMan/guarantorAddDetail';
  static const String getApplicantForm =
      '${baseUrl}v1/salesMan/applicantDetail/:customerId';


  static const String collectionVisitPending =
      '${baseUrl}v1/googleSheet/overAllEmiData';
  static const String getAllModeOfCollection =
      '${baseUrl}v1/adminMaster/modeOfCollection/getAllModeOfCollection';
  // https://prod.fincooper.in/v1/adminMaster/modeOfCollection/getAllModeOfCollection


  static const String uploadImageCollection =
      '${baseUrl}v1/formData/ImageUpload';
  static const String visitFormSubmit = '${baseUrl}v1/googleSheet/visitFormAdd';
  static const String visitDetailsTable =
      '${baseUrl}v1/googleSheet/visitDetail';

  static const String getModeById =
      '${baseUrl}v1/adminMaster/modeOfCollection/getModeById';
  static const String updateEmiSubmit =
      '${baseUrl}v1/googleSheet/collectionEmiFormAdd';

  static const String visitCloseFormSubmit =
      '${baseUrl}v1/googleSheet/posCloserForm';

  static const String getAllocationDashboard =
      '${baseUrl}v1/googleSheet/getAllocationDashboard';

  static const String imageUrl = '${baseUrl}';

  static const String getVisitDetail = '${baseUrl}v1/googleSheet/visitDetail';

  static const String getVisitCollection =
      '${baseUrl}v1/googleSheet/collectionDetail';
  static const String getVisitClosure =
      '${baseUrl}v1/googleSheet/getCloserDetailBy';
  static const String getVisitNotice =
      '${baseUrl}v1/googleSheet/getLegalNoticeBy';
  static const String getVisitCalling = '${baseUrl}v1/googleSheet/callDoneBy';


  static const String updateProfile = '${baseUrl}v1/adminMaster/employe/update';
  static const String updatePassword = '${baseUrl}v1/login/updatePassword';
  static const String paymentAmount = '${baseUrl}v1/salesMan/paymentInitiate';
  static const String allCases = '${baseUrl}v1/calculator/getCustomer?status=all';
  static const String salesNew = '${baseUrl}v1/calculator/getCustomer?status=salesNew';
  static const String salesToCibil = '${baseUrl}v1/calculator/getCustomer?status=salesToCibil';
  static const String cibilPending = '${baseUrl}v1/calculator/getCustomer?status=cibilPending';
  static const String cibilOk = '${baseUrl}v1/calculator/getCustomer?status=cibilOk';
  static const String cibilReject = '${baseUrl}v1/calculator/getCustomer?status=cibilReject';
  static const String salesDashboardData = '${baseUrl}v1/salesMan/listAllProductLogin';
  static const String leadFormSubmit = '${baseUrl}v1/salesMan/leadGenerate';
  static const String leadShowPendingList = '${baseUrl}v1/salesMan/leadGenerateList';
  static const String getEmployeeDetails = '${baseUrl}v1/adminMaster/employe/getEmployeeByToken';
  static const String getAllBranch = '${baseUrl}v1/branch/getAll';

  // https://stageapi.fincooper.in/v1/login/updatePassword
  // https://stageapi.fincooper.in/v1/googleSheet/visitFormAdd
  // https://stageapi.fincooper.in/v1/googleSheet/visitFormAdd

  //-------------------------------------------------------------------------------------------
  static Duration connectionTimeout = const Duration(milliseconds: 15000);
  static Duration receiveTimeout = const Duration(milliseconds: 15000);
}
