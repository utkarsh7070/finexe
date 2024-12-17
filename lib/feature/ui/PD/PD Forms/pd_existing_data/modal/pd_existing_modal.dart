class PDFormModel {
  final LoanDetails loanDetails;
  final ApplicationDetails applicationDetails;
  final List<CoApplicantDetails> coApplicantDetails;
  final GuarantorDetails guarantorDetails;
  final CibilDetails cibilDetails;

  PDFormModel({
    required this.loanDetails,
    required this.applicationDetails,
    required this.coApplicantDetails,
    required this.guarantorDetails,
    required this.cibilDetails,
  });

  // Factory constructor to create PDFormModel from API response
  factory PDFormModel.fromJson(Map<String, dynamic> json) {
    // Fetch co-applicant data as a list of CoApplicantDetails
    List<CoApplicantDetails> coApplicants = [];

    if (json['coApplicantDetails01'] != null) {
      coApplicants.add(CoApplicantDetails.fromJson(json['coApplicantDetails01']));
    }
    if (json['coApplicantDetails02'] != null) {
      coApplicants.add(CoApplicantDetails.fromJson(json['coApplicantDetails02']));
    }

    // Ensure we have at least two co-applicants
    while (coApplicants.length < 2) {
      coApplicants.add(CoApplicantDetails.fromJson({})); // Empty co-applicant
    }

    return PDFormModel(
      loanDetails: LoanDetails.fromJson(json['loanDetails']),
      applicationDetails: ApplicationDetails.fromJson(json['applicationDetails']),
      coApplicantDetails: coApplicants, // List of co-applicants
      guarantorDetails: GuarantorDetails.fromJson(json['guarantorDetails']),
      cibilDetails: CibilDetails.fromJson(json['cibilDetails']),
    );
  }
}

// Loan Details section
class LoanDetails {
  final String productType;
  final int requiredAmount;
  final double roi;
  final int tenure;
  final double emiAmount;

  LoanDetails({
    required this.productType,
    required this.requiredAmount,
    required this.roi,
    required this.tenure,
    required this.emiAmount,
  });

  factory LoanDetails.fromJson(Map<String, dynamic> json) {
    return LoanDetails(
      productType: json['productId']?['productName'] ?? '',
      requiredAmount: json['loanAmount'] ?? 0,
      roi: json['roi']?.toDouble() ?? 0.0,
      tenure: json['tenure'] ?? 0,
      emiAmount: json['emi']?.toDouble() ?? 0.0,
    );
  }
}


// Application Details section
class ApplicationDetails {
  final List<String> applicantPhotos;
  final String applicantName;
  final String motherName;
  final String? spouseName;
  final int mobileNumber; // Use int since response has int type
  final String maritalStatus;
  final String educationDetails;
  final String applicantDOB;
  final String gender;
  final String panNumber;
  final String aadharNumber;
  final String? voterIdNumber;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String district;
  final String pinCode;
  final String applicantCibilReport;
  final List<String> uploadedPhotos;

  ApplicationDetails({
    required this.applicantPhotos,
    required this.applicantName,
    required this.motherName,
    this.spouseName,
    required this.mobileNumber,
    required this.maritalStatus,
    required this.educationDetails,
    required this.applicantDOB,
    required this.gender,
    required this.panNumber,
    required this.aadharNumber,
    this.voterIdNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.district,
    required this.pinCode,
    required this.applicantCibilReport,
    required this.uploadedPhotos,
  });

  factory ApplicationDetails.fromJson(Map<String, dynamic> json) {
    return ApplicationDetails(
      applicantName: json['fullName'] ?? '',
      motherName: json['motherName'] ?? '',
      spouseName: json['spouseName'],
      mobileNumber: json['mobileNo'] ?? 0, // Default to 0 if null
      maritalStatus: json['maritalStatus'] ?? 'N/A',
      educationDetails: json['education'] ?? 'N/A',
      applicantDOB: json['dob'] ?? 'N/A',
      gender: json['gender'] ?? 'N/A',
      panNumber: json['panNo'] ?? 'N/A',
      aadharNumber: json['aadharNo'] ?? 'N/A',
      voterIdNumber: json['voterIdNo'],
      addressLine1: json['permanentAddress']['addressLine1'] ?? 'N/A',
      addressLine2: json['permanentAddress']['addressLine2'] ?? 'N/A',
      city: json['permanentAddress']['city'] ?? 'N/A',
      state: json['permanentAddress']['state'] ?? 'N/A',
      district: json['permanentAddress']['district'] ?? 'N/A',
      pinCode: json['permanentAddress']['pinCode']?.toString() ?? 'N/A',
      applicantPhotos: List<String>.from([json['applicantPhoto'] ?? '']),
      uploadedPhotos: List<String>.from(
          (json['kycUpload'] as Map<String, dynamic>?)?.values.whereType<String>() ?? []),
      applicantCibilReport: json['applicantCibilReport']?? 'N/A',
    );

  }
}

// Co-Applicant Details section
class CoApplicantDetails {
  final String? coApplicantPhoto; // Co-Applicant photo
  final String? fullName;         // Full name
  final String? fatherName;       // Father/Spouse name
  final String? motherName;       // Mother name
  final String? relationWithApplicant; // Relationship
  final String? age;                  // Age
  final String? gender;           // Gender
  final String? email;            // Email
  final String? maritalStatus;    // Marital status
  final String? education;        // Education
  final String? caste;            // Caste
  final String? aadharNo;         // Aadhar number
  final String? docNo;            // Document number (e.g., PAN number)
  final String? docType;          // Document type (e.g., PAN, Aadhar)
  final String? voterId;          // Voter ID number
  final KycUpload? kycUpload;     // KYC uploaded images

  CoApplicantDetails({
    this.coApplicantPhoto,
    this.fullName,
    this.fatherName,
    this.motherName,
    this.relationWithApplicant,
    this.age,
    this.gender,
    this.email,
    this.maritalStatus,
    this.education,
    this.caste,
    this.aadharNo,
    this.docNo,
    this.docType,
    this.voterId,
    this.kycUpload,
  });

  factory CoApplicantDetails.fromJson(Map<String, dynamic> json) {
    return CoApplicantDetails(
      coApplicantPhoto: json['coApplicantPhoto'] as String?,
      fullName: json['fullName'] as String?,
      fatherName: json['fatherName'] as String?,
      motherName: json['motherName'] as String?,
      relationWithApplicant: json['relationWithApplicant'] as String?,
      age: json['age'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      education: json['education'] as String?,
      caste: json['caste'] as String?,
      aadharNo: json['aadharNo'] as String?,
      docNo: json['docNo'] as String?,
      docType: json['docType'] as String?,
      voterId: json['voterId'] as String?,
      kycUpload: json['kycUpload'] != null ? KycUpload.fromJson(json['kycUpload']) : null,
    );
  }
}

class KycUpload {
  final String? docImage;
  final String? aadharFrontImage;
  final String? aadharBackImage;

  KycUpload({this.docImage, this.aadharFrontImage, this.aadharBackImage});

  factory KycUpload.fromJson(Map<String, dynamic> json) {
    return KycUpload(
      docImage: json['docImage'] as String?,
      aadharFrontImage: json['aadharFrontImage'] as String?,
      aadharBackImage: json['aadharBackImage'] as String?,
    );
  }
}

// Guarantor Details section
class GuarantorDetails {
  final String aadharNo;
  final String docType;
  final String docNo;
  final String guarantorPhoto;
  final String fullName;
  final String fatherName;
  final String motherName;
  final String spouseName;
  final String maritalStatus;
  final String gender;
  final String email;
  final String dob;
  final String religion;
  final String caste;
  final String education;
  final String age;
  final String mobileNo;
  final String relationWithApplicant;
  final Address permanentAddress;
  final Address localAddress;
  final GuarantorKycUpload guarantorKycUpload;

  GuarantorDetails({
    required this.aadharNo,
    required this.docType,
    required this.docNo,
    required this.guarantorPhoto,
    required this.fullName,
    required this.fatherName,
    required this.motherName,
    required this.spouseName,
    required this.maritalStatus,
    required this.gender,
    required this.email,
    required this.dob,
    required this.religion,
    required this.caste,
    required this.education,
    required this.age,
    required this.mobileNo,
    required this.relationWithApplicant,
    required this.permanentAddress,
    required this.localAddress,
    required this.guarantorKycUpload,
  });

  factory GuarantorDetails.fromJson(Map<String, dynamic> json) {
    return GuarantorDetails(
      aadharNo: json['aadharNo'] ?? '',
      docType: json['docType'] ?? '',
      docNo: json['docNo'] ?? '',
      guarantorPhoto: json['guarantorPhoto'] ?? '',
      fullName: json['fullName'] ?? '',
      fatherName: json['fatherName'] ?? '',
      motherName: json['motherName'] ?? '',
      spouseName: json['spouseName'] ?? '',
      maritalStatus: json['maritalStatus'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'] ?? '',
      religion: json['religion'] ?? '',
      caste: json['caste'] ?? '',
      education: json['education'] ?? '',
      age: json['age'] ?? '',
      mobileNo: json['mobileNo'].toString(),
      relationWithApplicant: json['relationWithApplicant'] ?? '',
      permanentAddress: Address.fromJson(json['permanentAddress']),
      localAddress: Address.fromJson(json['localAddress']),
      guarantorKycUpload: GuarantorKycUpload.fromJson(json['kycUpload']),
    );
  }
}

class Address {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String district;
  final String pinCode;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.district,
    required this.pinCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      pinCode: json['pinCode'] ?? '',
    );
  }
}

class GuarantorKycUpload {
  final String aadharFrontImage;
  final String aadharBackImage;
  final String docImage;

  GuarantorKycUpload({
    required this.aadharFrontImage,
    required this.aadharBackImage,
    required this.docImage,
  });

  factory GuarantorKycUpload.fromJson(Map<String, dynamic> json) {
    return GuarantorKycUpload(
      aadharFrontImage: json['aadharFrontImage'] ?? '',
      aadharBackImage: json['aadharBackImage'] ?? '',
      docImage: json['docImage'] ?? '',
    );
  }
}


// Cibil Details section
class CibilDetails {
  final String applicantCibilScore;
  final String coApplicantCibilScore;
  final String guarantorCibilScore;
  final List<CibilDetail> applicantCibilDetail;
  final List<CibilDetail> coApplicantCibilDetail;
  final List<CibilDetail> guarantorCibilDetail;

  CibilDetails({
    required this.applicantCibilScore,
    required this.coApplicantCibilScore,
    required this.guarantorCibilScore,
    required this.applicantCibilDetail,
    required this.coApplicantCibilDetail,
    required this.guarantorCibilDetail,
  });

  // fromJson factory constructor
  factory CibilDetails.fromJson(Map<String, dynamic> json) {
    return CibilDetails(
      applicantCibilScore: (json['applicantCibilScore'] != null)
          ? json['applicantCibilScore'].toString()
          : 'N/A',
      coApplicantCibilScore: (json['coApplicantCibilScore'] != null)
          ? json['coApplicantCibilScore'].toString()
          : 'N/A',
      guarantorCibilScore: (json['guarantorCibilScore'] != null)
          ? json['guarantorCibilScore'].toString()
          : 'N/A',
      applicantCibilDetail: (json['applicantCibilDetail'] as List?)
          ?.map((item) => CibilDetail.fromJson(item))
          ?.toList() ??
          [],
      coApplicantCibilDetail: (json['coApplicantCibilDetail'] as List?)
          ?.map((item) => CibilDetail.fromJson(item))
          ?.toList() ??
          [],
      guarantorCibilDetail: (json['guarantorCibilDetail'] as List?)
          ?.map((item) => CibilDetail.fromJson(item))
          ?.toList() ??
          [],
    );
  }

}

class CibilDetail {
  final String loanType;
  final String loanAmount;
  final String outstandingAmount;
  final String overDue;
  final String emi;

  CibilDetail({
    required this.loanType,
    required this.loanAmount,
    required this.outstandingAmount,
    required this.overDue,
    required this.emi,
  });

  // fromJson for CibilDetail
  factory CibilDetail.fromJson(Map<String, dynamic> json) {
    return CibilDetail(
      loanType: json['loanType'] ?? 'N/A',
      loanAmount: json['loanAmount'] ?? 'N/A',
      outstandingAmount: json['outstandingAmount'] ?? 'N/A',
      overDue: json['overDue'] ?? 'N/A',
      emi: json['emi'] ?? 'N/A',
    );
  }
}









