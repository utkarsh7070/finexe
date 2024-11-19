import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:finexe/feature/ui/PD/pd_view_model/pd_filled_form_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerDetail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerState = ref.watch(customerDetailProvider);
    final customerNotifier = ref.read(customerDetailProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text("Customer Detail's"),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 19, color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  customerNotifier.updateSearchText(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomSlidingSegmentedControl(
                fixedWidth: MediaQuery.of(context).size.width * 0.45,
                initialValue: customerState.selectedSegment,
                children: const {
                  1: Text('Existing Data'),
                  2: Text('Update Data'),
                },
                decoration: BoxDecoration(
                  color: const Color(0xFFD3D3D3),
                  borderRadius: BorderRadius.circular(8),
                ),
                thumbDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInToLinear,
                onValueChanged: (value) {
                  customerNotifier.updateSegment(value);
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: customerState.filteredSections.length,
                itemBuilder: (context, index) {
                  return _buildSectionWidget(
                      customerState.filteredSections[index], context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionWidget(String section, BuildContext context) {
    switch (section) {
      case "Loan Detail's":
        return _buildLoanDetails(context);
      case "Application Detail's":
        return _buildApplicationDetails(context);
      case "Co - Application Detail's 01":
        return _buildCoApplicationDetails01(context);
      case "Co - Application Detail's 02":
        return _buildCoApplicationDetails02(context);
      case "Guarantor Detail's":
        return _buildGuarantorDetails(context);
      case "Cibil Detail's":
        return _buildCibilDetails(context);
      default:
        return const SizedBox();
    }
  }

  // Helper methods for each section
  Widget _buildLoanDetails(BuildContext context) {
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
              _textData(context, text1: 'Product Type', text2: "MICRO LAP"),
              _textData(context, text1: 'Required Amount', text2: '20000'),
              _textData(context, text1: 'ROI', text2: '19%'),
              _textData(context, text1: 'Tenure', text2: "26 month"),
              _textData(context, text1: 'EMI Amount', text2: "₹ 7571.20"),
            ],
          ),
        ),
        Container(
          height: 1, // The height of the border
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width *
              0.9, // The color of the bottom border
        ),
      ],
    );
  }

  Widget _buildApplicationDetails(BuildContext context) {
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
                  imageUrl: 'https://picsum.photos/id/237/200/300',
                  text: 'Applicant Photos'),
              _textData(context, text1: 'Applicant Name', text2: 'MICRO LAP'),
              _textData(context, text1: 'Mother Name', text2: 'Kshama'),
              _textData(context, text1: "Spouse/Wife Name", text2: "N/A"),
              _textData(context, text1: "Mobile Number", text2: '+8770572720'),
              _textData(context, text1: 'Marital Status', text2: 'Unmarried'),
              _textData(context,
                  text1: 'Education Details', text2: 'Graduation'),
              _textData(context, text1: 'Applicant DOB', text2: '1996-07-13'),
              _textData(context, text1: 'Gender', text2: 'Male'),
              _textData(context, text1: 'Pan Number', text2: 'CCUPB200238'),
              _textData(context,
                  text1: 'Aadhar Number', text2: '6229002002238'),
              _textData(context, text1: 'Voter Id Number', text2: 'N/A'),
              _textData(context,
                  text1: 'Address Line 1',
                  text2:
                      'Ward N, Gram Bachhkhal, Teh Khateganv, Dewas, Bachhkhal, Madhya Pradesh, India, 455336'),
              _textData(context,
                  text1: 'Address Line 2',
                  text2:
                      'Ward N, Gram Bachhkhal, Teh Khateganv, Dewas, Bachhkhal, Madhya Pradesh, India, 455336'),
              _textData(context, text1: 'City', text2: 'Bachhkhal'),
              _textData(context, text1: 'State', text2: 'Madhya Pradesh'),
              _textData(context, text1: 'District', text2: 'Dewas'),
              _textData(context, text1: 'Pin Code', text2: '455336'),
              _photoGrid(
                title: "Upload Photo's",
                imageUrls: [
                  "https://picsum.photos/seed/picsum/200/300",
                  "https://picsum.photos/200/300?grayscale",
                  "https://picsum.photos/id/237/200/300",
                  "https://picsum.photos/200/300?grayscale",
                ],
              ),
              _textData(context,
                  text1: 'Cibil Report', text2: 'No CIBIL Report Available'),
            ],
          ),
        ),
        Container(
          height: 1, // The height of the border
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width *
              0.9, // The color of the bottom border
        )
      ],
    );
  }

  Widget _buildCoApplicationDetails01(BuildContext context) {
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text(
        "Co - Applicant Details 01",
        style: AppStyles.TitleStyle,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowImage(context,
                  imageUrl: 'https://picsum.photos/id/237/200/300',
                  text: 'Co - Applicant Photos'),
              _textData(context, text1: 'Type', text2: 'Dhananjay'),
              _textData(context, text1: 'Name', text2: 'Kshama'),
              _textData(context, text1: 'APL Father/Spouse Name', text2: 'N/A'),
              _textData(context, text1: 'APL Mother Name', text2: 'Kshama'),
              _textData(context, text1: 'Relationhsip', text2: 'Unmarried'),
              _textData(context, text1: 'Age', text2: '24'),
              _textData(context, text1: 'Gender', text2: 'Male'),
              _textData(context, text1: 'Email', text2: 'Kshama@gmail.com'),
              _textData(context, text1: 'Marital Status', text2: 'CCUPB456Q'),
              _textData(context, text1: 'Eduction', text2: 'Graduation'),
              _textData(context, text1: 'Caste', text2: 'N/A'),
              _textData(context, text1: 'Aadhar No.', text2: '446565767822'),
              _textData(context, text1: 'PAN No.', text2: 'PBSH54666K'),
              _textData(context, text1: 'Voter ID No.', text2: '5457657657768'),
              _textData(context, text1: 'Document Type', text2: 'Aadhar card'),
              _textData(context, text1: 'Document No.', text2: '23435456'),
              _photoGrid(
                title: "Upload Photo's",
                imageUrls: [
                  "https://picsum.photos/seed/picsum/200/300",
                  "https://picsum.photos/200/300?grayscale",
                  "https://picsum.photos/id/237/200/300",
                  "https://picsum.photos/200/300?grayscale",
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1, // The height of the border
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width *
              0.9, // The color of the bottom border
        )
      ],
    );
  }

  Widget _buildCoApplicationDetails02(BuildContext context) {
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text(
        "Co - Applicant Details 02",
        style: AppStyles.TitleStyle,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowImage(context,
                  imageUrl: 'https://picsum.photos/id/237/200/300',
                  text: 'Co - Applicant Photos'),
              _textData(context, text1: 'Type', text2: 'Dhananjay'),
              _textData(context, text1: 'Name', text2: 'Kshama'),
              _textData(context, text1: 'APL Father/Spouse Name', text2: 'N/A'),
              _textData(context, text1: 'APL Mother Name', text2: 'Kshama'),
              _textData(context, text1: 'Relationhsip', text2: 'Unmarried'),
              _textData(context, text1: 'Age', text2: '24'),
              _textData(context, text1: 'Gender', text2: 'Male'),
              _textData(context, text1: 'Email', text2: 'Kshama@gmail.com'),
              _textData(context, text1: 'Marital Status', text2: 'CCUPB456Q'),
              _textData(context, text1: 'Eduction', text2: 'Graduation'),
              _textData(context, text1: 'Caste', text2: 'N/A'),
              _textData(context, text1: 'Aadhar No.', text2: '446565767822'),
              _textData(context, text1: 'PAN No.', text2: 'PBSH54666K'),
              _textData(context, text1: 'Voter ID No.', text2: '5457657657768'),
              _textData(context, text1: 'Document Type', text2: 'Aadhar card'),
              _textData(context, text1: 'Document No.', text2: '23435456'),
              _photoGrid(
                title: "Upload Photo's",
                imageUrls: [
                  "https://picsum.photos/seed/picsum/200/300",
                  "https://picsum.photos/200/300?grayscale",
                  "https://picsum.photos/id/237/200/300",
                  "https://picsum.photos/200/300?grayscale",
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1, // The height of the border
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width *
              0.9, // The color of the bottom border
        )
      ],
    );
  }

  Widget _buildGuarantorDetails(BuildContext context) {
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text(
        "Guarantor Details",
        style: AppStyles.TitleStyle,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowImage(context,
                  imageUrl: 'https://picsum.photos/id/237/200/300',
                  text: 'Guarantor Photos'),
              _textData(context, text1: 'Type', text2: 'Dhananjay'),
              _textData(context, text1: 'Name', text2: 'Kshama'),
              _textData(context, text1: 'APL Father/Spouse Name', text2: 'N/A'),
              _textData(context, text1: 'APL Mother Name', text2: 'Kshama'),
              _textData(context, text1: 'Relationhsip', text2: 'Unmarried'),
              _textData(context, text1: 'Age', text2: '24'),
              _textData(context, text1: 'Gender', text2: 'Male'),
              _textData(context, text1: 'Email', text2: 'Kshama@gmail.com'),
              _textData(context, text1: 'Marital Status', text2: 'CCUPB456Q'),
              _textData(context, text1: 'Eduction', text2: 'Graduation'),
              _textData(context, text1: 'Caste', text2: 'N/A'),
              _textData(context, text1: 'Aadhar No.', text2: '446565767822'),
              _textData(context, text1: 'PAN No.', text2: 'PBSH54666K'),
              _textData(context, text1: 'Voter ID No.', text2: '5457657657768'),
              _textData(context, text1: 'Document Type', text2: 'Aadhar card'),
              _textData(context, text1: 'Document No.', text2: '23435456'),
              _photoGrid(
                title: "Upload Photo's",
                imageUrls: [
                  "https://picsum.photos/seed/picsum/200/300",
                  "https://picsum.photos/200/300?grayscale",
                  "https://picsum.photos/id/237/200/300",
                  "https://picsum.photos/200/300?grayscale",
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1, // The height of the border
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width *
              0.9, // The color of the bottom border
        )
      ],
    );
  }

  Widget _buildCibilDetails(BuildContext context) {
    return ExpansionTile(
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: Text(
        "Cibil Details",
        style: AppStyles.TitleStyle,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textData(context, text1: 'Applicant CIBIL SCORE', text2: '710'),
              _textData(context, text1: 'Loan Type', text2: 'MICRO LAP'),
              _textData(context, text1: 'Loan Amount', text2: '200000'),
              _textData(context, text1: 'Outstanding Amount', text2: '19%'),
              _textData(context, text1: 'Over Due', text2: '26 month'),
              _textData(context, text1: 'EMI Amount', text2: "₹ 7571.20"),
              _textData(context, text1: 'Guararntor CIBIL SCORE', text2: '712'),
              _textData(context, text1: 'Loan Type', text2: 'MICRO LAP'),
              _textData(context, text1: 'Loan Amount', text2: '200000'),
              _textData(context, text1: 'Outstanding Amount', text2: '19%'),
              _textData(context, text1: 'Over Due', text2: '26 month'),
              _textData(context, text1: 'EMI Amount', text2: "₹ 7571.20"),
            ],
          ),
        ),
        Container(
          height: 1, // The height of the border
          color: Color(0xFF0082C6),
          width: MediaQuery.of(context).size.width *
              0.9, // The color of the bottom border
        )
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(12)), // Set the border radius here
                  child: Image.network(
                    imageUrls[index],
                    height: 70, // Adjust image size as needed
                    width: 75,
                    fit: BoxFit.cover,
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
