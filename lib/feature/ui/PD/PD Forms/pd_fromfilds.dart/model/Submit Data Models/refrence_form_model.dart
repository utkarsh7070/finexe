class RefrenceDetailModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  Items? items;

  RefrenceDetailModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  RefrenceDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<ReferenceDetailListModel>? referenceDetails;

  Items({this.referenceDetails});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['referenceDetails'] != null) {
      referenceDetails = <ReferenceDetailListModel>[];
      json['referenceDetails'].forEach((v) {
        referenceDetails!.add(new ReferenceDetailListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referenceDetails != null) {
      data['referenceDetails'] =
          this.referenceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferenceDetailListModel {
  String? name;
  String? address;
  String? relation;
  String? mobileNumber;

  ReferenceDetailListModel(
      {this.name, this.address, this.relation, this.mobileNumber});

  ReferenceDetailListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    relation = json['relation'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['relation'] = this.relation;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}
