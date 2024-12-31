class PendencyDetailsFormModel {
  String? customerId;
  String? pdType;
  String? remarkByPd;
  String? statabyPd;
  PendencyApproveLoanDetails? approveLoanDetails;

  PendencyDetailsFormModel({
    this.customerId,
    this.pdType,
    this.remarkByPd,
    this.statabyPd,
    this.approveLoanDetails,
  });

  // Convert a JSON object to a PendencyDetailsFormModel instance
  factory PendencyDetailsFormModel.fromJson(Map<String, dynamic> json) {
    return PendencyDetailsFormModel(
      customerId: json['customerId'] as String?,
      pdType: json['pdType'] as String?,
      remarkByPd: json['remarkByPd'] as String?,
      statabyPd: json['statusByPd'] as String?,
      approveLoanDetails: json['approveLoanDetails'] != null
          ? PendencyApproveLoanDetails.fromJson(json['approveLoanDetails'])
          : null,
    );
  }

  // Convert the PendencyDetailsFormModel instance to a JSON object for POST requests
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'pdType': pdType,
      'remarkByPd': remarkByPd,
      'statusByPd': statabyPd,
      'approveLoanDetails': approveLoanDetails?.toJson(),
    };
  }
}


class PendencyApproveLoanDetails {
  int? approvedAmount;
  double? roi;
  int? tenure;
  double? emi;
  String? demandLoanAmountByCustomer;
  String? finalDecision;
  String? endUseOfLoan;

  PendencyApproveLoanDetails({
    this.approvedAmount,
    this.roi,
    this.tenure,
    this.emi,
    this.demandLoanAmountByCustomer,
    this.finalDecision,
    this.endUseOfLoan,
  });

  PendencyApproveLoanDetails.fromJson(Map<String, dynamic> json) {
    approvedAmount = json['approvedAmount'] as int?;
    roi = (json['ROI'] != null) ? (json['ROI'] as num).toDouble() : null;
    tenure = json['Tenure'] as int?;
    emi = (json['EMI'] != null) ? (json['EMI'] as num).toDouble() : null;
    demandLoanAmountByCustomer = json['demandLoanAmountByCustomer'] as String?;
    finalDecision = json['finalDecision'] as String?;
    endUseOfLoan = json['endUseOfLoan'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['approvedAmount'] = approvedAmount;
    data['ROI'] = roi;
    data['Tenure'] = tenure;
    data['EMI'] = emi;
    data['demandLoanAmountByCustomer'] = demandLoanAmountByCustomer;
    data['finalDecision'] = finalDecision;
    data['endUseOfLoan'] = endUseOfLoan;
    return data;
  }
}


