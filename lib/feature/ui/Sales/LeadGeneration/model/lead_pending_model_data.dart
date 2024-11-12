

class Lead {
  final String? id;
  final String? customerName;
  final String? customerMobileNo;
  final int? loanAmount;
  final String? city;
  final String? pincode;
  final String? employeeAssignName;

  Lead({
    required this.id,
    required this.customerName,
    required this.customerMobileNo,
    required this.loanAmount,
    required this.city,
    required this.pincode,
    required this.employeeAssignName,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['_id'],
      customerName: json['customerName'] ?? 'N/A',
      customerMobileNo: json['customerMobileNo'] ?? 'N/A',
      loanAmount: json['loanAmount'] ?? 0,
      city: json['city'] ?? 'N/A',
      pincode: json['pincode'] ?? 'N/A',
      employeeAssignName: json['employeeAssignId']?['employeName'] ?? 'N/A',
    );
  }
}
