import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/ui/PD/pd_view_model/pd_filled_form_viewmodel.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_existing_data/modal/pd_existing_modal.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_existing_data/view_modal/pd_existing_view_modal.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_existing_data/modal/pd_existing_modal.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_existing_data/view_modal/pd_existing_view_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdFilledForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerState = ref.watch(customerDetailProvider);

    // Watch the applicationDetailsProvider
    final loanDetailsAsync = ref.watch(loanDetailsProvider);
    final applicationDetails = ref.watch(applicationDetailsProvider);
    final coApplicants = ref.watch(coApplicantProvider);
    final guarantorDetails = ref.watch(guarantorDetailsProvider);
    final cibilDetails = ref.watch(cibilDetailsProvider);

    // Check if any async operation is loading
    bool isLoading = loanDetailsAsync.isLoading ||
        applicationDetails.isLoading ||
        coApplicants.isLoading ||
        guarantorDetails.isLoading ||
        cibilDetails.isLoading;

    return Column(
      children: [
        const SizedBox(height: 10),
        if (isLoading) // Show global loader if any data is loading
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 3,
              key: ValueKey('global-loading'), // Global loader key
            ),
          ),

        Expanded(
          child: ListView.builder(
            primary: true,
            shrinkWrap: false,
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: customerState.filteredSections.length,
            itemBuilder: (context, index) {
              return _buildSectionWidget(
                customerState.filteredSections[index],
                context,
                loanDetailsAsync,
                applicationDetails,
                coApplicants,
                guarantorDetails,
                cibilDetails, // Pass guarantor details here
              );
            },
          ),
        ),
        // SizedBox(height: MediaQuery.of(context).size.height*0.1,)
      ],
    );
  }

  Widget _buildSectionWidget(
    String section,
    BuildContext context,
    AsyncValue<LoanDetails> loanDetailsAsync,
    AsyncValue<ApplicationDetails> applicationDetails,
    AsyncValue<List<CoApplicantDetails>> coApplicants,
    AsyncValue<GuarantorDetails> guarantorDetails,
    AsyncValue<CibilDetails> cibilDetails,
  ) {
    final sectionWidgets = {
      "Loan Detail's": loanDetailsAsync.when(
        data: (details) => _buildLoanDetails(context, details),
        loading: () =>
            SizedBox.shrink(), // Don't show loading inside each section
        error: (err, stack) => Text('Error: $err'),
      ),
      "Application Detail's": applicationDetails.when(
        data: (details) => _buildApplicationDetails(context, details),
        loading: () => SizedBox.shrink(),
        error: (err, stack) => Text('Error: $err'),
      ),
      "Co - Application Detail's 01": coApplicants.when(
        data: (details) => details.isNotEmpty
            ? _buildCoApplicationDetails01(
                context, details[0], "Co - Applicant Details 01")
            : Text("No Co-Applicant Details 01"),
        loading: () => SizedBox.shrink(),
        error: (err, stack) => Text('Error: $err'),
      ),
      "Co - Application Detail's 02": coApplicants.when(
        data: (details) => details.length > 1
            ? _buildCoApplicationDetails02(
                context, details[1], "Co - Applicant Details 02")
            : Text("No Co-Applicant Details 02"),
        loading: () => SizedBox.shrink(),
        error: (err, stack) => Text('Error: $err'),
      ),
      "Guarantor Detail's": guarantorDetails.when(
        data: (details) => _buildGuarantorDetails(context, details),
        loading: () => SizedBox.shrink(),
        error: (err, stack) => Text('Error: $err'),
      ),
      "Cibil Detail's": cibilDetails.when(
        data: (details) => _buildCibilDetails(context, details),
        loading: () => SizedBox.shrink(),
        error: (err, stack) => Text('Error: $err'),
      ),
    };

    return sectionWidgets[section] ?? const SizedBox();
  }

  // Helper methods for each section
  Widget _buildLoanDetails(BuildContext context, LoanDetails details) {
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text(
        "Loan Details",
        style: AppStyles.TitleStyle,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textData(context,
                  text1: 'Product Type', text2: details.productType),
              _textData(context,
                  text1: 'Required Amount',
                  text2: '₹ ${details.requiredAmount}'),
              _textData(context, text1: 'ROI', text2: '${details.roi}%'),
              _textData(context,
                  text1: 'Tenure', text2: "${details.tenure} months"),
              _textData(context,
                  text1: 'EMI Amount', text2: "₹ ${details.emiAmount}"),
            ],
          ),
        ),
        Container(
          height: 1,
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ],
    );
  }

  Widget _buildApplicationDetails(
      BuildContext context, ApplicationDetails details) {
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text(
        "Applicant Details",
        style: AppStyles.TitleStyle,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowImage(context,
                  imageUrl:
                      '${details.applicantPhotos?.isNotEmpty == true ? '${Api.imageUrl}${details.applicantPhotos[0]}' : 'https://picsum.photos/id/237/200/300'}',
                  text: 'Applicant Photos'),
              _textData(context,
                  text1: 'Applicant Name', text2: details.applicantName),
              _textData(context,
                  text1: 'Mother Name', text2: details.motherName),
              _textData(context,
                  text1: "Spouse/Wife Name",
                  text2: details.spouseName ?? "N/A"),
              _textData(context,
                  text1: "Mobile Number", text2: '+${details.mobileNumber}'),
              _textData(context,
                  text1: 'Marital Status', text2: details.maritalStatus),
              _textData(context,
                  text1: 'Education Details', text2: details.educationDetails),
              _textData(context,
                  text1: 'Applicant DOB', text2: details.applicantDOB),
              _textData(context, text1: 'Gender', text2: details.gender),
              _textData(context, text1: 'Pan Number', text2: details.panNumber),
              _textData(context,
                  text1: 'Aadhar Number', text2: details.aadharNumber),
              _textData(context,
                  text1: 'Voter Id Number',
                  text2: details.voterIdNumber ?? 'N/A'),
              _textData(context,
                  text1: 'Address Line 1', text2: details.addressLine1),
              _textData(context,
                  text1: 'Address Line 2', text2: details.addressLine2),
              _textData(context, text1: 'City', text2: details.city),
              _textData(context, text1: 'State', text2: details.state),
              _textData(context, text1: 'District', text2: details.district),
              _textData(context, text1: 'Pin Code', text2: details.pinCode),
              _photoGrid(
                title: "Upload Photos",
                imageUrls: details.uploadedPhotos
                        .where((photo) =>
                            photo.isNotEmpty) // Filter out empty strings
                        .map((photo) => '${Api.imageUrl}/$photo')
                        .toList()
                        .isEmpty // Check if filtered list is empty
                    ? ["https://picsum.photos/seed/picsum/200/300"]
                    : details.uploadedPhotos
                        .where((photo) => photo.isNotEmpty)
                        .map((photo) => '${Api.imageUrl}/$photo')
                        .toList(),
              ),
              _textData(context,
                  text1: 'Cibil Report', text2: details.applicantCibilReport),
            ],
          ),
        ),
        Container(
          height: 1, // The height of the border
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width *
              0.9, // Width of the bottom border
        )
      ],
    );
  }

  Widget _buildCoApplicationDetails01(
      BuildContext context, CoApplicantDetails details, String label) {
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text(
        label,
        style: AppStyles.TitleStyle,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Display Co-Applicant photo from the API response
              _rowImage(
                context,
                imageUrl:
                    '${details.coApplicantPhoto?.isNotEmpty == true ? '${Api.imageUrl}${details.coApplicantPhoto}' : 'https://picsum.photos/id/237/200/300'}',
                text: 'Co - Applicant Photos',
              ),
              _textData(context,
                  text1: 'Document Type', text2: details.docType ?? 'N/A'),
              _textData(context,
                  text1: 'Name', text2: details.fullName ?? 'N/A'),
              _textData(context,
                  text1: 'APL Father/Spouse Name',
                  text2: details.fatherName ?? 'N/A'),
              _textData(context,
                  text1: 'APL Mother Name', text2: details.motherName ?? 'N/A'),
              _textData(context,
                  text1: 'Relationship',
                  text2: details.relationWithApplicant ?? 'N/A'),
              _textData(context,
                  text1: 'Age', text2: details.age?.toString() ?? 'N/A'),
              _textData(context,
                  text1: 'Gender', text2: details.gender ?? 'N/A'),
              _textData(context, text1: 'Email', text2: details.email ?? 'N/A'),
              _textData(context,
                  text1: 'Marital Status',
                  text2: details.maritalStatus ?? 'N/A'),
              _textData(context,
                  text1: 'Education', text2: details.education ?? 'N/A'),
              _textData(context, text1: 'Caste', text2: details.caste ?? 'N/A'),
              _textData(context,
                  text1: 'Aadhar No.', text2: details.aadharNo ?? 'N/A'),
              _textData(context,
                  text1: 'PAN No.', text2: details.docNo ?? 'N/A'),
              _textData(context,
                  text1: 'Voter ID No.', text2: details.voterId ?? 'N/A'),
              _textData(context,
                  text1: 'Document No.', text2: details.docNo ?? 'N/A'),
              // Show image gallery based on KYC upload images
              _photoGrid(
                title: "Upload Photos",
                imageUrls: [
                  '${Api.imageUrl}${details.kycUpload?.docImage ?? 'https://picsum.photos/id/237/200/300'}',
                  '${Api.imageUrl}${details.kycUpload?.aadharFrontImage ?? 'https://picsum.photos/id/237/200/300'}',
                  '${Api.imageUrl}${details.kycUpload?.aadharBackImage ?? 'https://picsum.photos/id/237/200/300'}',
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: const Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width * 0.9,
        )
      ],
    );
  }

  Widget _buildCoApplicationDetails02(
      BuildContext context, CoApplicantDetails details, String label) {
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text(
        label,
        style: AppStyles.TitleStyle,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Display Co-Applicant photo from the API response
              _rowImage(
                context,
                imageUrl:
                    '${details.coApplicantPhoto?.isNotEmpty == true ? '${Api.imageUrl}${details.coApplicantPhoto}' : 'https://picsum.photos/id/237/200/300'}',
                text: 'Co - Applicant Photos',
              ),
              _textData(context,
                  text1: 'Document Type', text2: details.docType ?? 'N/A'),
              _textData(context,
                  text1: 'Name', text2: details.fullName ?? 'N/A'),
              _textData(context,
                  text1: 'APL Father/Spouse Name',
                  text2: details.fatherName ?? 'N/A'),
              _textData(context,
                  text1: 'APL Mother Name', text2: details.motherName ?? 'N/A'),
              _textData(context,
                  text1: 'Relationship',
                  text2: details.relationWithApplicant ?? 'N/A'),
              _textData(context,
                  text1: 'Age', text2: details.age?.toString() ?? 'N/A'),
              _textData(context,
                  text1: 'Gender', text2: details.gender ?? 'N/A'),
              _textData(context, text1: 'Email', text2: details.email ?? 'N/A'),
              _textData(context,
                  text1: 'Marital Status',
                  text2: details.maritalStatus ?? 'N/A'),
              _textData(context,
                  text1: 'Education', text2: details.education ?? 'N/A'),
              _textData(context, text1: 'Caste', text2: details.caste ?? 'N/A'),
              _textData(context,
                  text1: 'Aadhar No.', text2: details.aadharNo ?? 'N/A'),
              _textData(context,
                  text1: 'PAN No.', text2: details.docNo ?? 'N/A'),
              _textData(context,
                  text1: 'Voter ID No.', text2: details.voterId ?? 'N/A'),
              _textData(context,
                  text1: 'Document No.', text2: details.docNo ?? 'N/A'),
              // Show image gallery based on KYC upload images
              _photoGrid(
                title: "Upload Photos",
                imageUrls: [
                  '${Api.imageUrl}${details.kycUpload?.docImage ?? 'https://picsum.photos/id/237/200/300'}',
                  '${Api.imageUrl}${details.kycUpload?.aadharFrontImage ?? 'https://picsum.photos/id/237/200/300'}',
                  '${Api.imageUrl}${details.kycUpload?.aadharBackImage ?? 'https://picsum.photos/id/237/200/300'}',
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: const Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width * 0.9,
        )
      ],
    );
  }

  Widget _buildGuarantorDetails(
      BuildContext context, GuarantorDetails guarantorDetails) {
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text("Guarantor Details", style: AppStyles.TitleStyle),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowImage(
                context,
                imageUrl: guarantorDetails.guarantorPhoto.isNotEmpty
                    ? '${Api.imageUrl}${guarantorDetails.guarantorPhoto}'
                    : 'https://picsum.photos/id/237/200/300',
                text: 'Guarantor Photos',
              ),
              _textData(context,
                  text1: 'Type', text2: guarantorDetails.docType),
              _textData(context,
                  text1: 'Name', text2: guarantorDetails.fullName),
              _textData(context,
                  text1: 'APL Father/Spouse Name',
                  text2: guarantorDetails.fatherName),
              _textData(context,
                  text1: 'APL Mother Name', text2: guarantorDetails.motherName),
              _textData(context,
                  text1: 'Relationship',
                  text2: guarantorDetails.relationWithApplicant),
              _textData(context, text1: 'Age', text2: guarantorDetails.age),
              _textData(context,
                  text1: 'Gender', text2: guarantorDetails.gender),
              _textData(context, text1: 'Email', text2: guarantorDetails.email),
              _textData(context,
                  text1: 'Marital Status',
                  text2: guarantorDetails.maritalStatus),
              _textData(context,
                  text1: 'Education', text2: guarantorDetails.education),
              _textData(context, text1: 'Caste', text2: guarantorDetails.caste),
              _textData(context,
                  text1: 'Aadhar No.', text2: guarantorDetails.aadharNo),
              _textData(context,
                  text1: 'PAN No.', text2: guarantorDetails.docNo),
              _textData(context,
                  text1: 'Document Type', text2: guarantorDetails.docType),
              _textData(context,
                  text1: 'Document No.', text2: guarantorDetails.docNo),
              _photoGrid(
                title: "Upload Photos",
                imageUrls: [
                  guarantorDetails
                          .guarantorKycUpload.aadharFrontImage.isNotEmpty
                      ? '${Api.imageUrl}${guarantorDetails.guarantorKycUpload.aadharFrontImage}'
                      : '',
                  guarantorDetails.guarantorKycUpload.aadharBackImage.isNotEmpty
                      ? '${Api.imageUrl}${guarantorDetails.guarantorKycUpload.aadharBackImage}'
                      : '',
                  guarantorDetails.guarantorKycUpload.docImage.isNotEmpty
                      ? '${Api.imageUrl}${guarantorDetails.guarantorKycUpload.docImage}'
                      : '',
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ],
    );
  }

  Widget _buildCibilDetails(BuildContext context, CibilDetails cibilDetails) {
    // Correct way to print the CIBIL score
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text(
        "Cibil Details",
        style: AppStyles.TitleStyle,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Displaying Applicant CIBIL Score
              _textData(
                context,
                text1: 'Applicant CIBIL SCORE',
                text2:
                    '${cibilDetails.applicantCibilScore.toString() ?? 'N/A'}',
              ),

              const SizedBox(
                height: 20,
              ),
              // Applicant CIBIL Details as ListView
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: cibilDetails.applicantCibilDetail.isEmpty
                    ? 0
                    : MediaQuery.of(context).size.height * 0.36,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: cibilDetails.applicantCibilDetail.length,
                  itemBuilder: (context, index) {
                    var detail = cibilDetails.applicantCibilDetail[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0), // Add bottom margin between items
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue), // Add border color
                          borderRadius: BorderRadius.circular(
                              8.0), // Optional: rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white70
                                  .withOpacity(0.3), // Shadow color and opacity
                              blurRadius: 6, // Shadow blur effect
                              offset: Offset(0, 3), // Position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(
                            6.0), // Add padding inside the container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textData(context,
                                text1: 'Loan Type',
                                text2: detail.loanType ?? 'N/A'),
                            _textData(context,
                                text1: 'Loan Amount',
                                text2: detail.loanAmount ?? 'N/A'),
                            _textData(context,
                                text1: 'Outstanding Amount',
                                text2: detail.outstandingAmount ?? 'N/A'),
                            _textData(context,
                                text1: 'Over Due',
                                text2: detail.overDue ?? 'N/A'),
                            _textData(context,
                                text1: 'EMI Amount',
                                text2: detail.emi ?? 'N/A'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // Displaying Co-Applicant CIBIL Score
              _textData(
                context,
                text1: 'Co-Applicant CIBIL SCORE',
                text2:
                    '${cibilDetails.coApplicantCibilScore.toString() ?? 'N/A'}',
              ),
              const SizedBox(
                height: 20,
              ),
              // Co-Applicant CIBIL Details as ListView
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: cibilDetails.coApplicantCibilDetail.isEmpty
                    ? 0 // Set height to 0 if the list is empty
                    : MediaQuery.of(context).size.height * 0.36,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: cibilDetails.coApplicantCibilDetail.length,
                  itemBuilder: (context, index) {
                    var detail = cibilDetails.coApplicantCibilDetail[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0), // Add bottom margin between items
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue), // Add border color
                          borderRadius: BorderRadius.circular(
                              8.0), // Optional: rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white70
                                  .withOpacity(0.3), // Shadow color and opacity
                              blurRadius: 6, // Shadow blur effect
                              offset: Offset(0, 3), // Position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(
                            6.0), // Add padding inside the container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textData(context,
                                text1: 'Loan Type',
                                text2: detail.loanType ?? 'N/A'),
                            _textData(context,
                                text1: 'Loan Amount',
                                text2: detail.loanAmount ?? 'N/A'),
                            _textData(context,
                                text1: 'Outstanding Amount',
                                text2: detail.outstandingAmount ?? 'N/A'),
                            _textData(context,
                                text1: 'Over Due',
                                text2: detail.overDue ?? 'N/A'),
                            _textData(context,
                                text1: 'EMI Amount',
                                text2: detail.emi ?? 'N/A'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Displaying Guarantor CIBIL Score
              _textData(
                context,
                text1: 'Guarantor CIBIL SCORE',
                text2:
                    '${cibilDetails.guarantorCibilScore.toString() ?? 'N/A'}',
              ),
              const SizedBox(
                height: 20,
              ),
              // Guarantor CIBIL Details as ListView
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: cibilDetails.guarantorCibilDetail.isEmpty
                    ? 0
                    : MediaQuery.of(context).size.height * 0.36,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: cibilDetails.guarantorCibilDetail.length,
                  itemBuilder: (context, index) {
                    var detail = cibilDetails.guarantorCibilDetail[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0), // Add bottom margin between items
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue), // Add border color
                          borderRadius: BorderRadius.circular(
                              8.0), // Optional: rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white70
                                  .withOpacity(0.3), // Shadow color and opacity
                              blurRadius: 6, // Shadow blur effect
                              offset: Offset(0, 3), // Position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(
                            6.0), // Add padding inside the container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textData(context,
                                text1: 'Loan Type',
                                text2: detail.loanType ?? 'N/A'),
                            _textData(context,
                                text1: 'Loan Amount',
                                text2: detail.loanAmount ?? 'N/A'),
                            _textData(context,
                                text1: 'Outstanding Amount',
                                text2: detail.outstandingAmount ?? 'N/A'),
                            _textData(context,
                                text1: 'Over Due',
                                text2: detail.overDue ?? 'N/A'),
                            _textData(context,
                                text1: 'EMI Amount',
                                text2: detail.emi ?? 'N/A'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ],
    );
  }

  // Reusable widget for displaying key-value pairs
  Widget _textData(BuildContext context,
      {required String text1, required String text2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF475467),
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF101828),
              ),
              maxLines: 3, // Allow text to wrap to 3 lines if necessary
              overflow:
                  TextOverflow.ellipsis, // Handle text overflow with ellipsis
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowImage(BuildContext context,
      {required String imageUrl, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Padding(
        padding: const EdgeInsets.all(5.0), // Padding inside the card
        child: Row(
          children: [
            // Image on the left
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0), // Rounded corners for the image
              child: Image.network(
                imageUrl,
                width: 60, // Set width of the image
                height: 60, // Set height of the image
                fit: BoxFit.cover, // Ensure the image covers the box
              ),
            ),
            const SizedBox(width: 12), // Space between image and text
            // Text on the right
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                maxLines: 2, // Allow text to span multiple lines if necessary
                overflow: TextOverflow.ellipsis,
                textAlign:
                    TextAlign.start, // Handle text overflow with ellipsis
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoGrid(
      {BuildContext? context,
      required String title,
      required List<String> imageUrls}) {
    final theme = context != null ? Theme.of(context) : ThemeData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Adjust the number of images per row
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(12)), // Set the border radius here
                    child: Image.network(
                      imageUrls[index],
                      height: 70, // Adjust image size as needed
                      width: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // SizedBox(height: 4),
                // Text(
                //   'Photo ${index + 1}',
                //   style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                // ),
              ],
            );
          },
        ),
      ],
    );
  }
}

extension AppStyles on TextStyle {
  static TextStyle TitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle ItemStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}
