class PendencyDetailsFormModel {
  String customerId;
  String pdType;
  String remarkByPd;
  PendencyApproveLoanDetails approveLoanDetails;

  PendencyDetailsFormModel({
    required this.customerId,
    required this.pdType,
    required this.remarkByPd,
    required this.approveLoanDetails,
  });

  // Convert a JSON object to a PendencyDetailsFormModel instance
  factory PendencyDetailsFormModel.fromJson(Map<String, dynamic> json) {
    return PendencyDetailsFormModel(
      customerId: json['customerId'],
      pdType: json['pdType'],
      remarkByPd: json['remarkByPd'],
      approveLoanDetails: PendencyApproveLoanDetails.fromJson(json['approveLoanDetails']),
    );
  }

  // Convert the PendencyDetailsFormModel instance to a JSON object for POST requests
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'pdType': pdType,
      'remarkByPd': remarkByPd,
      'approveLoanDetails': approveLoanDetails.toJson(),
    };
  }
}


class PendencyApproveLoanDetails {
  int? approvedAmount;
  double? roi;
  int? tenure;
  int? emi;
  String? demandLoanAmountByCustomer;
  int? finalDecision;
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
    approvedAmount = json['approvedAmount'];
    roi = (json['ROI'] != null) ? (json['ROI'] as num).toDouble() : null;
    tenure = json['Tenure'];
    emi = json['EMI'];
    demandLoanAmountByCustomer = json['demandLoanAmountByCustomer'];
    finalDecision = json['finalDecision'];
    endUseOfLoan = json['endUseOfLoan'];
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

