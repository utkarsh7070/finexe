// user_profile.dart
class LoginUserProfile {
  final String employeeId;
  final String employeName;
  final String email;
  final int mobileNo;
  final String joiningDate;
  final String dateOfBirth;
  final String fatherName;
  final String employeePhoto;
  final String employeUniqueId;

  LoginUserProfile({
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

  factory LoginUserProfile.fromJson(Map<String, dynamic> json) {
    return LoginUserProfile(
      employeeId: json['_id'] ?? '',
      employeName: json['employeName'] ?? '',
      email: json['email'] ?? '',
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
