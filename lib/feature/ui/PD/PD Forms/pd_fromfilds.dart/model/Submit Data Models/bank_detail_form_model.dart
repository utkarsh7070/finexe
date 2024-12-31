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
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['subCode'] = this.subCode;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.items != null) {
      data['items'] = this.items!.toJson();
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
        ? new BankDetail.fromJson(json['bankDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['customerId'] = this.customerId;
    data['pdId'] = this.pdId;
    data['pdType'] = this.pdType;
    if (this.bankDetail != null) {
      data['bankDetail'] = this.bankDetail!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountHolderName'] = this.accountHolderName;
    data['nameOfBank'] = this.nameOfBank;
    data['branchName'] = this.branchName;
    data['accountNo'] = this.accountNo;
    data['accountType'] = this.accountType;
    data['IFSCCode'] = this.iFSCCode;
    return data;
  }
}
