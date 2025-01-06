class PDRequestListModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  List<PDReqItems>? items;

  PDRequestListModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  PDRequestListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    if (json['items'] != null) {
      items = <PDReqItems>[];
      json['items'].forEach((v) {
        items!.add(PDReqItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['subCode'] = subCode;
    data['message'] = message;
    data['error'] = error;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PDReqItems {
  String? sId;
  String? customerId;
  String? externalVendorId;
  String? partnerNameId;
  String? creditPdId;
  String? remarkForCreditPd;
  String? pdfCreateByCreditPd;
  String? statusByCreditPd;
  String? remarkByCreditPd;
  BranchDetails? branchDetails;
  ApplicantDetails? applicantDetails;
  String? customerFinId;
  String? customerName;
  int? customerMobileNo;
  String? customerFatherName;
  String? customerPhoto;
  String? customerAddress;

  PDReqItems(
      {this.sId,
      this.customerId,
      this.externalVendorId,
      this.partnerNameId,
      this.creditPdId,
      this.remarkForCreditPd,
      this.pdfCreateByCreditPd,
      this.statusByCreditPd,
      this.remarkByCreditPd,
      this.branchDetails,
      this.applicantDetails,
      this.customerFinId,
      this.customerName,
      this.customerMobileNo,
      this.customerFatherName,
      this.customerPhoto,
      this.customerAddress});

  PDReqItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customerId'];
    externalVendorId = json['externalVendorId'];
    partnerNameId = json['partnerNameId'];
    creditPdId = json['creditPdId'];
    remarkForCreditPd = json['remarkForCreditPd'];
    pdfCreateByCreditPd = json['pdfCreateByCreditPd'];
    statusByCreditPd = json['statusByCreditPd'];
    remarkByCreditPd = json['remarkByCreditPd'];
    branchDetails = json['branchDetails'] != null
        ? BranchDetails.fromJson(json['branchDetails'])
        : null;
    applicantDetails = json['applicantDetails'] != null
        ? ApplicantDetails.fromJson(json['applicantDetails'])
        : null;
    customerFinId = json['customerFinId'];
    customerName = json['customerName'];
    customerMobileNo = json['customerMobileNo'];
    customerFatherName = json['customerFatherName'];
    customerPhoto = json['customerPhoto'];
    customerAddress = json['customerAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customerId'] = customerId;
    data['externalVendorId'] = externalVendorId;
    data['partnerNameId'] = partnerNameId;
    data['creditPdId'] = creditPdId;
    data['remarkForCreditPd'] = remarkForCreditPd;
    data['pdfCreateByCreditPd'] = pdfCreateByCreditPd;
    data['statusByCreditPd'] = statusByCreditPd;
    data['remarkByCreditPd'] = remarkByCreditPd;
    if (branchDetails != null) {
      data['branchDetails'] = branchDetails!.toJson();
    }
    if (applicantDetails != null) {
      data['applicantDetails'] = applicantDetails!.toJson();
    }
    data['customerFinId'] = customerFinId;
    data['customerName'] = customerName;
    data['customerMobileNo'] = customerMobileNo;
    data['customerFatherName'] = customerFatherName;
    data['customerPhoto'] = customerPhoto;
    data['customerAddress'] = customerAddress;
    return data;
  }
}

class BranchDetails {
  String? sId;
  String? name;

  BranchDetails({this.sId, this.name});

  BranchDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class ApplicantDetails {
  String? sId;
  String? fullName;
  String? email;

  ApplicantDetails({this.sId, this.fullName, this.email});

  ApplicantDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['email'] = email;
    return data;
  }
}
