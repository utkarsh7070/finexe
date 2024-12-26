

class LeaveRequestItem {
  final String startDate;
  final String endDate;
  final String reasonForLeave;

  LeaveRequestItem({
    required this.startDate,
    required this.endDate,
    required this.reasonForLeave,
  });

  Map<String, dynamic> toJson() {
    return {
      "startDate": startDate,
      "endDate": endDate,
      "reasonForLeave": reasonForLeave,
    };
  }
}

