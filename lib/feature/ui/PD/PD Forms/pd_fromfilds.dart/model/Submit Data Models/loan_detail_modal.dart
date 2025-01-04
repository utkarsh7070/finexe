class TotalLoanDetailsModel {
  UpdateLoanDetails? updateLoanDetails;

  TotalLoanDetailsModel({this.updateLoanDetails});

  // The constructor for creating an instance from JSON
  TotalLoanDetailsModel.fromJson(Map<String, dynamic> json) {
    updateLoanDetails = json['approveLoanDetails'] != null
        ? UpdateLoanDetails.fromJson(json['approveLoanDetails'])
        : null;
  }

  // Method to convert the model back to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (updateLoanDetails != null) {
      data['approveLoanDetails'] = updateLoanDetails!.toJson();
    }
    return data;
  }
}

class UpdateLoanDetails {
  double? approvedAmount;
  double? roi;
  double? tenure;
  double? emi;
  String? demandLoanAmountByCustomer;
  String? finalDecision;
  String? endUseOfLoan;
  String? remarkByPd;

  UpdateLoanDetails({
    this.approvedAmount,
    this.roi,
    this.tenure,
    this.emi,
    this.demandLoanAmountByCustomer,
    this.finalDecision,
    this.endUseOfLoan,
  });

  UpdateLoanDetails.fromJson(Map<String, dynamic> json) {
    // approvedAmount = json['approvedAmount'];
    approvedAmount = (json['approvedAmount'] != null) ? (json['approvedAmount'] as num).toDouble() : null;

    // roi = json['ROI'];
    roi = (json['ROI'] != null) ? (json['ROI'] as num).toDouble() : null;

    // tenure = json['Tenure'];
    tenure = (json['Tenure'] != null) ? (json['Tenure'] as num).toDouble() : null;

    emi = (json['EMI'] != null) ? (json['EMI'] as num).toDouble() : null;
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
