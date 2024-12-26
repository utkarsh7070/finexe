class BankDetailsFormModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  Items? items;

  BankDetailsFormModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  BankDetailsFormModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
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

class Items {
  String? sId;
  String? customerId;
  String? pdId;
  String? pdType;
  BankDetail? bankDetail;

  Items({this.sId, this.customerId, this.pdId, this.pdType, this.bankDetail});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customerId'];
    pdId = json['pdId'];
    pdType = json['pdType'];
    bankDetail = json['bankDetail'] != null
        ? BankDetail.fromJson(json['bankDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customerId'] = customerId;
    data['pdId'] = pdId;
    data['pdType'] = pdType;
    if (bankDetail != null) {
      data['bankDetail'] = bankDetail!.toJson();
    }
    return data;
  }
}

class BankDetail {
  String? accountHolderName;
  String? nameOfBank;
  String? branchName;
  String? accountNo;
  String? accountType;
  String? iFSCCode;

  BankDetail(
      {this.accountHolderName,
      this.nameOfBank,
      this.branchName,
      this.accountNo,
      this.accountType,
      this.iFSCCode});

  BankDetail.fromJson(Map<String, dynamic> json) {
    accountHolderName = json['accountHolderName'];
    nameOfBank = json['nameOfBank'];
    branchName = json['branchName'];
    accountNo = json['accountNo'];
    accountType = json['accountType'];
    iFSCCode = json['IFSCCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountHolderName'] = accountHolderName;
    data['nameOfBank'] = nameOfBank;
    data['branchName'] = branchName;
    data['accountNo'] = accountNo;
    data['accountType'] = accountType;
    data['IFSCCode'] = iFSCCode;
    return data;
  }
}
