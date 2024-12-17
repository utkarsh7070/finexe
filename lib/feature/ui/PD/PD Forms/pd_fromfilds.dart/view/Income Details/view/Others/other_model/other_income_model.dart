class OtherIncomeModel {
  final String incomeSourceType;
  final OtherIncomeData data;

  OtherIncomeModel({
    required this.incomeSourceType,
    required this.data,
  });

  factory OtherIncomeModel.fromJson(Map<String, dynamic> json) {
    return OtherIncomeModel(
      incomeSourceType: json['incomeSourceType'] ?? '',
      data: OtherIncomeData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'incomeSourceType': incomeSourceType,
    'data': data.toJson(),
  };
}



class OtherIncomeData {
  final String bussinessFromSinceYear;
  final String natureOfBusiness;
  final double monthlyIncome;
  final double yearlyIncome;
  final String discriptionOfBusiness;
  final List<String> incomeOtherImages;

  OtherIncomeData({
    required this.bussinessFromSinceYear,
    required this.natureOfBusiness,
    required this.monthlyIncome,
    required this.yearlyIncome,
    required this.discriptionOfBusiness,
    required this.incomeOtherImages,
  });

  // Factory constructor to create a model instance from a JSON response
  factory OtherIncomeData.fromJson(Map<String, dynamic> json) {
    return OtherIncomeData(
      bussinessFromSinceYear: json['bussinessFromSinceYear'] ?? '',
      natureOfBusiness: json['natureOfBusiness'] ?? '',
      monthlyIncome: _parseDouble(json['monthlyIncome']),
      yearlyIncome: _parseDouble(json['yearlyIncome']),
      discriptionOfBusiness: json['discriptionOfBusiness'] ?? '',
      incomeOtherImages: List<String>.from(json['incomeOtherImages'] ?? []),
    );
  }

  // Helper method to parse double values safely
  static double _parseDouble(dynamic value) {
    if (value == null) {
      return 0.0; // Default value for null
    }
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0; // Default value for unexpected types
    }
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'bussinessFromSinceYear': bussinessFromSinceYear,
      'natureOfBusiness': natureOfBusiness,
      'monthlyIncome': monthlyIncome,
      'yearlyIncome': yearlyIncome,
      'discriptionOfBusiness': discriptionOfBusiness,
      'incomeOtherImages': incomeOtherImages,
    };
  }
}
