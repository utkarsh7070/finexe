

import 'package:intl/intl.dart';

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }
}

class EmployeeDetail {
  final String id;
  final String employeName;
  final String userName;
  final String email;
  final String workEmail;
  final String mobileNo;
  final String fatherName;
  final String employeePhoto;
  final String currentAddress;
  final String employeUniqueId;
  final Location location;
  final String joiningDate;

  EmployeeDetail({
    required this.id,
    required this.employeName,
    required this.userName,
    required this.email,
    required this.workEmail,
    required this.mobileNo,
    required this.fatherName,
    required this.employeePhoto,
    required this.currentAddress,
    required this.employeUniqueId,
    required this.location,
    required this.joiningDate,
  });

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) {
    return EmployeeDetail(
      id: json['_id'],
      employeName: json['employeName'],
      userName: json['userName'],
      email: json['email'],
      workEmail: json['workEmail'],
      mobileNo: json['mobileNo'].toString(),
      fatherName: json['fatherName'],
      employeePhoto: json['employeePhoto'],
      currentAddress: json['currentAddress'],
      employeUniqueId: json['employeUniqueId'],
      location: Location.fromJson(json['location']),
        joiningDate: json['joiningDate'],
    );
  }

  String get formattedJoiningDate {
    // Parse the joiningDate string to DateTime
    DateTime dateTime = DateTime.parse(joiningDate);

    // Format the DateTime to dd/mm/yyyy
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

}

class ApiResponse {
  final bool status;
  final int subCode;
  final String message;
  final String error;
  final EmployeeDetail employeeDetail;
  final int totalVisits;
  final int totalNetDueAmount;
  final int visitPendingForApproval;
  final int visitAccepted;
  final int visitRejected;
  final int collectionEmiAmountPendingForApproval;
  final int collectionAcceptAmount;
  final int collectionRejectAmount;
 // final String joiningDate;

  ApiResponse({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.employeeDetail,
    required this.totalVisits,
    required this.totalNetDueAmount,
    required this.visitPendingForApproval,
    required this.visitAccepted,
    required this.visitRejected,
    required this.collectionEmiAmountPendingForApproval,
    required this.collectionAcceptAmount,
    required this.collectionRejectAmount,
   // required this.joiningDate,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      subCode: json['subCode'],
      message: json['message'],
      error: json['error'],
      employeeDetail: EmployeeDetail.fromJson(json['items']['employeeDetail']),
      totalVisits: json['items']['totalVisits'],
      totalNetDueAmount: json['items']['totalNetDueAmount'],
      visitPendingForApproval: json['items']['visitPendingForApproval'],
      visitAccepted: json['items']['visitAccepted'],
      visitRejected: json['items']['visitRejected'],
      collectionEmiAmountPendingForApproval:
      json['items']['collectionEmiAmountPendingForApproval'],
      collectionAcceptAmount: json['items']['collectionAcceptAmount'],
      collectionRejectAmount: json['items']['collectionRejectAmount'],
     // joiningDate: json['items']['joiningDate'],
    );
  }
}
