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
        ? PropertyItems.fromJson(json['items'])
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
        ? Property.fromJson(json['property'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['approachRoad'] = approachRoad;
    data['front'] = front;
    data['interiorRoad'] = interiorRoad;
    data['leftSide'] = leftSide;
    data['mainRoad'] = mainRoad;
    data['photoWithLatLong'] = photoWithLatLong;
    data['rightSide'] = rightSide;
    data['selfiWithCustomer'] = selfiWithCustomer;
    data['propertyOtherPhotos'] = propertyOtherPhotos;

    data['houseInsidePhoto'] = houseInsidePhoto;
    if (property != null) {
      data['property'] = property!.toJson();
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
        ? CollateralsDetails.fromJson(json['collateralsDetails'])
        : null;
    accommodationDetails = json['accommodationDetails'] != null
        ? AccommodationDetails.fromJson(json['accommodationDetails'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (collateralsDetails != null) {
      data['collateralsDetails'] = collateralsDetails!.toJson();
    }
    if (accommodationDetails != null) {
      data['accommodationDetails'] = accommodationDetails!.toJson();
    }
    data['propertyOwnerName'] = propertyOwnerName;
    data['relationWithApplicant'] = relationWithApplicant;
    data['villageName'] = villageName;
    data['gramPanchayat'] = gramPanchayat;
    data['patwariHalkaNo'] = patwariHalkaNo;
    data['state'] = state;
    data['district'] = district;
    data['tehsil'] = tehsil;
    data['houseNo'] = houseNo;
    data['wardNo'] = wardNo;
    data['surveyNo'] = surveyNo;
    data['TotalBuilUpArea'] = totalBuilUpArea;
    data['qualityOfConstruction'] = qualityOfConstruction;
    data['ageOfProperty'] = ageOfProperty;
    data['MaintenanceOfTheProperty'] = maintenanceOfTheProperty;
    data['ProjectedLifeYear'] = projectedLifeYear;
    data['typeOfContruction'] = typeOfContruction;
    data['landRatePerSQFT'] = landRatePerSQFT;
    data['totalConstruction'] = totalConstruction;
    data['fatherName'] = fatherName;
    data['latitudeOfTheProrty'] = latitudeOfTheProrty;
    data['longitudeOfTheProrty'] = longitudeOfTheProrty;
    data['doorsAndWindowsAreAvailable'] = doorsAndWindowsAreAvailable;
    data['kitchenAndLatBathAvailable'] = kitchenAndLatBathAvailable;
    data['assetSeenAtResidence'] = assetSeenAtResidence;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameOfTheDocumentHolder'] = nameOfTheDocumentHolder;
    data['documentsProvided'] = documentsProvided;
    data['propertyAddress'] = propertyAddress;
    data['landmark'] = landmark;
    data['locationZone'] = locationZone;
    data['availabilityOfLocalTransport'] = availabilityOfLocalTransport;
    data['classOfLocality'] = classOfLocality;
    data['typeOfLocality'] = typeOfLocality;
    data['asPerSite'] = asPerSite;
    data['boundariesMatching'] = boundariesMatching;
    data['statusOfTheLandFlat'] = statusOfTheLandFlat;
    data['typeOfProperty'] = typeOfProperty;
    data['boundariesEast'] = boundariesEast;
    data['boundariesWest'] = boundariesWest;
    data['boundariesNorth'] = boundariesNorth;
    data['boundariesSouth'] = boundariesSouth;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groundFloor'] = groundFloor;
    data['firstFloor'] = firstFloor;
    data['actualUsageOfProperty'] = actualUsageOfProperty;
    data['typeOfStructure'] = typeOfStructure;
    data['locationOfPlot'] = locationOfPlot;
    data['builtUpAreaSft'] = builtUpAreaSft;
    data['occupancy'] = occupancy;
    data['electricityAndGasConnection'] = electricityAndGasConnection;
    data['developmentOfSurroundingArea'] = developmentOfSurroundingArea;
    return data;
  }
}
