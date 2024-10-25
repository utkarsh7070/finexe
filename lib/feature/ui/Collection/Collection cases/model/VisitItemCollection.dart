class ModeOfCollectionDetail {
  final String title;

  ModeOfCollectionDetail({required this.title});

  factory ModeOfCollectionDetail.fromJson(Map<String, dynamic> json) {
    return ModeOfCollectionDetail(
      title: json['title'] as String,
    );
  }
}

class BankNameDetail {
  final String bankName;

  BankNameDetail({required this.bankName});

  factory BankNameDetail.fromJson(Map<String, dynamic> json) {
    return BankNameDetail(
      bankName: json['bankName'] as String,
    );
  }
}

class EmployeeDetail {
  final String employeeName;

  EmployeeDetail({required this.employeeName});

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) {
    return EmployeeDetail(
      employeeName: json['employeName'] as String,
    );
  }
}

/*class VisitItemCollection {
  final String id;
  final String ld;
  final double receivedAmount;
  final String transactionId;
  final String customerEmail;
  final String emiReceivedDate;
  final String status;
  final List<ModeOfCollectionDetail> modeOfCollectionDetail;
  final List<BankNameDetail> bankNameDetail;
  final List<EmployeeDetail> employeeDetail;

  VisitItemCollection({
    required this.id,
    required this.ld,
    required this.receivedAmount,
    required this.transactionId,
    required this.customerEmail,
    required this.emiReceivedDate,
    required this.status,
    required this.modeOfCollectionDetail,
    required this.bankNameDetail,
    required this.employeeDetail,
  });

  factory VisitItemCollection.fromJson(Map<String, dynamic> json) {
    return VisitItemCollection(
      id: json['_id'] as String,
      ld: json['LD'] as String,
      receivedAmount: (json['receivedAmount'] as num).toDouble(),
      transactionId: json['transactionId'] as String,
      customerEmail: json['customerEmail'] as String,
      emiReceivedDate: json['emiReceivedDate'] as String,
      status: json['status'] as String,
      modeOfCollectionDetail: (json['modeOfCollectionDetail'] as List)
          .map((item) => ModeOfCollectionDetail.fromJson(item))
          .toList(),
      bankNameDetail: (json['bankNameDetail'] as List)
          .map((item) => BankNameDetail.fromJson(item))
          .toList(),
      employeeDetail: (json['employeDetail'] as List)
          .map((item) => EmployeeDetail.fromJson(item))
          .toList(),
    );
  }

  String get paymentPerson {
    final mode = modeOfCollectionDetail.isNotEmpty ? modeOfCollectionDetail.first.title : '';
    if (mode == 'okcredit' && employeeDetail.isNotEmpty) {
      return employeeDetail.first.employeeName;
    } else if (mode == 'online' && bankNameDetail.isNotEmpty) {
      return bankNameDetail.first.bankName;
    } else if (mode == 'partner') {
      return 'N/A';
    }
    return 'N/A'; // Default return value if no conditions are met
  }
}*/


class VisitItemCollection {
  final String id;
  final String ld;
  final double receivedAmount;
  final String transactionId;
  final String? customerEmail;
  final String emiReceivedDate;
  final String remarkByCollection;
  final String status;
  final List<ModeOfCollectionDetail>? modeOfCollectionDetail;
  final List<BankNameDetail>? bankNameDetail;
  final List<EmployeeDetail>? employeeDetail;

  VisitItemCollection({
    required this.id,
    required this.ld,
    required this.receivedAmount,
    required this.transactionId,
    this.customerEmail,
    required this.emiReceivedDate,
    required this.remarkByCollection,
    required this.status,
    this.modeOfCollectionDetail,
    this.bankNameDetail,
    this.employeeDetail,
  });

  factory VisitItemCollection.fromJson(Map<String, dynamic> json) {
    return VisitItemCollection(
      id: json['_id'] as String,
      ld: json['LD'] as String,
      receivedAmount: (json['receivedAmount'] as num).toDouble(),
      transactionId: json['transactionId'] as String,
      customerEmail: json['customerEmail'] as String?,
      emiReceivedDate: json['emiReceivedDate'] as String,
      remarkByCollection: json['remarkByCollection'] as String,
      status: json['status'] as String,
      modeOfCollectionDetail: (json['modeOfCollectionDetail'] as List?)
          ?.map((item) => ModeOfCollectionDetail.fromJson(item))
          .toList(),
      bankNameDetail: (json['bankNameDetail'] as List?)
          ?.map((item) => BankNameDetail.fromJson(item))
          .toList(),
      employeeDetail: (json['employeDetail'] as List?)
          ?.map((item) => EmployeeDetail.fromJson(item))
          .toList(),
    );
  }

  /*String get paymentPerson {
    final mode = (modeOfCollectionDetail?.isNotEmpty ?? false)
        ? modeOfCollectionDetail!.first.title
        : '';
    if (mode == 'okcredit' && (employeeDetail?.isNotEmpty ?? false)) {
      return employeeDetail!.first.employeeName;
    } else if (mode == 'online' && (bankNameDetail?.isNotEmpty ?? false)) {
      return bankNameDetail!.first.bankName;
    } else if (mode == 'partner') {
      return 'N/A';
    }
    return 'N/A'; // Default return value if no conditions are met
  }*/

  String get paymentPerson {
    final mode = (modeOfCollectionDetail?.isNotEmpty ?? false)
        ? modeOfCollectionDetail!.first.title
        : '';

    if (mode == 'okcredit' && (employeeDetail?.isNotEmpty ?? false)) {
      return employeeDetail!.first.employeeName;
    } else if (mode == 'online' && (bankNameDetail?.isNotEmpty ?? false)) {
      return bankNameDetail!.first.bankName;
    } else if (mode == 'partner') {
      return 'N/A';
    }

    return 'N/A'; // Default return value if no conditions are met
  }


}
