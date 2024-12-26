// user_profile.dart
class HRMSUserProfile {
  final String employeeId;
  final String employeName;
  final String email;
  final int mobileNo;
  final String joiningDate;
  final String dateOfBirth;
  final String fatherName;
  final String employeePhoto;
  final String employeUniqueId;
  final String punchInTime;
  final String punchOutTime;


  HRMSUserProfile({
    required this.punchInTime,
    required this.punchOutTime,
    required this.employeeId,
    required this.employeName,
    required this.email,
    required this.mobileNo,
    required this.joiningDate,
    required this.dateOfBirth,
    required this.fatherName,
    required this.employeePhoto,
    required this.employeUniqueId,
  });

  factory HRMSUserProfile.fromJson(Map<String, dynamic> json) {
    return HRMSUserProfile(
      punchInTime: json['punchInTime'] ?? '',
      punchOutTime: json['punchOutTime'] ?? '',
      employeeId: json['_id'] ?? '',
      employeName: json['employeName'] ?? '',
      email: json['workEmail'] ?? '',
      mobileNo: json['mobileNo'] ?? 0,
      joiningDate: json['joiningDate'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      fatherName: json['fatherName'] ?? '',
      employeePhoto: json['employeePhoto'] ?? '',
      employeUniqueId: json['employeUniqueId'] ?? '',
    );
  }

  String get fullName => '$employeName $fatherName';
}
