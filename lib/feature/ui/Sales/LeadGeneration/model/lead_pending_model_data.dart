

/*class Lead {
  final String? id;
  final String? customerName;
  final String? customerMobileNo;
  final String? loanAmount;
  final String? city;
  final String? pincode;
  final String? employeeAssignName;
  final String? createdAt;

  Lead({
    required this.id,
    required this.customerName,
    required this.customerMobileNo,
    required this.loanAmount,
    required this.city,
    required this.pincode,
    required this.employeeAssignName,
    required this.createdAt,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['_id'],
      customerName: json['customerName'] ?? 'N/A',
      customerMobileNo: json['customerMobileNo'] ?? 'N/A',
      loanAmount: json['loanAmount'] ?? 'N/A',
      city: json['city'] ?? 'N/A',
      pincode: json['pincode'] ?? 'N/A',
      employeeAssignName: json['employeeAssignId']?['employeName'] ?? 'N/A',
      createdAt: json['createdAt'] ?? 'N/A',
    );
  }
}*/

class Lead {
  final String? id;
  final String? customerName;
  final String? customerMobileNo;
  final String? loanAmount;
  final String? city;
  final String? pincode;
  final String? employeeAssignName;
  final String? createdAt;
  final String? selfieWithCustomer;

  Lead({
    required this.id,
    required this.customerName,
    required this.customerMobileNo,
    required this.loanAmount,
    required this.city,
    required this.pincode,
    required this.employeeAssignName,
    required this.createdAt,
    required this.selfieWithCustomer,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    // Helper function to handle empty or null values with customizable default value
    String? handleBlank(String? value, {String? defaultValue = null}) {
      return (value == null || value.trim().isEmpty) ? defaultValue : value;
    }

    return Lead(
      id: json['_id'],
      customerName: handleBlank(json['customerName'], defaultValue: 'N/A'),
      customerMobileNo: handleBlank(json['customerMobileNo'], defaultValue: 'N/A'),
      loanAmount: handleBlank(json['loanAmount'], defaultValue: 'N/A'),
      city: handleBlank(json['city'], defaultValue: 'N/A'),
      pincode: handleBlank(json['pincode'], defaultValue: 'N/A'),
      employeeAssignName: handleBlank(json['employeeAssignId']?['employeName'], defaultValue: 'N/A'),
      createdAt: handleBlank(json['createdAt'], defaultValue: 'N/A'),
      selfieWithCustomer: handleBlank(json['selfieWithCustomer']), // No default here, returns null if blank
    );
  }


/*factory Lead.fromJson(Map<String, dynamic> json) {
    // Helper function to handle empty or null values
    String handleBlank(String? value, {String defaultValue = 'N/A'}) {
      return (value == null || value.trim().isEmpty) ? defaultValue : value;
    }

    return Lead(
      id: json['_id'],
      customerName: handleBlank(json['customerName']),
      customerMobileNo: handleBlank(json['customerMobileNo']),
      loanAmount: handleBlank(json['loanAmount']),
      city: handleBlank(json['city']),
      pincode: handleBlank(json['pincode']),
      employeeAssignName: handleBlank(json['employeeAssignId']?['employeName']),
      createdAt: handleBlank(json['createdAt']),
      selfieWithCustomer: handleBlank(json['selfieWithCustomer']),
    );
  }*/
}
