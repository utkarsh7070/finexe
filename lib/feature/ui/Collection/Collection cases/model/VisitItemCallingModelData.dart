
/*class CallDetailResponse {
  final bool status;
  final int subCode;
  final String message;
  final String error;
  final List<CallDetailItem> items;

  CallDetailResponse({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory CallDetailResponse.fromJson(Map<String, dynamic> json) {
    return CallDetailResponse(
      status: json['status'],
      subCode: json['subCode'],
      message: json['message'],
      error: json['error'],
      items: (json['items'] as List<dynamic>)
          .map((item) => CallDetailItem.fromJson(item))
          .toList(),
    );
  }
}*/

class VisitItemCalling {
  final String id;
  final String ld;
  final String customerName;
  final String callBy;
  final String crmType;
  final String date;
  final String callStatus;
  final String callRemark;
  final String reCallDate;
  final String reCallTime;
  final String customerResponse;
  final int paymentAmount;
  final String reasonForNotPay;
  final String solution;
  final String reasonForCustomerNotContactable;
  final bool newContactNumber;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  VisitItemCalling({
    required this.id,
    required this.ld,
    required this.customerName,
    required this.callBy,
    required this.crmType,
    required this.date,
    required this.callStatus,
    required this.callRemark,
    required this.reCallDate,
    required this.reCallTime,
    required this.customerResponse,
    required this.paymentAmount,
    required this.reasonForNotPay,
    required this.solution,
    required this.reasonForCustomerNotContactable,
    required this.newContactNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory VisitItemCalling.fromJson(Map<String, dynamic> json) {
    return VisitItemCalling(
      id: json['_id'],
      ld: json['LD'],
      customerName: json['customerName'],
      callBy: json['callBy'],
      crmType: json['crmType'],
      date: json['date'],
      callStatus: json['callStatus'],
      callRemark: json['callRemark'],
      reCallDate: json['reCallDate'],
      reCallTime: json['reCallTime'],
      customerResponse: json['customerResponse'],
      paymentAmount: json['paymentAmount'],
      reasonForNotPay: json['reasonForNotPay'] ?? '',
      solution: json['solution'] ?? '',
      reasonForCustomerNotContactable: json['reasonForCustomerNotContactable'] ?? '',
      newContactNumber: json['newContactNumber'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
