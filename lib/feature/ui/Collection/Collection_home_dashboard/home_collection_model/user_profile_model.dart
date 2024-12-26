
// Create a user profile model
class UserProfile {
  final bool isLoading;
  final String name;
  final String email;
  final String employeeId;
  final String mobileNo;
  final String address;
  final String joiningDate;
  final String imageUrl;
  final String employeeUniqueId;
  final int visitAccepted;
  final int visitPendingForApproval;
  final int visitRejected;
  final int collectionAcceptAmount;
  final int collectionEmiAmountPendingForApproval;
  final int collectionRejectAmount;

  UserProfile( {
    this.isLoading = true,
    this.employeeUniqueId = '',
    this.visitAccepted = 0,
    this.collectionAcceptAmount = 0,
    this.visitPendingForApproval = 0,
    this.visitRejected = 0,
    this.collectionEmiAmountPendingForApproval = 0,
    this.collectionRejectAmount = 0,
    this.name = '',
    this.email = '',
    this.employeeId = '',
    this.mobileNo = '',
    this.address = '',
    this.joiningDate = '',
    this.imageUrl = '', // Add this field to handle profile picture
  });

   copyWith({
    bool? isLoading,
    String? name,
    String? email,
    String? employeeId,
    String? mobileNo,
    String? address,
    String? joiningDate,
    String? imageUrl,
    int? visitAccepted,
    String? employeeUniqueId,
    int? visitPendingForApproval,
    int? visitRejected,
    int? collectionAcceptAmount,
    int? collectionEmiAmountPendingForApproval,
    int? collectionRejectAmount,
  }) {
    UserProfile(
      isLoading: isLoading??this.isLoading,
        employeeUniqueId: employeeUniqueId?? this.employeeUniqueId,
        collectionAcceptAmount:
            collectionAcceptAmount ?? this.collectionAcceptAmount,
        collectionEmiAmountPendingForApproval:
            collectionEmiAmountPendingForApproval ??
                this.collectionEmiAmountPendingForApproval,
        collectionRejectAmount:
            collectionRejectAmount ?? this.collectionRejectAmount,
        visitAccepted: visitAccepted ?? this.visitAccepted,
        visitPendingForApproval:
            visitPendingForApproval ?? this.visitPendingForApproval,
        visitRejected: visitRejected ?? this.visitRejected,
        name: name ?? this.name,
        joiningDate: joiningDate ?? this.joiningDate,
        address: address ?? this.address,
        employeeId: employeeId ?? this.employeeId,
        email: email ?? this.email,
        mobileNo: mobileNo ?? this.mobileNo,
        imageUrl: imageUrl ?? this.imageUrl);
  }
}
// ${data.value?.items.visitAccepted??''}', 'Visits Accepted'),
// buildCard(Icons.person, '${data.value?.items.visitPendingForApproval??''}', 'Visits Pending'),
// buildCard(Icons.person, '${data.value?.items.visitRejected??''}', 'Visits Rejected'),
// buildCard(
// Icons.currency_rupee, '${data.value?.items.collectionAcceptAmount??''}', 'Collections Accepted'),
// buildCard(
// Icons.currency_rupee, '${data.value?.items.collectionEmiAmountPendingForApproval??''}', 'Collections Pending'),
// buildCard(
// Icons.currency_rupee, '${data.value?.items.collectionRejectAmount??''}', 'Collections Rejected'),
// ],
