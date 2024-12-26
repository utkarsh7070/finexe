class AssetFormModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  Items? items;

  AssetFormModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  AssetFormModel.fromJson(Map<String, dynamic> json) {
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
  String? customerId;
  String? pdType;
  Total? total;
  List<AssetDetails>? assetDetails;

  Items({this.customerId, this.pdType, this.total, this.assetDetails});

  Items.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    pdType = json['pdType'];
    total = json['total'] != null ? Total.fromJson(json['total']) : null;
    if (json['assetDetails'] != null) {
      assetDetails = <AssetDetails>[];
      json['assetDetails'].forEach((v) {
        assetDetails!.add(AssetDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['pdType'] = pdType;
    if (total != null) {
      data['total'] = total!.toJson();
    }
    if (assetDetails != null) {
      data['assetDetails'] = assetDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Total {
  int? totalPurchaseValue;
  int? totalMarketValue;

  Total({this.totalPurchaseValue, this.totalMarketValue});

  Total.fromJson(Map<String, dynamic> json) {
    totalPurchaseValue = json['totalPurchaseValue'];
    totalMarketValue = json['totalMarketValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPurchaseValue'] = totalPurchaseValue;
    data['totalMarketValue'] = totalMarketValue;
    return data;
  }
}

class AssetDetails {
  String? name;
  String? purchaseValue;
  String? marketValue;
  // String? sId;

  AssetDetails({this.name, this.purchaseValue, this.marketValue});

  AssetDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    purchaseValue = json['purchaseValue'];
    marketValue = json['marketValue'];
    // sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['purchaseValue'] = purchaseValue;
    data['marketValue'] = marketValue;
    // data['_id'] = this.sId;
    return data;
  }
}
