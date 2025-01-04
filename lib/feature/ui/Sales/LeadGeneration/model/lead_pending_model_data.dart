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
    String? handleBlank(String? value, {String? defaultValue}) {
      return (value == null || value.trim().isEmpty) ? defaultValue : value;
    }

    // Handle nested employeeAssignName
    String? employeeName;
    if (json['employeeGenerateId'] != null && json['employeeGenerateId'] is Map<String, dynamic>) {
      employeeName = json['employeeGenerateId']['employeName'];
    }

    return Lead(
      id: json['_id'],
      customerName: handleBlank(json['customerName'], defaultValue: 'N/A'),
      customerMobileNo: handleBlank(json['customerMobileNo'], defaultValue: 'N/A'),
      loanAmount: handleBlank(json['loanAmount'], defaultValue: 'N/A'),
      city: handleBlank(json['city'], defaultValue: 'N/A'),
      pincode: handleBlank(json['pincode'], defaultValue: 'N/A'),
     // employeeAssignName: handleBlank(json['employeeGenerateId']?['employeName'], defaultValue: 'N/A'),
      employeeAssignName: handleBlank(employeeName, defaultValue: 'N/A'),
      createdAt: handleBlank(json['createdAt'], defaultValue: 'N/A'),
      selfieWithCustomer: handleBlank(json['selfieWithCustomer']), // No default here, returns null if blank
    );
  }
}

/*class Lead {
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
    // Helper function to handle null or empty strings with default value
    String? handleBlank(String? value, {String? defaultValue = null}) {
      return (value == null || value.trim().isEmpty) ? defaultValue : value;
    }

    // Safely extract employeeAssignName
    String? employeeName;
    if (json.containsKey('employeeGenerateId') &&
        json['employeeGenerateId'] is Map<String, dynamic>) {
      employeeName = json['employeeGenerateId']['employeName'] as String?;
    }

    return Lead(
      id: json['_id'] as String?,
      customerName: handleBlank(json['customerName'], defaultValue: 'N/A'),
      customerMobileNo:
      handleBlank(json['customerMobileNo'], defaultValue: 'N/A'),
      loanAmount: handleBlank(json['loanAmount'], defaultValue: 'N/A'),
      city: handleBlank(json['city'], defaultValue: 'N/A'),
      pincode: handleBlank(json['pincode'], defaultValue: 'N/A'),
      employeeAssignName: handleBlank(employeeName, defaultValue: 'N/A'),
      createdAt: handleBlank(json['createdAt'], defaultValue: 'N/A'),
      selfieWithCustomer: handleBlank(json['selfieWithCustomer']),
    );
  }
}*/
