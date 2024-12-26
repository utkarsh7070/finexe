class CibilFormModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  CibilItems? items;

  CibilFormModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  CibilFormModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null ? new CibilItems.fromJson(json['items']) : null;
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

class CibilItems {
  CibilAnalysis? cibilAnalysis;

  CibilItems({this.cibilAnalysis});

  CibilItems.fromJson(Map<String, dynamic> json) {
    cibilAnalysis = json['cibilAnalysis'] != null
        ? new CibilAnalysis.fromJson(json['cibilAnalysis'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cibilAnalysis != null) {
      data['cibilAnalysis'] = this.cibilAnalysis!.toJson();
    }
    return data;
  }
}

class CibilAnalysis {
  String? totalLoans;
  String? detailsOfCurrentLoans;
  String? reasonforDPD;

  CibilAnalysis(
      {this.totalLoans, this.detailsOfCurrentLoans, this.reasonforDPD});

  CibilAnalysis.fromJson(Map<String, dynamic> json) {
    totalLoans = json['TotalLoans'];
    detailsOfCurrentLoans = json['detailsOfCurrentLoans'];
    reasonforDPD = json['reasonforDPD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalLoans'] = this.totalLoans;
    data['detailsOfCurrentLoans'] = this.detailsOfCurrentLoans;
    data['reasonforDPD'] = this.reasonforDPD;
    return data;
  }
}