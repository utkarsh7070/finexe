

class SalaryIncomeModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  SalaryDetailsModel? items;

  SalaryIncomeModel({this.status, this.subCode, this.message, this.error, this.items});

  SalaryIncomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null ? SalaryDetailsModel.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['subCode'] = subCode;
    data['message'] = message;
    data['error'] = error;
    if (items != null) {
      data['items'] = items!.toJson();
    }
    return data;
  }
}


class SalaryDetailsModel {
  final String incomeSourceType;
  final SalaryDetailsData data;

  SalaryDetailsModel({
    required this.incomeSourceType,
    required this.data,
  });

  factory SalaryDetailsModel.fromJson(Map<String, dynamic> json) {
    return SalaryDetailsModel(
      incomeSourceType: json['incomeSourceType'] ?? '',
      data: SalaryDetailsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'incomeSourceType': incomeSourceType,
        'data': data.toJson(),
      };
}

class SalaryDetailsData {
  final String numberOfCattrels;
  final String companyName;
  final String addressOfSalaryProvider;
  final String mobNoOfSalaryProvider;
  final String doingFromNoYears;
  final String salaryPaidThrough;
  final String monthlyNetSalary;
  final String salaryCredited6Month;
  final List<String> last3MonthSalarySlipPhotos;
  String bankStatementPhoto;
  final List<String> salaryPhotos;

  SalaryDetailsData({
    required this.numberOfCattrels,
    required this.companyName,
    required this.addressOfSalaryProvider,
    required this.mobNoOfSalaryProvider,
    required this.doingFromNoYears,
    required this.salaryPaidThrough,
    required this.monthlyNetSalary,
    required this.salaryCredited6Month,
    required this.last3MonthSalarySlipPhotos,
    required this.bankStatementPhoto,
    required this.salaryPhotos,
  });

  factory SalaryDetailsData.fromJson(Map<String, dynamic> json) {
    return SalaryDetailsData(
      numberOfCattrels: json['numberOfCattrels'] ?? '',
      companyName: json['companyName'] ?? '',
      addressOfSalaryProvider: json['addressOfSalaryProvider'] ?? '',
      mobNoOfSalaryProvider: json['MobNoOfSalaryProvider'] ?? '',
      doingFromNoYears: json['doingFromNoYears'] ?? '',
      salaryPaidThrough: json['salaryPaidThrouch'] ?? '',
      monthlyNetSalary: json['monthlyNetSalary'] ?? '',
      salaryCredited6Month: json['salaryCredited6Month'] ?? '',
      last3MonthSalarySlipPhotos:
          List<String>.from(json['last3MonthSalarySlipPhotos'] ?? []),
      bankStatementPhoto: json['bankStatementPhoto'] ?? '',
      salaryPhotos: List<String>.from(json['salaryPhotos'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'numberOfCattrels': numberOfCattrels,
        'companyName': companyName,
        'addressOfSalaryProvider': addressOfSalaryProvider,
        'MobNoOfSalaryProvider': mobNoOfSalaryProvider,
        'doingFromNoYears': doingFromNoYears,
        'salaryPaidThrouch': salaryPaidThrough,
        'monthlyNetSalary': monthlyNetSalary,
        'salaryCredited6Month': salaryCredited6Month,
        'last3MonthSalarySlipPhotos': last3MonthSalarySlipPhotos,
        'bankStatementPhoto': bankStatementPhoto,
        'salaryPhotos': salaryPhotos,
      };
}
