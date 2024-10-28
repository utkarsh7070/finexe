
class VisitItemNotice {
  final String id;
  final String document;
  final String status;

  VisitItemNotice({required this.id, required this.document, required this.status});

  factory VisitItemNotice.fromJson(Map<String, dynamic> json) {
    return VisitItemNotice(
      id: json['_id'],
      document: json['document'],
      status: json['status'],
    );
  }
}
