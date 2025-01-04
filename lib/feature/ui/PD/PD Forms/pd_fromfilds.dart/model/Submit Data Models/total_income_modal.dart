class TotalIncomeDetailsModel {
  TotalIncomeDetails? totalIncomeDetails;

  TotalIncomeDetailsModel({this.totalIncomeDetails});

  TotalIncomeDetailsModel.fromJson(Map<String, dynamic> json) {
    // If the field is a string but needs to be a bool, convert it
    totalIncomeDetails = json['totalIncomeDetails'] != null
        ? TotalIncomeDetails.fromJson(json['totalIncomeDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (totalIncomeDetails != null) {
      data['totalIncomeDetails'] = totalIncomeDetails!.toJson();
    }
    return data;
  }
}

class TotalIncomeDetails {
  String? totalYearlyIncome;
  String? totalMonthlyIncome;
  String? totalExpensesYearly;
  String? totalExpensesMonthly;

  // Example of a boolean field that could be a string in the API
  bool? status; // This is where the issue might arise if the API returns a string

  TotalIncomeDetails({
    this.totalYearlyIncome,
    this.totalMonthlyIncome,
    this.totalExpensesYearly,
    this.totalExpensesMonthly,
    this.status,
  });

  TotalIncomeDetails.fromJson(Map<String, dynamic> json) {
    totalYearlyIncome = json['totalYearlyIncome'];
    totalMonthlyIncome = json['totalMonthlyIncome'];
    totalExpensesYearly = json['totalExpensesYearly'];
    totalExpensesMonthly = json['totalExpensesMonthly'];

    // Ensure the `status` field is a boolean, even if the API sends it as a string
    if (json['status'] != null) {
      status = json['status'] is String
          ? (json['status'] == 'true') // Convert string to bool
          : json['status']; // If already a boolean, use it as is
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'totalYearlyIncome': totalYearlyIncome,
      'totalMonthlyIncome': totalMonthlyIncome,
      'totalExpensesYearly': totalExpensesYearly,
      'totalExpensesMonthly': totalExpensesMonthly,
      'status': status, // Ensure it's stored as a bool
    };
  }

  @override
  String toString() {
    return 'TotalIncomeDetails(totalYearlyIncome: $totalYearlyIncome, totalMonthlyIncome: $totalMonthlyIncome, totalExpensesYearly: $totalExpensesYearly, totalExpensesMonthly: $totalExpensesMonthly, status: $status)';
  }
}
