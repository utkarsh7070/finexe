class VisitItemDetail {
  final String visitDate;
  final String customerResponse;
  final double paymentAmount;
  final String reasonForNotPay;
  final String solution;
  final String reasonForCustomerNotContactable;
  final String status;

  VisitItemDetail({
    required this.visitDate,
    required this.customerResponse,
    required this.paymentAmount,
    required this.reasonForNotPay,
    required this.solution,
    required this.reasonForCustomerNotContactable,
    required this.status,
  });

  factory VisitItemDetail.fromJson(Map<String, dynamic> json) {
    return VisitItemDetail(
      visitDate: json['visitDate'] ?? '',
      customerResponse: json['customerResponse'] ?? '',
     /* paymentAmount: json['paymentAmount'].toDouble() ?? '',*/
      paymentAmount: (json['paymentAmount'] != null)
          ? json['paymentAmount'].toDouble()
          : 0.0, // Default value as 0.0
      reasonForNotPay: json['reasonForNotPay'] ?? '',
      solution: json['solution'] ?? '',
      reasonForCustomerNotContactable: json['reasonForCustomerNotContactable'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
