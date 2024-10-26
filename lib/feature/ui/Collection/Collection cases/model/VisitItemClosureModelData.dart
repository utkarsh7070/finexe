
/*class VisitItemClosure{
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
}*/

class VisitItemClosure {
  final String id;
  final String ld;
  final String posCloserBy;
  final String customerName;
  final int? mobileNo; // Made nullable
  final int? amountToBeReceivedFromCustomer; // Made nullable
  final String dateOfDeposit;
  final String settlementForReason;
  final double? settlementAmountByApproval; // Changed to double, nullable
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? v; // Made nullable

  VisitItemClosure({
    required this.id,
    required this.ld,
    required this.posCloserBy,
    required this.customerName,
    this.mobileNo,
    this.amountToBeReceivedFromCustomer,
    required this.dateOfDeposit,
    required this.settlementForReason,
    this.settlementAmountByApproval,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.v,
  });

  factory VisitItemClosure.fromJson(Map<String, dynamic> json) {
    try {
      return VisitItemClosure(
        id: json["_id"] ?? '',
        ld: json["LD"] ?? '',
        posCloserBy: json["posCloserBy"] ?? '',
        customerName: json["customerName"] ?? '',
        mobileNo: json["mobileNo"] != null ? int.tryParse(json["mobileNo"].toString()) : null,
        amountToBeReceivedFromCustomer: json["amountToBeReceivedFromCustomer"] != null ? int.tryParse(json["amountToBeReceivedFromCustomer"].toString()) : null,
        dateOfDeposit: json["dateOfDeposit"] ?? '',
        settlementForReason: json["settlementForReason"] ?? '',
        settlementAmountByApproval: json["settlementAmountByApproval"] != null ? (json["settlementAmountByApproval"] as num).toDouble() : null,
        status: json["status"] ?? '',
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
        v: json["__v"] != null ? int.tryParse(json["__v"].toString()) : null,
      );
    } catch (e) {
      print("Error parsing VisitItemClosure: $e");
      throw Exception("Error parsing VisitItemClosure: $e");
    }
  }
}
