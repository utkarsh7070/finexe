// models/lead_generation_model.dart
class LeadGenerationModel {
  final String customerName;
  final String customerMobileNo;
  final String cityVillageName;
  final String districtName;
  final String pincode;
  final String branch;
  final String pakkaHouse;
  final String agriland;
  final String requiredLoanAmount;
  final String monthlyIncome;
  final String otherSourceOfIncome;
  final String customerFeedback;
  final String loanType;
  final String selfieImageUrl;

  LeadGenerationModel({
    required this.customerName,
    required this.customerMobileNo,
    required this.cityVillageName,
    required this.districtName,
    required this.pincode,
    required this.branch,
    required this.pakkaHouse,
    required this.agriland,
    required this.requiredLoanAmount,
    required this.monthlyIncome,
    required this.otherSourceOfIncome,
    required this.customerFeedback,
    required this.loanType,
    required this.selfieImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'customerMobileNo': customerMobileNo,
      'cityVillageName': cityVillageName,
      'distrctName': districtName,
      'pincode': pincode,
      'branch': branch,
      'pakkaHouse': pakkaHouse,
      'agriland': agriland,
      'loanAmount': requiredLoanAmount,
      'monthlyIncome': monthlyIncome,
      'otherSourceOfIncome': otherSourceOfIncome,
      'customerFeedback': customerFeedback,
      'loanType': loanType,
      'selfieImageUrl': selfieImageUrl,
    };
  }
}
