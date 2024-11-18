

class AttendanceResponse {
  final bool status;
  final int subCode;
  final String message;
  final String error;
  final AttendanceItems? items; // Make this nullable

  AttendanceResponse({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    this.items, // Nullable field
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      status: json['status'],
      subCode: json['subCode'],
      message: json['message'],
      error: json['error'],
      items: json['items'] != null ? AttendanceItems.fromJson(json['items']) : null,
    );
  }
}

class AttendanceItems {
  final int year;
  final int month;
  final int presentDays;
  final int monthDays;
  final int absentDays;
  final EmployeeDetail employeeDetail;
  final List<AttendanceRecord> attendanceRecords;

  AttendanceItems({
    required this.year,
    required this.month,
    required this.presentDays,
    required this.monthDays,
    required this.absentDays,
    required this.employeeDetail,
    required this.attendanceRecords,
  });

  factory AttendanceItems.fromJson(Map<String, dynamic> json) {
    return AttendanceItems(
      year: json['year'],
      month: json['month'],
      presentDays: json['presentDays'],
      monthDays: json['monthDays'],
      absentDays: json['absentDays'],
      employeeDetail: EmployeeDetail.fromJson(json['employeeDetail']),
      attendanceRecords: (json['attendanceRecords'] as List)
          .map((e) => AttendanceRecord.fromJson(e))
          .toList(),
    );
  }
}

class EmployeeDetail {
  final String id;
  final String employeName;
  final String email;
  final String mobileNo;
  final String currentAddress;
  final String permanentAddress;
  final String status;

  EmployeeDetail({
    required this.id,
    required this.employeName,
    required this.email,
    required this.mobileNo,
    required this.currentAddress,
    required this.permanentAddress,
    required this.status,
  });

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) {
    return EmployeeDetail(
      id: json['_id'],
      employeName: json['employeName'],
      email: json['email'],
      mobileNo: json['mobileNo'].toString(),
      currentAddress: json['currentAddress'],
      permanentAddress: json['permanentAddress'],
      status: json['status'],
    );
  }
}

class AttendanceRecord {
  final String id;
  final String date;
  final String? punchInTime;
  final String? punchOutTime;

  AttendanceRecord({
    required this.id,
    required this.date,
    this.punchInTime,
    this.punchOutTime,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['_id'],
      date: json['date'],
      punchInTime: json['punchInTime'],
      punchOutTime: json['punchOutTime'],
    );
  }
}
