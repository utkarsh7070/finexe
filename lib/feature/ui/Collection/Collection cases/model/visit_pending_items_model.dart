class ItemsDetails {
  String? ld;
  String? loanNo;
  String? branch;
  String? customerName;
  String? fatherName;
  String? mobile;
  String? salesPerson;
  String? salesManager;
  String? allocatedBranch;
  String? village;
  String? address;
  String? partner;
  String? mode;
  String? emiAmount;
  String? oldDue;
  String? netDue;
  String? collectionType;
  String? lat;
  String? longValue;
  String? allocation1EmpId;
  String? posClosureAmount;
  String? allocation2EmpId;
  String? name;
  String? allocation3EmpId;
  String? allocation4EmpId;
  String? manager;
  String? clusterManager;
  String? regionalManager;
  String? crmPerson;
  String? crmBranch;
  String? emiReceivedDate1;
  String? receivedAmount1;
  String? collectedBy1;
  String? receivedIn1;
  String? emiReceivedDate2;
  String? receivedAmount2;
  String? collectedBy2;
  String? receivedIn2;
  String? emiReceivedDate3;
  String? receivedAmount3;
  String? collectedBy3;
  String? visitDate1;
  String? remarks1;
  String? visitedBy;
  String? coBorrower1Name;
  String? coBorrower1Mobile;
  String? coBorrower1Address;
  String? gtrName;
  String? gtrFatherName;
  String? gtrAddress;
  String? gtrMobNo;
  String? auClearance;
  String? caseIn;
  String? status;

  ItemsDetails({
    this.ld,
    this.loanNo,
    this.branch,
    this.customerName,
    this.fatherName,
    this.mobile,
    this.salesPerson,
    this.salesManager,
    this.allocatedBranch,
    this.village,
    this.address,
    this.partner,
    this.mode,
    this.emiAmount,
    this.oldDue,
    this.netDue,
    this.collectionType,
    this.lat,
    this.longValue,
    this.allocation1EmpId,
    this.posClosureAmount,
    this.allocation2EmpId,
    this.name,
    this.allocation3EmpId,
    this.allocation4EmpId,
    this.manager,
    this.clusterManager,
    this.regionalManager,
    this.crmPerson,
    this.crmBranch,
    this.emiReceivedDate1,
    this.receivedAmount1,
    this.collectedBy1,
    this.receivedIn1,
    this.emiReceivedDate2,
    this.receivedAmount2,
    this.collectedBy2,
    this.receivedIn2,
    this.emiReceivedDate3,
    this.receivedAmount3,
    this.collectedBy3,
    this.visitDate1,
    this.remarks1,
    this.visitedBy,
    this.coBorrower1Name,
    this.coBorrower1Mobile,
    this.coBorrower1Address,
    this.gtrName,
    this.gtrFatherName,
    this.gtrAddress,
    this.gtrMobNo,
    this.auClearance,
    this.caseIn,
    this.status,
  });

  // Factory constructor to create a LoanDetails instance from JSON
  factory ItemsDetails.fromJson(Map<String, String> json) {
    return ItemsDetails(
      ld: json['LD'],
      loanNo: json['LOAN NO .'],
      branch: json['BRANCH'],
      customerName: json['CUSTOMER NAME '],
      fatherName: json['FATHER NAME '],
      mobile: json['MOBILE'],
      salesPerson: json['SALES PERSON'],
      salesManager: json['SALES MANAGER'],
      allocatedBranch: json['ALLOCATED BRANCH'],
      village: json['VILLAGE'],
      address: json['ADDRESS'],
      partner: json['PATNER'],
      mode: json['MODE'],
      emiAmount: json['EMI AMOUNT '],
      oldDue: json['OLD DUE '],
      netDue: json['NET DUE'],
      collectionType: json['COLLECTION TYPE'],
      lat: json['LAT '],
      longValue: json['LONG '],
      allocation1EmpId: json['Allocation 1 emp id'],
      posClosureAmount: json['POS/CLOSURE AMOUNT '],
      allocation2EmpId: json['Allocation 2 emp id'],
      name: json['Name '],
      allocation3EmpId: json['Allocation 3 emp id'],
      allocation4EmpId: json['Allocation 4 emp id'],
      manager: json['MANAGER '],
      clusterManager: json['CLUSTER MANAGER'],
      regionalManager: json['REGIONAL MANAGER '],
      crmPerson: json['CRM PERSON'],
      crmBranch: json['CRM BRANCH'],
      emiReceivedDate1: json['EMI RECEIVED DATE-1'],
      receivedAmount1: json['RECEIVED AMOUNT-1'],
      collectedBy1: json['COLLECTED BY-1'],
      receivedIn1: json['RECEIVED IN -1'],
      emiReceivedDate2: json['EMI RECEIVED DATE-2'],
      receivedAmount2: json['RECEIVED AMOUNT-2'],
      collectedBy2: json['COLLECTED BY-2'],
      receivedIn2: json['RECEIVED IN -2'],
      emiReceivedDate3: json['EMI RECEIVED DATE-3'],
      receivedAmount3: json['RECEIVED AMOUNT-3'],
      collectedBy3: json['COLLECTED BY-3'],
      visitDate1: json['VISIT DATE-1'],
      remarks1: json[' REMARKS 1 '],
      visitedBy: json['VISITED BY '],
      coBorrower1Name: json['Co-borrower1_name'],
      coBorrower1Mobile: json['Co-borrower1_mobile'],
      coBorrower1Address: json['Co-borrower1_address'],
      gtrName: json['GTR NAME'],
      gtrFatherName: json['GTR FATHER NAME'],
      gtrAddress: json['GTR ADDRESS'],
      gtrMobNo: json['GTR MOB NO.'],
      auClearance: json['AU CLEARANCE '],
      caseIn: json['case in '],
      status: json['status '],
    );
  }

  // Method to convert a LoanDetails instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'LD': ld,
      'LOAN NO .': loanNo,
      'BRANCH': branch,
      'CUSTOMER NAME ': customerName,
      'FATHER NAME ': fatherName,
      'MOBILE': mobile,
      'SALES PERSON': salesPerson,
      'SALES MANAGER': salesManager,
      'ALLOCATED BRANCH': allocatedBranch,
      'VILLAGE': village,
      'ADDRESS': address,
      'PATNER': partner,
      'MODE': mode,
      'EMI AMOUNT ': emiAmount,
      'OLD DUE ': oldDue,
      'NET DUE': netDue,
      'COLLECTION TYPE': collectionType,
      'LAT ': lat,
      'LONG ': longValue,
      'Allocation 1 emp id': allocation1EmpId,
      'POS/CLOSURE AMOUNT ': posClosureAmount,
      'Allocation 2 emp id': allocation2EmpId,
      'Name ': name,
      'Allocation 3 emp id': allocation3EmpId,
      'Allocation 4 emp id': allocation4EmpId,
      'MANAGER ': manager,
      'CLUSTER MANAGER': clusterManager,
      'REGIONAL MANAGER ': regionalManager,
      'CRM PERSON': crmPerson,
      'CRM BRANCH': crmBranch,
      'EMI RECEIVED DATE-1': emiReceivedDate1,
      'RECEIVED AMOUNT-1': receivedAmount1,
      'COLLECTED BY-1': collectedBy1,
      'RECEIVED IN -1': receivedIn1,
      'EMI RECEIVED DATE-2': emiReceivedDate2,
      'RECEIVED AMOUNT-2': receivedAmount2,
      'COLLECTED BY-2': collectedBy2,
      'RECEIVED IN -2': receivedIn2,
      'EMI RECEIVED DATE-3': emiReceivedDate3,
      'RECEIVED AMOUNT-3': receivedAmount3,
      'COLLECTED BY-3': collectedBy3,
      'VISIT DATE-1': visitDate1,
      ' REMARKS 1 ': remarks1,
      'VISITED BY ': visitedBy,
      'Co-borrower1_name': coBorrower1Name,
      'Co-borrower1_mobile': coBorrower1Mobile,
      'Co-borrower1_address': coBorrower1Address,
      'GTR NAME': gtrName,
      'GTR FATHER NAME': gtrFatherName,
      'GTR ADDRESS': gtrAddress,
      'GTR MOB NO.': gtrMobNo,
      'AU CLEARANCE ': auClearance,
      'case in ': caseIn,
      'status ': status,
    };
  }
}
