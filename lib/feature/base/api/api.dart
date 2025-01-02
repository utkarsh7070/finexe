class Api {
  static const String baseUrlProduction = 'https://stageapi.fincooper.in';

 static const String baseUrl ='https://stageapi.fincooper.in/';// Stage URL
  // static const String baseUrl ='https://prod.fincooper.in/';// Production URL
  //  static const String baseUrl = 'https://stageapi.fincooper.in/';// Production URL
    // static const String baseUrl = 'https://prod.fincooper.in/';// Production URL
  
  static const String imageBaseUrl = 'https://stageapi.fincooper.in';  // Production URL
  static const String imageBaseProUrl = 'https://prod.fincooper.in';  // Production URL

  static const String baseUrlStageCollection = 'https://stageapi.fincooper.in/';
  static const String baseUrlStageProduction ='https://prod.fincooper.in/';
  static const String login = '${baseUrl}v1/login/newEmployeeLogin';
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

  static const String getCaseStatus = '${baseUrl}v1/salesMan/findStatus/';


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

  static const String imageUrl = baseUrl;

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

  static const String cashfreePaymentAmount = '${baseUrl}v1/salesMan/CashFreePaymentInitiate';

  static const String allCases = '${baseUrl}v1/calculator/getCustomer';
  // static const String salesNew = '${baseUrl}v1/calculator/getCustomer?employeeRole=sales&status=salesNew';
  // static const String salesToCibil = '${baseUrl}v1/calculator/getCustomer?status=salesToCibil';
  // static const String cibilPending = '${baseUrl}v1/calculator/getCustomer?employeeRole=sales&status=cibilPending';
  // static const String cibilOk = '${baseUrl}v1/calculator/getCustomer?employeeRole=sales&status=cibilOk';
  // static const String cibilReject = '${baseUrl}v1/calculator/getCustomer';
  static const String salesDashboardData = '${baseUrl}v1/salesMan/listAllProductLogin';
  static const String leadFormSubmit = '${baseUrl}v1/salesMan/leadGenerate';
  static const String leadShowPendingList = '${baseUrl}v1/salesMan/leadGenerateList';
  static const String getEmployeeDetails = '${baseUrl}v1/adminMaster/employe/getEmployeeByToken';
  static const String getAllBranch = '${baseUrl}v1/branch/getAll';
  static const String panFatherName = '${baseUrl}v1/panDetail/PanFatherName';

  //-------------------------------------HRMS------------------------------
  static const String submitLeaveRequest = '${baseUrl}v1/hrms/leave/addEmployeeLeave';

  static const String getLeaveDetails = '${baseUrl}v1/hrms/leave/getLeaveForEmployee';
  static const String getAttendanceDetails = '${baseUrl}v1/adminMaster/employe/monthlyAttendance';


  static const String getReportingManager = '${baseUrl}v1/dashboard/getAllReportingManager';
  static const String getEmployeeList = '${baseUrl}v1/adminMaster/employe/getAllEmploye';

  static const String expenseSubmitForm = baseUrl;


  // http://localhost:5500/v1/calculator/getCustomer?employeeRole=sales&status=all__
//----------------------------------EOD/BOD--------------------------------------------------
  static const String addTask = '${baseUrl}v1/bodEod/add';
  static const String getAllTask = '${baseUrl}v1/bodEod/getBy';
  static const String updateStatusTask = '${baseUrl}v1/bodEod/update';
  static const String checkBodStatus = '${baseUrl}v1/bodEod/verify';


  static const String getVersion = '${baseUrl}v1/mobile/versionGet';

  //----------------------------------------------PD-Update-Form-------------------------------------------
  static const String updatePdReport = '${baseUrl}v1/pd/addPdReport';
  //v1/pd/creditPdGet/66f53ffbd7011eb65160f292


  static const String getpdformdata = '${baseUrl}v1/pd/creditPdGet/';


  //---------------------------------- PD EXisting Form--------------------------------------------------
  static const String getApplicantFormDetails =
      '${baseUrl}v1/salesMan/applicantDetail';
  static const String getCoApplicantFormDetails =
      '${baseUrl}v1/salesMan/coApplicantDetail';
  static const String getGuarantorFormDetails =
      '${baseUrl}v1/salesMan/guarantorDetail';
  static const String getLoanDetails =
      '${baseUrl}v1/salesMan/customerLoginDetail';
  static const String getCibilDetails = '${baseUrl}v1/cibil/getCibilDetail';
  static const String getReqRefP = '${baseUrl}v1/pd/allPDAssignFiles';
  static const String revertByVendor = '${baseUrl}v1/externalvendor/revertByVendor';
  static const String pdAssign = '${baseUrl}v1/pd/allPDAssignFiles';
  static const String getotherdropdatalist = '${baseUrl}v1/salesMan/getNameAppAndCoApp/';

  //..............................Punch In Out Side API.................
  static const String punchOutSide = '${baseUrl}v1/adminMaster/employe/punchOutSideBranch';
  //-------------------------------------------------------------------------------------------
  static Duration connectionTimeout = const Duration(milliseconds: 15000);
  static Duration receiveTimeout = const Duration(milliseconds: 15000);
}
