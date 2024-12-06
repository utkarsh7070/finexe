

class ProcessStatusResponse {
  final bool status;
  final int subCode;
  final String message;
  final String error;
  final Sales? sales;
  final Cibil? cibil;
  final BranchPendancy? branchPendancy;
  /*final VendorDetails? vendorDetails;*/
  final PD? pd;

  ProcessStatusResponse({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    this.sales,
    this.cibil,
    this.branchPendancy,
    /*this.vendorDetails,*/
    this.pd,
  });

  factory ProcessStatusResponse.fromJson(Map<String, dynamic> json) {
    final items = json['items'] ?? {};

    return ProcessStatusResponse(
      status: json['status'],
      subCode: json['subCode'],
      message: json['message'],
      error: json['error'],
      sales: items['Sales'] != null ? Sales.fromJson(items['Sales']) : null,
      cibil: items['cibil'] != null ? Cibil.fromJson(items['cibil']) : null,
      branchPendancy: items['branchpendency'] != null
          ? BranchPendancy.fromJson(items['branchpendency'])
          : null,
     /* vendorDetails: items['vendorDetails'] != null && items['vendorDetails'].isNotEmpty
          ? VendorDetails.fromJson(items['vendorDetails'])
          : null,*/
      pd: items['pd'] != null ? PD.fromJson(items['pd']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'subCode': subCode,
      'message': message,
      'error': error,
      'sales': sales?.toJson(),
      'cibil': cibil?.toJson(),
      'branchPendancy': branchPendancy?.toJson(),
      /*'vendorDetails': vendorDetails?.toJson(),*/
      'pd': pd?.toJson(),
    };
  }
}

class Sales {
  final String customerStatus;
  final String applicationStatus;
  final String coApplicantStatus;
  final String guarantorStatus;
  final String paymentStatus;
  final int paymentAmount;
  final num cutomerNumber;

  Sales({
    required this.customerStatus,
    required this.applicationStatus,
    required this.coApplicantStatus,
    required this.guarantorStatus,
    required this.paymentStatus,
    required this.paymentAmount,
    required this.cutomerNumber,
  });

  factory Sales.fromJson(Map<String, dynamic> json) {
    return Sales(
      customerStatus: json['customerStatus'] ?? 'Pending',
      applicationStatus: json['applicationStatus'] ?? 'Pending',
      coApplicantStatus: json['coApplicantStatus'] ?? 'Pending',
      guarantorStatus: json['guarantorStatus'] ?? 'Pending',
      paymentStatus: json['paymentStatus'] ?? 'Pending',
      paymentAmount: json['paymentAmount'] ?? 0,
      cutomerNumber: json['cutomerNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerStatus': customerStatus,
      'applicationStatus': applicationStatus,
      'coApplicantStatus': coApplicantStatus,
      'guarantorStatus': guarantorStatus,
      'paymentStatus': paymentStatus,
      'paymentAmount': paymentAmount,
      'cutomerNumber': cutomerNumber,
    };
  }

  // Check if a field status is 'pending'
  bool isApplicationPending() {
    return applicationStatus.toLowerCase() == 'pending';
  }

  bool isCoApplicationPending() {
    return coApplicantStatus.toLowerCase() == 'pending';
  }

  bool isGuarantorPending() {
    return guarantorStatus.toLowerCase() == 'pending';
  }

  bool isPaymentPending() {
    return paymentStatus.toLowerCase() == 'pending';
  }

}

class Cibil {
  final String applicantCibilStatus;
  final String coApplicantCibilStatus;
  final String guarantorCibilStatus;
  final String allCibilStatus;
  final String date;

  Cibil({
    required this.applicantCibilStatus,
    required this.coApplicantCibilStatus,
    required this.guarantorCibilStatus,
    required this.allCibilStatus,
    required this.date,
  });

  factory Cibil.fromJson(Map<String, dynamic> json) {
    return Cibil(
      applicantCibilStatus: json['applicantCibilStatus'] ?? '',
      coApplicantCibilStatus: json['coApplicantCibilStatus'] ?? '',
      guarantorCibilStatus: json['guarantorCibilStatus'] ?? '',
      allCibilStatus: json['allCibilStatus'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'applicantCibilStatus': applicantCibilStatus,
      'coApplicantCibilStatus': coApplicantCibilStatus,
      'guarantorCibilStatus': guarantorCibilStatus,
      'allCibilStatus': allCibilStatus,
      'date': date,
    };
  }

}

class BranchPendancy {
  final String branchStatus;
  final String branchByRemark;
  final String branchCompleteDate;

  BranchPendancy({
    required this.branchStatus,
    required this.branchByRemark,
    required this.branchCompleteDate,
  });

  factory BranchPendancy.fromJson(Map<String, dynamic> json) {
    return BranchPendancy(
      branchStatus: json['branchStatus'] ?? '',
      branchByRemark: json['branchByRemark'] ?? '',
      branchCompleteDate: json['branchCompleteDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branchStatus': branchStatus,
      'branchByRemark': branchByRemark,
      'branchCompleteDate': branchCompleteDate,
    };
  }



}

/*class VendorDetails {
  final Map<String, VendorDetail>? vendors;

  VendorDetails({this.vendors});

  factory VendorDetails.fromJson(Map<String, dynamic> json) {
    Map<String, VendorDetail>? vendors;
    if (json.isNotEmpty) {
      vendors = json.map((key, value) => MapEntry(key, VendorDetail.fromJson(value)));
    }

    return VendorDetails(vendors: vendors);
  }

  Map<String, dynamic> toJson() {
    return {
      'vendors': vendors?.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class VendorDetail {
  final String approverRemark;
  final String vendorStatus;
  final String statusByVendor;
  final String? vendorUploadDate;
  final String? approverDate;
  final String? vendorId;
  final String vendorName;
  final String vendorUserName;

  VendorDetail({
    required this.approverRemark,
    required this.vendorStatus,
    required this.statusByVendor,
    this.vendorUploadDate,
    this.approverDate,
    this.vendorId,
    required this.vendorName,
    required this.vendorUserName,
  });

  factory VendorDetail.fromJson(Map<String, dynamic> json) {
    return VendorDetail(
      approverRemark: json['approverRemark'] ?? '',
      vendorStatus: json['vendorStatus'] ?? '',
      statusByVendor: json['statusByVendor'] ?? '',
      vendorUploadDate: json['vendorUploadDate'],
      approverDate: json['approverDate'],
      vendorId: json['vendorId'],
      vendorName: json['vendorName'] ?? '',
      vendorUserName: json['vendorUserName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'approverRemark': approverRemark,
      'vendorStatus': vendorStatus,
      'statusByVendor': statusByVendor,
      'vendorUploadDate': vendorUploadDate,
      'approverDate': approverDate,
      'vendorId': vendorId,
      'vendorName': vendorName,
      'vendorUserName': vendorUserName,
    };
  }

}*/

class PD {
  final String creaditPdId;
  final String creditPdAssignDate;
  final String remarkForCreditPd;
  final String approvalRemarkCreditPd;
  final String creditPdSendMail;
  final String statusByCreditPd;
  final String statusByTlPd;

  PD({
    required this.creaditPdId,
    required this.creditPdAssignDate,
    required this.remarkForCreditPd,
    required this.approvalRemarkCreditPd,
    required this.creditPdSendMail,
    required this.statusByCreditPd,
    required this.statusByTlPd,
  });

  factory PD.fromJson(Map<String, dynamic> json) {
    return PD(
      creaditPdId: json['creaditPdId'] ?? '',
      creditPdAssignDate: json['creditPdAssignDate'] ?? '',
      remarkForCreditPd: json['remarkForCreditPd'] ?? '',
      approvalRemarkCreditPd: json['approvalRemarkCreditPd'] ?? '',
      creditPdSendMail: json['creditPdSendMail'] ?? '',
      statusByCreditPd: json['statusByCreditPd'] ?? '',
      statusByTlPd: json['statusByTlPd'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'creaditPdId': creaditPdId,
      'creditPdAssignDate': creditPdAssignDate,
      'remarkForCreditPd': remarkForCreditPd,
      'approvalRemarkCreditPd': approvalRemarkCreditPd,
      'creditPdSendMail': creditPdSendMail,
      'statusByCreditPd': statusByCreditPd,
      'statusByTlPd': statusByTlPd,
    };
  }

}





// Similarly, create classes for `Cibil`, `BranchPendency`, `VendorDetails`, and `Pd`.
