import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../../SalesOnBoardingForm/view/Sales_on_boarding_form/applicant_form/appliction_form.dart';
import '../../SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_screen.dart';
import '../../SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/dialog/form_completed_dialog.dart';
import '../../SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/guarantor_form_1.dart';

import '../../SalesOnBoardingForm/view_model/guarantor_form_view_model.dart';
import '../model/show_cashes_status_model.dart';
import '../view_model/showing_cash_status_view_model.dart';

/*class CasesDetails extends ConsumerWidget{
  const CasesDetails({super.key});*/

class CasesDetails extends ConsumerStatefulWidget {
  // const AttendanceDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CasesDetails> createState() => _CasesDetailsState();
  final String customerId;
  final String customerName;
  CasesDetails({required this.customerId, required this.customerName});
}

class _CasesDetailsState extends ConsumerState<CasesDetails> {
// Define a provider for managing the expanded state of each section
  final sectionExpansionProvider =
      StateProvider.family<bool, String>((ref, sectionName) => false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('customer Id ${widget.customerId}');
      _initializeData();
    });
    // Call an async method
  }

  Future<void> _initializeData() async {
    await saveCustomerId(widget.customerId);
    print('Customer ID saved successfully: ${widget.customerId}');

    // Fetch data when the screen initializes
    ref
        .read(processStatusProvider.notifier)
        .fetchProcessStatus(widget.customerId);
  }

  Future<void> saveCustomerId(String customerId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('customerId', customerId);
    print('Customer ID saved successfully: $customerId');
  }

  @override
  Widget build(BuildContext context) {
    final processStatus = ref.watch(processStatusProvider);
    final processStatusViewModel = ref.read(processStatusProvider.notifier);
    final goPayment = ref.read(paymentCaseProvider((context)).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerName, style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: processStatus.when(
            data: (data) {
              if (data == null) {
                return Center(child: Text('No data available'));
              }

              // Map sections with their corresponding data
              final sections = {
                'Sales': data.sales,
                'Cibil': data.cibil,
                'Branch Pendancy': data.branchPendancy,
                /* 'Vendor Details': data.vendorDetails,*/
                'PD': data.pd,
              };

              // Build a collapsible list view
              return ListView(
                children: sections.entries.map((entry) {
                  final sectionName = entry.key;
                  final sectionData = entry.value;

                  return _buildSection(
                    processStatusViewModel: processStatusViewModel,
                    sectionName: sectionName,
                    sectionData: sectionData,
                    ref: ref,
                    goPayment: goPayment,
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ),
      ),
    );
  }

// Collapsible Section Builder
  Widget _buildSection(
      {required String sectionName,
      required dynamic sectionData,
      required WidgetRef ref,
      required dynamic goPayment,
      required dynamic processStatusViewModel}) {
    final isExpanded = ref.watch(sectionExpansionProvider(sectionName));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            ref.read(sectionExpansionProvider(sectionName).notifier).state =
                !isExpanded;
          },
          child: Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _buildSectionContent(
                sectionData, goPayment, processStatusViewModel),
          ),
      ],
    );
  }

  Widget _buildSectionContent(
      dynamic sectionData, dynamic goPayment, dynamic processStatusViewModel) {
    if (sectionData == null) {
      return const Text('No data available');
    }

    // Convert the section data to a list of key-value pairs
    final fields = sectionData.toJson().entries.toList();

    if (sectionData is Sales) {
      print('Section data ${sectionData.toString()}');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Check if any field is 'pending' and navigate accordingly
              if (sectionData.isApplicationPending()) {
                // Navigate to Screen 1 if applicationStatus is pending
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApplicationDetails()),
                );
              } else if (sectionData.isCoApplicationPending()) {
                // Navigate to Screen 2 if coApplicationStatus is pending
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoApplicantScreen()),
                );
              } else if (sectionData.isGuarantorPending()) {
                // Navigate to Screen 3 if guarantorStatus is pending
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuarantorDetails()),
                );
              } else if (sectionData.isPaymentPending()) {
                /* final goPayment = ref.read(paymentProvider((context)).notifier);

                goPayment.payWithRazorPay( amount: sectionData.paymentAmount,
                    mobile: sectionData.cutomerNumber.toString(),
                    orderId: '');*/

                // final personalFormViewModel = ref.read(guarantorViewModelProvider.notifier);
                // final goPayment = ref.read(paymentProvider((context)).notifier);

                processStatusViewModel.paymentInitiate2(widget.customerId).then(
                  (value) {
                    Navigator.pop(context);
                    /*if (kDebugMode) {
                      print(getMobileNo.phoneNumber);
                    }*/
                    print('Login fees ${value.items.customerDetail.loginFees}');
                    if (value.items.customerDetail.loginFees != 0) {
                      goPayment.payWithRazorPay(
                          amount: value.items.customerDetail.loginFees,
                          mobile: sectionData.cutomerNumber.toString(),
                          orderId: value.items.customerDetail.orderId);
                      // FormSubmitDialog().formSubmitDialog(context: context);
                    } else {
                      FormSubmitDialog().formSubmitDialog(context: context);
                    }
                  },
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: fields.map<Widget>((field) {
                final key = field.key;
                final value = field.value;

                // Check the value for status conditions
                bool isPending = value != null &&
                    value.toString().toLowerCase() == 'pending';
                bool isCompletedOrApproved = value != null &&
                    (value.toString().toLowerCase() == 'completed' ||
                        value.toString().toLowerCase() == 'approved');

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Field Key
                      Text(key,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Show a green check icon for 'completed' or 'approved' values
                            if (isCompletedOrApproved)
                              const SizedBox(
                                width: 24,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            // Show an orange pending icon for 'pending' values
                            if (isPending)
                              SizedBox(
                                width: 24,
                                height: 24,
                                /* child: Icon(
                                  Icons.pending,
                                  color: Colors.orange,
                                  size: 20,
                                ),*/
                                child: Image.asset(
                                  'assets/images/wall_clock.png',
                                  // Replace with your custom icon path
                                  fit: BoxFit.contain,
                                ),
                              ),
                            // Show the value text otherwise
                            if (!isCompletedOrApproved && !isPending)
                              Flexible(
                                child: Text(
                                  value?.toString() ?? 'N/A',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    }

    // Handle Cibil Section
    if (sectionData is Cibil) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields.map<Widget>((field) {
          final key = field.key;
          final value = field.value;

          // Check the value for status conditions
          // bool isPending = value != null && value.toString().toLowerCase() == 'pending';
          bool isPending = value != null &&
              (value.toString().toLowerCase() == 'pending' ||
                  value.toString().toLowerCase() == 'notAssign');
          bool isCompletedOrApproved = value != null &&
              (value.toString().toLowerCase() == 'completed' ||
                  value.toString().toLowerCase() == 'approved');

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Field Key
                Text(key, style: const TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Show a green check icon for 'completed' or 'approved' values
                      if (isCompletedOrApproved)
                        const SizedBox(
                          width: 24,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      // Show an orange pending icon for 'pending' values
                      if (isPending)
                        SizedBox(
                          width: 24,
                          height: 24,
                          /* child: Icon(
                                  Icons.pending,
                                  color: Colors.orange,
                                  size: 20,
                                ),*/
                          child: Image.asset(
                            'assets/images/wall_clock.png',
                            // Replace with your custom icon path
                            fit: BoxFit.contain,
                          ),
                        ),
                      // Show the value text otherwise
                      if (!isCompletedOrApproved && !isPending)
                        Flexible(
                          child: Text(
                            value?.toString() ?? 'N/A',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    // Handle Branch Pendancy Section
    if (sectionData is BranchPendancy) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields.map<Widget>((field) {
          final key = field.key;
          final value = field.value;

          // Check the value for status conditions
          bool isPending = value != null &&
              (value.toString().toLowerCase() == 'notAssign' ||
                  value.toString().toLowerCase() == 'pending');
          bool isCompletedOrApproved = value != null &&
              (value.toString().toLowerCase() == 'completed' ||
                  value.toString().toLowerCase() == 'approved');

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Field Key
                Text(key, style: const TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Show a green check icon for 'completed' or 'approved' values
                      if (isCompletedOrApproved)
                        const SizedBox(
                          width: 24,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      // Show an orange pending icon for 'pending' values
                      if (isPending)
                        SizedBox(
                          width: 24,
                          height: 24,
                          /* child: Icon(
                                  Icons.pending,
                                  color: Colors.orange,
                                  size: 20,
                                ),*/
                          child: Image.asset(
                            'assets/images/wall_clock.png',
                            // Replace with your custom icon path
                            fit: BoxFit.contain,
                          ),
                        ),
                      // Show the value text otherwise
                      if (!isCompletedOrApproved && !isPending)
                        Flexible(
                          child: Text(
                            value?.toString() ?? 'N/A',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    // Handle PD Section
    if (sectionData is PD) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields.map<Widget>((field) {
          final key = field.key;
          final value = field.value;

          // Check the value for status conditions
          bool isPending = value != null &&
              (value.toString().toLowerCase() == 'notAssing' ||
                  value.toString().toLowerCase() == 'pending');
          bool isCompletedOrApproved = value != null &&
              (value.toString().toLowerCase() == 'completed' ||
                  value.toString().toLowerCase() == 'approved');

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Field Key
                Text(key, style: const TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Show a green check icon for 'completed' or 'approved' values
                      if (isCompletedOrApproved)
                        const SizedBox(
                          width: 24,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      // Show an orange pending icon for 'pending' values
                      if (isPending)
                        SizedBox(
                          width: 24,
                          height: 24,
                          /* child: Icon(
                                  Icons.pending,
                                  color: Colors.orange,
                                  size: 20,
                                ),*/
                          child: Image.asset(
                            'assets/images/wall_clock.png',
                            // Replace with your custom icon path
                            fit: BoxFit.contain,
                          ),
                        ),
                      // Show the value text otherwise
                      if (!isCompletedOrApproved && !isPending)
                        Flexible(
                          child: Text(
                            value?.toString() ?? 'N/A',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    return const Text('No valid section data available');
  }
}
