import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/api/api.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../model/lead_approved_model_data.dart';
import '../model/lead_pending_model_data.dart';
import '../model/lead_rejected_model_data.dart';
import '../view_model/lead_showing_view_model.dart';
import 'lead_generation_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadListScreen extends ConsumerStatefulWidget {
  const LeadListScreen({super.key});

  @override
  _LeadListScreenState createState() => _LeadListScreenState();
}

class _LeadListScreenState extends ConsumerState<LeadListScreen> {
  final ScrollController _headerScrollController = ScrollController();
  final ScrollController _bodyScrollController = ScrollController();
  int selectedStatus = 0; // 0: Created, 1: Assigned, 2: Rejected

  @override
  void initState() {
    super.initState();
    _headerScrollController.addListener(() {
      _bodyScrollController.jumpTo(_headerScrollController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Choose the provider based on selectedStatus
    final leadProvider = selectedStatus == 0
        ? leadShowViewModelProvider
        : selectedStatus == 1
        ? leadAssignedProvider
        : leadRejectedProvider;

    // Watch the selected provider
    final leadViewModel = ref.watch(leadProvider);

    return Scaffold(
        body: Container(
      width: displayWidth(context),
      height: displayHeight(context),
      color: AppColors.primary,
      padding: const EdgeInsets.only(top: 70),
      child: Container(
        height: displayHeight(context),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: displayHeight(context) * 0.02,
                  width: displayWidth(context) * 0.05,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Customer Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Add lead action
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) =>
                                LeadGenerationForm())) // Replace with your second page widget
                        .then((refreshNeeded) {
                      // Check if refresh is needed
                      if (refreshNeeded == true) {
                        // Trigger the data refresh in the ViewModel
                        ref.refresh(leadShowViewModelProvider);
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.01,
            ),
            Expanded(
              child:
              Column(
                children: [
                  // Status Filter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Created"),
                      Radio<int>(
                        value: 0,
                        groupValue: selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value!;
                          });
                        },
                      ),
                      Text("Assigned"),
                      Radio<int>(
                        value: 1,
                        groupValue: selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value!;
                          });
                        },
                      ),
                      Text("Rejected"),
                      Radio<int>(
                        value: 2,
                        groupValue: selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Use leadViewModel.when outside of Row
                  leadViewModel.when(
                    data: (leadViewModelDetails) {
                      return _buildVisitTab(leadViewModelDetails); // Pass the visit data here
                    },
                    error: (error, stackTrace) {
                      return const Text('Error loading visit details');
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
  void showCustomerDetailsDialog(BuildContext context, Object item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Widget content;
        if (item is Lead) {
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Details',
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Text("Name: ${item.customerName ?? 'N/A'}"),
              Text("Mobile No: ${item.customerMobileNo ?? 'N/A'}"),
              Text("Loan Amount: ₹${item.loanAmount ?? 'N/A'}"),
              Text("City: ${item.city ?? 'N/A'}"),
              Text("Pincode: ${item.pincode ?? 'N/A'}"),
              const SizedBox(height: 10),
              const Text(
                'Remark By CRM',
                style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 5),
              Text("Remark: N/A"),
              // Replace "N/A" with actual remark data if available.
              const SizedBox(height: 20),
              const Text(
                'Selfie Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Container(
                height: 150,
                width: double.infinity,
                child: item.selfieWithCustomer != null && item.selfieWithCustomer!.isNotEmpty
                    ? Image.network(
                  '${Api.imageUrl}${item.selfieWithCustomer}',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : const Image(
                  image: AssetImage('assets/images/prof.jpeg'),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        } else  if (item is LeadApprovedModelData) {
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Details',
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Text("Name: ${item.customerName ?? 'N/A'}"),
              Text("Mobile No: ${item.customerMobileNo ?? 'N/A'}"),
              Text("Loan Amount: ₹${item.loanAmount ?? 'N/A'}"),
              Text("City: ${item.city ?? 'N/A'}"),
              Text("Pincode: ${item.pincode ?? 'N/A'}"),
              const SizedBox(height: 10),
              const Text(
                'Remark By CRM',
                style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 5),
              Text("Remark: N/A"),
              // Replace "N/A" with actual remark data if available.
              const SizedBox(height: 20),
              const Text(
                'Selfie Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Placeholder for image; replace with actual image loading logic if available.
              Container(
                height: 150,
                width: double.infinity,
                child: item.selfieWithCustomer != null && item.selfieWithCustomer!.isNotEmpty
                    ? Image.network(
                  '${Api.imageUrl}${item.selfieWithCustomer}',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : const Image(
                  image: AssetImage('assets/images/prof.jpeg'),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        } else  if (item is LeadRejectedModelData) {
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Details',
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Text("Name: ${item.customerName ?? 'N/A'}"),
              Text("Mobile No: ${item.customerMobileNo ?? 'N/A'}"),
              Text("Loan Amount: ₹${item.loanAmount ?? 'N/A'}"),
              Text("City: ${item.city ?? 'N/A'}"),
              Text("Pincode: ${item.pincode ?? 'N/A'}"),
              const SizedBox(height: 10),
              const Text(
                'Remark By CRM',
                style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 5),
              Text("Remark: N/A"),
              // Replace "N/A" with actual remark data if available.
              const SizedBox(height: 20),
              const Text(
                'Selfie Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Placeholder for image; replace with actual image loading logic if available.
              Container(
                height: 150,
                width: double.infinity,
                child: item.selfieWithCustomer != null && item.selfieWithCustomer!.isNotEmpty
                    ? Image.network(
                  '${Api.imageUrl}${item.selfieWithCustomer}',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : const Image(
                  image: AssetImage('assets/images/prof.jpeg'),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        } else {
          content = const Text('Unknown Model Type');
        }

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: content,
        );
      },
    );
  }

  Widget _buildVisitTab(List<dynamic> leadViewModel) {
    if (leadViewModel.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal scroll for table headings and data
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Table Headers
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: const TableBorder(
                        horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
                        verticalInside: BorderSide.none,
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      defaultColumnWidth: const FixedColumnWidth(150.0),
                      children: const [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'CUSTOMER NAME',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'MOBILE NO',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'LOAN AMOUNT',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'CITY/VILLAGE NAME',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'PINCODE',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'ASSIGNED TO',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'ACTION',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Table Rows (Dynamic Data)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: const TableBorder(
                        horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
                        verticalInside: BorderSide.none,
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      defaultColumnWidth: const FixedColumnWidth(150.0),
                      children: leadViewModel.map((item) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.customerName ?? 'N/A', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black45)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.customerMobileNo ?? 'N/A', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black45)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('₹${item.loanAmount}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black45)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.city ?? 'N/A', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black45)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.pincode ?? 'N/A', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black45)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.employeeAssignName ?? 'N/A', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black45)),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center, // Center the button within the cell vertically and horizontally
                                child: SizedBox(
                                  width: 70, // Set button width
                                  height: 30, // Set button height
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(70, 30),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Navigate to detailed view
                                      showCustomerDetailsDialog(context, item);
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      size: 20, // Adjust icon size to fit the button
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),


                            /* Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to detailed view
                                  },
                                  child:Icon(
                                    Icons.remove_red_eye, // The forward arrow icon
                                    size: 30,            // Adjust size as needed
                                    color: Colors.white,   // Adjust color as needed
                                  ),

                                ),
                              ),
                            ),*/
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
