
class VisitItemClosure{
  final String id;
  final String ld;
  final String posCloserBy;
  final String customerName;
  final int mobileNo;
  final int amountToBeReceivedFromCustomer;
  final String dateOfDeposit;
  final String settlementForReason;
  final int? settlementAmountByApproval;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  VisitItemClosure({
    required this.id,
    required this.ld,
    required this.posCloserBy,
    required this.customerName,
    required this.mobileNo,
    required this.amountToBeReceivedFromCustomer,
    required this.dateOfDeposit,
    required this.settlementForReason,
    this.settlementAmountByApproval,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory VisitItemClosure.fromJson(Map<String, dynamic> json) {
    return VisitItemClosure(
      id: json["_id"],
      ld: json["LD"],
      posCloserBy: json["posCloserBy"],
      customerName: json["customerName"],
      mobileNo: json["mobileNo"],
      amountToBeReceivedFromCustomer: json["amountToBeReceivedFromCustomer"],
      dateOfDeposit: json["dateOfDeposit"],
      settlementForReason: json["settlementForReason"],
      settlementAmountByApproval: json["settlementAmountByApproval"],
      status: json["status"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
    );
  }
}
