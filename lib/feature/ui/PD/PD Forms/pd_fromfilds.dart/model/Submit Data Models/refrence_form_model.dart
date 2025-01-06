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
  List<ReferenceDetailListModel>? referenceDetails;

  Items({this.referenceDetails});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['referenceDetails'] != null) {
      referenceDetails = <ReferenceDetailListModel>[];
      json['referenceDetails'].forEach((v) {
        referenceDetails!.add(ReferenceDetailListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (referenceDetails != null) {
      data['referenceDetails'] =
          referenceDetails!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['relation'] = relation;
    data['mobileNumber'] = mobileNumber;
    return data;
  }
}
