class PoliceStationModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  Items? items;

  PoliceStationModel({
    this.status,
    this.subCode,
    this.message,
    this.error,
    this.items,
  });

  PoliceStationModel.fromJson(Map<String, dynamic> json) {
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
  PoliceStation? policeStation; // Holds the entire PoliceStation object
  // Alternatively, you can keep stationName and stationAddress directly if preferred.
  Items({this.policeStation});

  // Factory constructor to create an Items object from JSON
  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      policeStation: json['policeStation'] != null
          ? PoliceStation.fromJson(json['policeStation'])
          : null, // Deserialize the policeStation object if present
    );
  }

  // Method to convert Items object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (policeStation != null) {
      data['policeStation'] = policeStation!.toJson(); // Convert the PoliceStation object to JSON if it exists
    }
    return data;
  }
}

class PoliceStation {
  final String? stationName; // Corrected field name
  final String? stationAddress; // Corrected field name

  PoliceStation({
    required this.stationName,
    required this.stationAddress,
  });

  // Updated factory constructor with correct mapping
  factory PoliceStation.fromJson(Map<String, dynamic> json) {
    return PoliceStation(
      stationName: json['staionName'] as String?, // Map misspelled key
      stationAddress: json['stationAdress'] as String?, // Map misspelled key
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'staionName': stationName, // Use misspelled keys for serialization
      'stationAdress': stationAddress,
    };
  }

  @override
  String toString() {
    return 'PoliceStation(stationName: $stationName, stationAddress: $stationAddress)';
  }
}



