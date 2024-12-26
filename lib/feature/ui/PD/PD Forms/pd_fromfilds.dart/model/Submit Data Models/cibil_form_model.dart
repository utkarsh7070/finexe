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
    items = json['items'] != null ? CibilItems.fromJson(json['items']) : null;
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

class CibilItems {
  CibilAnalysis? cibilAnalysis;

  CibilItems({this.cibilAnalysis});

  CibilItems.fromJson(Map<String, dynamic> json) {
    cibilAnalysis = json['cibilAnalysis'] != null
        ? CibilAnalysis.fromJson(json['cibilAnalysis'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cibilAnalysis != null) {
      data['cibilAnalysis'] = cibilAnalysis!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TotalLoans'] = totalLoans;
    data['detailsOfCurrentLoans'] = detailsOfCurrentLoans;
    data['reasonforDPD'] = reasonforDPD;
    return data;
  }
}