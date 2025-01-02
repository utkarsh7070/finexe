

class LeaveRequestItem {
  final String title;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reasonForLeave;

  LeaveRequestItem({
    required this.title,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reasonForLeave,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "leaveType": leaveType,
      "startDate": startDate,
      "endDate": endDate,
      "reasonForLeave": reasonForLeave,
    };
  }
}

