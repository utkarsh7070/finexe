
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
  final String id;
  final String startDate;
  final String endDate;
  final String reasonForLeave;
  final String approvalByReportingManager;
  final String reasonByReportingManager;
  final String reportingManagerName;
  final String? title;
  final String? leaveType;


  LeaveRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reasonForLeave,
    required this.approvalByReportingManager,
    required this.reasonByReportingManager,
    required this.reportingManagerName,
    this.title,
    this.leaveType, // Use LeaveType here
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    print(' leave type json ?????????${json.toString()}');
   // print(' leave type ?????????${json['leaveType'][0]}');
    return LeaveRequestModel(

      id: json['_id'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      reasonForLeave: json['reasonForLeave'] ?? '',
      approvalByReportingManager: json['approvalByReportingManager'] ?? '',
      reasonByReportingManager: json['reasonByReportingManager'] ?? '',
      reportingManagerName: json['reportingManagerId']?['employeName'] ?? 'N/A', // Parse employeName
      title: json['title'] ?? '',
     // leaveType: json['leaveType']?['leaveType']??'', // Parse employeName
      leaveType: json['leaveType'] != null && json['leaveType']['leaveTypeName'] != null
          ? json['leaveType']['leaveTypeName']
          : 'N/A', // Fallback to 'N/A' if leaveType is missing

      // leaveType: json['leaveType']==null?'':json['leaveType']['leaveType']??''
       // Parse the nested leaveType object
    );
  }

 /* factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {

    print('reportingManagerName: ${json['reportingManagerId']?['employeName']}');
    print('leave: ${json['leaveType']?['leaveTypeName']}');

    print('leave type json: ${json.toString()}');

    String leaveType = 'N/A';

    // Debugging: Check type of leaveType field
    if (json['leaveType'] is Map) {
      print('leaveType is a Map: ${json['leaveType']}');
      leaveType = json['leaveType']['leaveTypeName'] ?? 'N/A';
    } else if (json['leaveType'] is String) {
      print('leaveType is a String: ${json['leaveType']}');
      leaveType = json['leaveType'];
    } else {
      print('leaveType is of unexpected type: ${json['leaveType'].runtimeType}');
    }

    return LeaveRequestModel(
      id: json['_id'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      reasonForLeave: json['reasonForLeave'] ?? '',
      approvalByReportingManager: json['approvalByReportingManager'] ?? '',
      reasonByReportingManager: json['reasonByReportingManager'] ?? '',
      reportingManagerName: json['reportingManagerId']?['employeName'] ?? 'N/A',
      title: json['title'] ?? '',
      leaveType: leaveType,
    );
  }*/


}

/*class LeaveRequestModel {
  final String id;
  final String startDate;
  final String endDate;
  final String reasonForLeave;
  final String approvalByReportingManager;
  final String reasonByReportingManager;
  final String reportingManagerName;
  final String title;
  final LeaveType leaveType;

  LeaveRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reasonForLeave,
    required this.approvalByReportingManager,
    required this.reasonByReportingManager,
    required this.reportingManagerName,
    required this.title,
    required this.leaveType,
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    dynamic leaveTypeData = json['leaveType'];

    LeaveType leaveType = (leaveTypeData is Map<String, dynamic>)
        ? LeaveType.fromJson(leaveTypeData as Map<String, dynamic>)
        : LeaveType(id: '', leaveType: (leaveTypeData ?? 'N/A').toString());

    return LeaveRequestModel(
      id: json['_id'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      reasonForLeave: json['reasonForLeave'] ?? '',
      approvalByReportingManager: json['approvalByReportingManager'] ?? '',
      reasonByReportingManager: json['reasonByReportingManager'] ?? '',
      reportingManagerName: json['employeeId']?['employeName'] ?? 'N/A',
      title: json['title'] ?? 'N/A',
      leaveType: leaveType,
    );
  }
}

class LeaveType {
  final String id;
  final String leaveType;

  LeaveType({required this.id, required this.leaveType});

  factory LeaveType.fromJson(Map<String, dynamic> json) {
    return LeaveType(
      id: json['_id'] ?? '',
      leaveType: json['leaveType'] ?? 'N/A',
    );
  }
}*/



