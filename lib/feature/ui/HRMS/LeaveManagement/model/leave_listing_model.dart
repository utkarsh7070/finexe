
class CountersModel {
  final int totalLeave;
  final int totalApprove;
  final int totalReject;

  CountersModel({
    required this.totalLeave,
    required this.totalApprove,
    required this.totalReject,
  });

  factory CountersModel.fromJson(Map<String, dynamic> json) {
    return CountersModel(
      totalLeave: json['totalLeave'] ?? 0,
      totalApprove: json['totalApprove'] ?? 0,
      totalReject: json['totalReject'] ?? 0,
    );
  }
}

class LeaveRequestModel {
  final String startDate;
  final String endDate;
  final String reasonForLeave;
  final String approvalByReportingManager;
  final String reasonByReportingManager;

  LeaveRequestModel({
    required this.startDate,
    required this.endDate,
    required this.reasonForLeave,
    required this.approvalByReportingManager,
    required this.reasonByReportingManager,
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestModel(
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      reasonForLeave: json['reasonForLeave'] ?? '',
      approvalByReportingManager: json['approvalByReportingManager'] ?? '',
      reasonByReportingManager: json['reasonByReportingManager'] ?? '',
    );
  }
}
