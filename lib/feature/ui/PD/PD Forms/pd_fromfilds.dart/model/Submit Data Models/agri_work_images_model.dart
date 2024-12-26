class AgriCultureAndWorkImageModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  AgriWorkItems? items;

  AgriCultureAndWorkImageModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  AgriCultureAndWorkImageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null
        ? AgriWorkItems.fromJson(json['items'])
        : null;
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

class AgriWorkItems {
  List<String>? fourBoundaryPhotos;
  List<String>? workPhotos;

  String? videoUpload;
  String? landmarkPhoto;
  String? latLongPhoto;

  AgriWorkItems(
      {this.fourBoundaryPhotos,
      this.workPhotos,
      this.videoUpload,
      this.landmarkPhoto,
      this.latLongPhoto});

  // AgriWorkItems.fromJson(Map<String, dynamic> json) {
  //   fourBoundaryPhotos = json['fourBoundaryPhotos'].cast<String>();
  //   workPhotos = json['workPhotos'].cast<String>();
  //   videoUpload = json['videoUpload'];
  //   landmarkPhoto = json['landmarkPhoto'];
  //   latLongPhoto = json['latLongPhoto'];
  // }
  AgriWorkItems.fromJson(Map<String, dynamic> json) {
    fourBoundaryPhotos = (json['fourBoundaryPhotos'] as List?)
            ?.map((item) => item.toString())
            .toList() ??
        []; // Provide a default empty list
    workPhotos = (json['workPhotos'] as List?)
            ?.map((item) => item.toString())
            .toList() ??
        []; // Provide a default empty list,

    videoUpload = json['videoUpload'] as String?;
    landmarkPhoto = json['landmarkPhoto'] as String?;
    latLongPhoto = json['latLongPhoto'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fourBoundaryPhotos'] = fourBoundaryPhotos;
    data['workPhotos'] = workPhotos;
    data['videoUpload'] = videoUpload;
    data['landmarkPhoto'] = landmarkPhoto;
    data['latLongPhoto'] = latLongPhoto;
    return data;
  }
}
