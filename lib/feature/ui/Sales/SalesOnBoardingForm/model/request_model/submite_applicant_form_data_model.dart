import 'package:dio/dio.dart';

class ApplicantFormData {
  final String employeId;
  final String customerId;
  final String fullName;
  final String email;
  final String aadharNo;
  final String mobileNo;
  final String panNo;
  final String gender;
  final String fatherName;
  final String maritalStatus;

  final String spouseName;
  final String motherName;
  final String dob;
  final String religion;
  final String caste;
  final String age;
  final String drivingLicenceNo;
  final String voterIdNo;
  final String education;
  final String permanentAddressaddressLine1;
  final String permanentAddressaddressLine2;
  final String permanentAddresspinCode;
  final String permanentAddresscity;
  final String permanentAddressdistrict;
  final String permanentAddressstate;
  final String localAddressaddressLine1;
  final String localAddressaddressLine2;
  final String localAddresspinCode;
  final String localAddresscity;
  final String localAddressdistrict;
  final String localAddressstate;
  ApplicantFormData({
    required this.employeId,
    required this.customerId,
    required this.fullName,
    required this.email,
    required this.aadharNo,
    required this.mobileNo,
    required this.panNo,
    required this.gender,
    required this.fatherName,
    required this.maritalStatus,

    required this.spouseName,
    required this.motherName,
    required this.dob,
    required this.religion,
    required this.caste,
    required this.age,
    required this.drivingLicenceNo,
    required this.voterIdNo,
    required this.education,
    required this.permanentAddressaddressLine1,
    required this.permanentAddressaddressLine2,
    required this.permanentAddresspinCode,
    required this.permanentAddresscity,
    required this.permanentAddressdistrict,
    required this.permanentAddressstate,
    required this.localAddressaddressLine1,
    required this.localAddressaddressLine2,
    required this.localAddresspinCode,
    required this.localAddresscity,
    required this.localAddressdistrict,
    required this.localAddressstate,
  });

  // Convert model to FormData for Dio
  FormData toFormData() {
    return FormData.fromMap({
      'employeId': employeId,
      'customerId': customerId,
      'fullName': fullName,
      'email': email,
      'aadharNo': aadharNo,
      'mobileNo': mobileNo,
      'panNo': panNo,
      'gender': gender,
      'fatherName': fatherName,
      'maritalStatus': maritalStatus,

      'spouseName': spouseName,
      'motherName': motherName,
      'dob': dob,
      'religion': religion,
      'caste': caste,
      'age': age,
      'drivingLicenceNo': drivingLicenceNo,
      'voterIdNo': voterIdNo,
      'education': education,
      'permanentAddress.addressLine1': permanentAddressaddressLine1,
      'permanentAddress.addressLine2': permanentAddressaddressLine2,
      'permanentAddress.pinCode': permanentAddresspinCode,
      'permanentAddress.city': permanentAddresscity,
      'permanentAddress.district': permanentAddressdistrict,
      'permanentAddress.state': permanentAddressstate,
      'localAddress.addressLine1': localAddressaddressLine1,
      'localAddress.addressLine2': localAddressaddressLine2,
      'localAddress.pinCode': localAddresspinCode,
      'localAddress.city': localAddresscity,
      'localAddress.district': localAddressdistrict,
      'localAddress.state': localAddressstate,
    });
  }
}
