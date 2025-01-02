class PropertyFormModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  PropertyItems? items;

  PropertyFormModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  PropertyFormModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null
        ? new PropertyItems.fromJson(json['items'])
        : null;
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

class PropertyItems {
  String? approachRoad;
  String? front;
  String? interiorRoad;
  String? leftSide;
  String? mainRoad;
  String? photoWithLatLong;
  String? rightSide;
  String? selfiWithCustomer;
  List<String>? propertyOtherPhotos;
  List<String>? houseInsidePhoto;
  Property? property;

  PropertyItems(
      {this.approachRoad,
      this.front,
      this.interiorRoad,
      this.leftSide,
      this.mainRoad,
      this.photoWithLatLong,
      this.rightSide,
      this.selfiWithCustomer,
      this.propertyOtherPhotos,
      this.houseInsidePhoto,
      this.property});

  PropertyItems.fromJson(Map<String, dynamic> json) {
    approachRoad = json['approachRoad'];
    front = json['front'];
    interiorRoad = json['interiorRoad'];
    leftSide = json['leftSide'];
    mainRoad = json['mainRoad'];
    photoWithLatLong = json['photoWithLatLong'];
    rightSide = json['rightSide'];
    selfiWithCustomer = json['selfiWithCustomer'];
    property = json['property'] != null
        ? new Property.fromJson(json['property'])
        : null;
    propertyOtherPhotos = (json['propertyOtherPhotos'] as List?)
            ?.map((item) => item.toString())
            .toList() ??
        [];
    houseInsidePhoto = (json['houseInsidePhoto'] as List?)
            ?.map((item) => item.toString())
            .toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approachRoad'] = this.approachRoad;
    data['front'] = this.front;
    data['interiorRoad'] = this.interiorRoad;
    data['leftSide'] = this.leftSide;
    data['mainRoad'] = this.mainRoad;
    data['photoWithLatLong'] = this.photoWithLatLong;
    data['rightSide'] = this.rightSide;
    data['selfiWithCustomer'] = this.selfiWithCustomer;
    data['propertyOtherPhotos'] = this.propertyOtherPhotos;

    data['houseInsidePhoto'] = this.houseInsidePhoto;
    if (this.property != null) {
      data['property'] = this.property!.toJson();
    }
    return data;
  }
}

class Property {
  CollateralsDetails? collateralsDetails;
  AccommodationDetails? accommodationDetails;
  String? propertyOwnerName;
  String? relationWithApplicant;
  String? villageName;
  String? gramPanchayat;
  String? patwariHalkaNo;
  String? state;
  String? district;
  String? tehsil;
  String? houseNo;
  String? wardNo;
  String? surveyNo;
  String? totalBuilUpArea;
  String? qualityOfConstruction;
  String? ageOfProperty;
  String? maintenanceOfTheProperty;
  String? projectedLifeYear;
  String? typeOfContruction;
  String? landRatePerSQFT;
  String? totalConstruction;
  String? fatherName;
  String? latitudeOfTheProrty;
  String? longitudeOfTheProrty;
  String? doorsAndWindowsAreAvailable;
  String? kitchenAndLatBathAvailable;
  List<String>? assetSeenAtResidence;

  Property(
      {this.collateralsDetails,
      this.accommodationDetails,
      this.propertyOwnerName,
      this.relationWithApplicant,
      this.villageName,
      this.gramPanchayat,
      this.patwariHalkaNo,
      this.state,
      this.district,
      this.tehsil,
      this.houseNo,
      this.wardNo,
      this.surveyNo,
      this.totalBuilUpArea,
      this.qualityOfConstruction,
      this.ageOfProperty,
      this.maintenanceOfTheProperty,
      this.projectedLifeYear,
      this.typeOfContruction,
      this.landRatePerSQFT,
      this.totalConstruction,
      this.fatherName,
      this.latitudeOfTheProrty,
      this.longitudeOfTheProrty,
      this.doorsAndWindowsAreAvailable,
      this.kitchenAndLatBathAvailable,
      this.assetSeenAtResidence});

  Property.fromJson(Map<String, dynamic> json) {
    collateralsDetails = json['collateralsDetails'] != null
        ? new CollateralsDetails.fromJson(json['collateralsDetails'])
        : null;
    accommodationDetails = json['accommodationDetails'] != null
        ? new AccommodationDetails.fromJson(json['accommodationDetails'])
        : null;
    propertyOwnerName = json['propertyOwnerName'];
    relationWithApplicant = json['relationWithApplicant'];
    villageName = json['villageName'];
    gramPanchayat = json['gramPanchayat'];
    patwariHalkaNo = json['patwariHalkaNo'];
    state = json['state'];
    district = json['district'];
    tehsil = json['tehsil'];
    houseNo = json['houseNo'];
    wardNo = json['wardNo'];
    surveyNo = json['surveyNo'];
    totalBuilUpArea = json['TotalBuilUpArea'];
    qualityOfConstruction = json['qualityOfConstruction'];
    ageOfProperty = json['ageOfProperty'];
    maintenanceOfTheProperty = json['MaintenanceOfTheProperty'];
    projectedLifeYear = json['ProjectedLifeYear'];
    typeOfContruction = json['typeOfContruction'];
    landRatePerSQFT = json['landRatePerSQFT'];
    totalConstruction = json['totalConstruction'];
    fatherName = json['fatherName'];
    latitudeOfTheProrty = json['latitudeOfTheProrty'];
    longitudeOfTheProrty = json['longitudeOfTheProrty'];
    doorsAndWindowsAreAvailable = json['doorsAndWindowsAreAvailable'];
    kitchenAndLatBathAvailable = json['kitchenAndLatBathAvailable'];
    // assetSeenAtResidence = json['assetSeenAtResidence'].cast<String>();
    // Safely handle assetSeenAtResidence
    assetSeenAtResidence = json['assetSeenAtResidence'] != null
        ? List<String>.from(json['assetSeenAtResidence'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collateralsDetails != null) {
      data['collateralsDetails'] = this.collateralsDetails!.toJson();
    }
    if (this.accommodationDetails != null) {
      data['accommodationDetails'] = this.accommodationDetails!.toJson();
    }
    data['propertyOwnerName'] = this.propertyOwnerName;
    data['relationWithApplicant'] = this.relationWithApplicant;
    data['villageName'] = this.villageName;
    data['gramPanchayat'] = this.gramPanchayat;
    data['patwariHalkaNo'] = this.patwariHalkaNo;
    data['state'] = this.state;
    data['district'] = this.district;
    data['tehsil'] = this.tehsil;
    data['houseNo'] = this.houseNo;
    data['wardNo'] = this.wardNo;
    data['surveyNo'] = this.surveyNo;
    data['TotalBuilUpArea'] = this.totalBuilUpArea;
    data['qualityOfConstruction'] = this.qualityOfConstruction;
    data['ageOfProperty'] = this.ageOfProperty;
    data['MaintenanceOfTheProperty'] = this.maintenanceOfTheProperty;
    data['ProjectedLifeYear'] = this.projectedLifeYear;
    data['typeOfContruction'] = this.typeOfContruction;
    data['landRatePerSQFT'] = this.landRatePerSQFT;
    data['totalConstruction'] = this.totalConstruction;
    data['fatherName'] = this.fatherName;
    data['latitudeOfTheProrty'] = this.latitudeOfTheProrty;
    data['longitudeOfTheProrty'] = this.longitudeOfTheProrty;
    data['doorsAndWindowsAreAvailable'] = this.doorsAndWindowsAreAvailable;
    data['kitchenAndLatBathAvailable'] = this.kitchenAndLatBathAvailable;
    data['assetSeenAtResidence'] = this.assetSeenAtResidence;
    return data;
  }
}

class CollateralsDetails {
  String? nameOfTheDocumentHolder;
  String? documentsProvided;
  String? propertyAddress;
  String? landmark;
  String? locationZone;
  String? availabilityOfLocalTransport;
  String? classOfLocality;
  String? typeOfLocality;
  String? asPerSite;
  String? boundariesMatching;
  String? statusOfTheLandFlat;
  String? typeOfProperty;
  String? boundariesEast;
  String? boundariesWest;
  String? boundariesNorth;
  String? boundariesSouth;

  CollateralsDetails(
      {this.nameOfTheDocumentHolder,
      this.documentsProvided,
      this.propertyAddress,
      this.landmark,
      this.locationZone,
      this.availabilityOfLocalTransport,
      this.classOfLocality,
      this.typeOfLocality,
      this.asPerSite,
      this.boundariesMatching,
      this.statusOfTheLandFlat,
      this.typeOfProperty,
      this.boundariesEast,
      this.boundariesWest,
      this.boundariesNorth,
      this.boundariesSouth});

  CollateralsDetails.fromJson(Map<String, dynamic> json) {
    nameOfTheDocumentHolder = json['nameOfTheDocumentHolder'];
    documentsProvided = json['documentsProvided'];
    propertyAddress = json['propertyAddress'];
    landmark = json['landmark'];
    locationZone = json['locationZone'];
    availabilityOfLocalTransport = json['availabilityOfLocalTransport'];
    classOfLocality = json['classOfLocality'];
    typeOfLocality = json['typeOfLocality'];
    asPerSite = json['asPerSite'];
    boundariesMatching = json['boundariesMatching'];
    statusOfTheLandFlat = json['statusOfTheLandFlat'];
    typeOfProperty = json['typeOfProperty'];
    boundariesEast = json['boundariesEast'];
    boundariesWest = json['boundariesWest'];
    boundariesNorth = json['boundariesNorth'];
    boundariesSouth = json['boundariesSouth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameOfTheDocumentHolder'] = this.nameOfTheDocumentHolder;
    data['documentsProvided'] = this.documentsProvided;
    data['propertyAddress'] = this.propertyAddress;
    data['landmark'] = this.landmark;
    data['locationZone'] = this.locationZone;
    data['availabilityOfLocalTransport'] = this.availabilityOfLocalTransport;
    data['classOfLocality'] = this.classOfLocality;
    data['typeOfLocality'] = this.typeOfLocality;
    data['asPerSite'] = this.asPerSite;
    data['boundariesMatching'] = this.boundariesMatching;
    data['statusOfTheLandFlat'] = this.statusOfTheLandFlat;
    data['typeOfProperty'] = this.typeOfProperty;
    data['boundariesEast'] = this.boundariesEast;
    data['boundariesWest'] = this.boundariesWest;
    data['boundariesNorth'] = this.boundariesNorth;
    data['boundariesSouth'] = this.boundariesSouth;
    return data;
  }
}

class AccommodationDetails {
  String? groundFloor;
  String? firstFloor;
  String? actualUsageOfProperty;
  String? typeOfStructure;
  String? locationOfPlot;
  String? builtUpAreaSft;
  String? occupancy;
  String? electricityAndGasConnection;
  String? developmentOfSurroundingArea;

  AccommodationDetails(
      {this.groundFloor,
      this.firstFloor,
      this.actualUsageOfProperty,
      this.typeOfStructure,
      this.locationOfPlot,
      this.builtUpAreaSft,
      this.occupancy,
      this.electricityAndGasConnection,
      this.developmentOfSurroundingArea});

  AccommodationDetails.fromJson(Map<String, dynamic> json) {
    groundFloor = json['groundFloor'];
    firstFloor = json['firstFloor'];
    actualUsageOfProperty = json['actualUsageOfProperty'];
    typeOfStructure = json['typeOfStructure'];
    locationOfPlot = json['locationOfPlot'];
    builtUpAreaSft = json['builtUpAreaSft'];
    occupancy = json['occupancy'];
    electricityAndGasConnection = json['electricityAndGasConnection'];
    developmentOfSurroundingArea = json['developmentOfSurroundingArea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groundFloor'] = this.groundFloor;
    data['firstFloor'] = this.firstFloor;
    data['actualUsageOfProperty'] = this.actualUsageOfProperty;
    data['typeOfStructure'] = this.typeOfStructure;
    data['locationOfPlot'] = this.locationOfPlot;
    data['builtUpAreaSft'] = this.builtUpAreaSft;
    data['occupancy'] = this.occupancy;
    data['electricityAndGasConnection'] = this.electricityAndGasConnection;
    data['developmentOfSurroundingArea'] = this.developmentOfSurroundingArea;
    return data;
  }
}
