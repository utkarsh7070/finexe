import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/VisitItemClosureModelData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/api.dart';
import '../../model/VisitItemCallingModelData.dart';
import '../../model/VisitItemCollectionModelData.dart';
import '../../model/VisitItemDetailModelData.dart';
import '../../model/VisitItemNoticeModelData.dart';
import '../../model/visit_pending_items_model.dart';
import '../../view_model/visit_detail_view_model.dart';
import '../../view_model/visit_pending_view_model.dart';


class CollectionMoreInfoScreen extends ConsumerStatefulWidget {

  @override
  _MoreInfoScreen createState() => _MoreInfoScreen();

  final int index;
  CollectionMoreInfoScreen({required int this.index});

}
class _MoreInfoScreen extends ConsumerState<CollectionMoreInfoScreen>  with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: widget.index.clamp(0, 0));
  }

  @override
  void didUpdateWidget(covariant CollectionMoreInfoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update the TabController's index without disposing of it
    if (widget.index != oldWidget.index) {
      _tabController.index = widget.index.clamp(0,0); // ensure it's within bounds
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(fetchVisitPendingDataProvider);
   // navigatorKey: navigatorKey;
    return data.when(

      data: (data) {
        List<ItemsDetails> listOfLists = data.map((map) {
          return ItemsDetails.fromJson(map);
        }).toList();

        final safeIndex = widget.index != null && widget.index < listOfLists.length ? widget.index : 0;
        ItemsDetails item = listOfLists[safeIndex];

        // Extract the LD number from the item
        final String? ldNumber = item.ld;  // Assuming 'ldNumber' is the correct field in ItemsDetails

        // Fetch visit details data
        final visitData = ref.watch(fetchVisitDetailsProvider(ldNumber!)); // Watch the visit details provider


        // Fetch collection details data
        final collectionData = ref.watch(fetchVisitCollectionProvider(ldNumber));

        // Fetch collection details data
        final callingData = ref.watch(fetchVisitCallingProvider(ldNumber));


        // Fetch collection details data
        final noticeData = ref.watch(fetchVisitNoticeProvider(ldNumber));

        // Fetch collection details data
        final closureData = ref.watch(fetchVisitClosureProvider(ldNumber));

        return Scaffold(
          appBar: AppBar(
            title: const Text('More Info'),
          ),
          body: Column(
            children: [
              // First Section: Applicant Details, Co-Applicant Details, Guarantor, Payment Summary
              _buildApplicantDetails(item),
              _buildCoApplicantDetails(item),
              _buildGuarantorDetails(item),
              _buildPaymentSummary(item),

              // Spacer or separator (optional)
              SizedBox(height: displayHeight(context) * 0.03),

              // Tabs Section: Visit, Collection, Calling, Notice, Closure
              Container(
                color: AppColors.primaryLight1, // Optional: style background color of tab section
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: const [
                    Tab(text: 'Visit'),
                    Tab(text: 'Collection'),
                    Tab(text: 'Calling'),
                    Tab(text: 'Notice'),
                    Tab(text: 'Closure'),
                  ],
                ),
              ),
             /* Container(
                color: AppColors.primaryLight1, // Background color of the tab section
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.blue, // Color of the selected tab indicator
                  labelColor: Colors.white, // Color of the selected tab text
                  unselectedLabelColor: Colors.grey, // Color of the unselected tab text
                  tabs: const [
                    Tab(text: 'Visit'),
                    Tab(text: 'Collection'),
                    Tab(text: 'Calling'),
                    Tab(text: 'Notice'),
                    Tab(text: 'Closure'),
                  ],
                ),
              ),*/



              // TabBarView with disabled swipe
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(), // Disable swipe gestures
                  children: [
                    visitData.when(
                      data: (visitDetails) {
                        return _buildVisitTab(visitDetails); // Pass the visit data here
                      },
                      error: (error, stackTrace) {
                        return const Text('Error loading visit details');
                      },
                      loading: () {
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),

                    collectionData.when(
                      data: (collectionDetails) {
                        debugPrint('Collection data loaded successfully');
                        return _buildCollectionTab(collectionDetails);
                      },
                      error: (error, stackTrace) {
                        debugPrint('Error loading collection details: $error');
                        return const Text('Error loading collection details');
                      },
                      loading: () {
                        debugPrint('Collection data loading...');
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),


                    callingData.when(
                      data: (visitCalling) {
                        return _buildCallingTab(visitCalling); // Pass the visit data here
                      },
                      error: (error, stackTrace) {
                        return const Text('Error loading visit Calling');
                      },
                      loading: () {
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),


                    noticeData.when(
                      data: (visitNotice) {
                        return _buildNoticeTab(visitNotice); // Pass the visit data here
                      },
                      error: (error, stackTrace) {
                        return const Text('Error loading visit Notice');
                      },
                      loading: () {
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),

                    closureData.when(
                      data: (closureDetails) {
                        return _buildClosureTab(closureDetails); // Pass the visit data here
                      },
                      error: (error, stackTrace) {
                        return const Text('Error loading visit Closure');
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
        );
      },
      error: (error, stackTrace) {
        return const Text('Error loading data');
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void dispose() {
    // Dispose the TabController when the widget is disposed to prevent memory leaks.
    _tabController.dispose();
    super.dispose();
  }

  // First Section Widgets
  Widget _buildApplicantDetails(ItemsDetails item) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Applicant Details'),
      children: <Widget>[
        textData(context, text1: 'LD No', text2: '${item.ld}'),
        textData(context, text1: 'Customer', text2: '${item.customerName}'),
        textData(context, text1: 'Father Name', text2: '${item.fatherName}'),
      ],
    );
  }

  Widget _buildCoApplicantDetails(ItemsDetails item) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Co-Applicant Details'),
      children: <Widget>[
        textData(context, text1: 'Name', text2: '${item.coBorrower1Name}'),
        textData(context, text1: 'Mobile No', text2: '${item.coBorrower1Mobile}'),
        textData(context, text1: 'Address', text2: '${item.coBorrower1Address}'),
      ],
    );
  }

  Widget _buildGuarantorDetails(ItemsDetails item) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Guarantor Details'),
      children: <Widget>[
        textData(context, text1: 'Name', text2: '${item.gtrName}'),
        textData(context, text1: 'Mobile No', text2: '${item.gtrMobNo}'),
        textData(context, text1: 'Address', text2: '${item.gtrAddress}'),
      ],
    );
  }

  Widget _buildPaymentSummary(ItemsDetails item) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Payment Summary'),
      children: <Widget>[
        textData(context, text1: 'Partner', text2: '${item.partner}'),
        textData(context, text1: 'EMI Amount', text2: '${item.emiAmount}'),
        textData(context, text1: 'Net Due', text2: '${item.netDue}'),
        textData(context, text1: 'Collection Type', text2: '${item.collectionType}'),
        textData(context, text1: 'POS/Closure Amt', text2: '${item.posClosureAmount}'),
      ],
    );
  }

  Widget _buildVisitTab(List<VisitItemDetail> visitData) {
    if (visitData.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal scroll for table headings and data
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allow horizontal scrolling for many columns
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table Headers
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey, width: 0.5), // Horizontal lines
                      verticalInside: BorderSide.none, // No vertical lines
                      bottom: BorderSide(color: Colors.grey, width: 0.5), // Bottom line of the table
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    /*border: TableBorder.all(color: Colors.grey),

                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width*/
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'VISIT DATE',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'CUSTOMER RESPONSE',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'PAYMENT AMOUNT',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'SOLUTION',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'STATUS',
                             /* style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'REJECT REASON',
                             /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Table Rows (Dynamic Data)
               /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.grey),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    children: visitData.map((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.visitDate, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.customerResponse, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${item.paymentAmount}', textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.solution.isNotEmpty ? item.solution : 'N/A', textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.status, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.reasonForNotPay.isNotEmpty ? item.reasonForNotPay : 'N/A', textAlign: TextAlign.center),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),*/

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    // Define a custom TableBorder with only horizontal lines
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey, width: 0.5), // Horizontal lines
                      verticalInside: BorderSide.none, // No vertical lines
                      bottom: BorderSide(color: Colors.grey, width: 0.5), // Bottom line of the table
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    children: visitData.map((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.visitDate, textAlign: TextAlign.center,style:TextStyle(color: Colors.black45) ,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.customerResponse, textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('₹${item.paymentAmount}', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.solution.isNotEmpty ? item.solution : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.status, textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.reasonForNotPay.isNotEmpty ? item.reasonForNotPay : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
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
    );
  }

  Widget textData(context, {required String text1, required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: displayWidth(context) * 0.30, child: Text(text1)),
        SizedBox(width: displayWidth(context) * 0.10, child: const Text('-')),
        SizedBox(width: displayWidth(context) * 0.50, child: Text(text2)),
      ],
    );
  }


  Widget _buildCollectionTab(List<VisitItemCollection> collectionData) {
    if (collectionData.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal scroll for table headings and data
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allow horizontal scrolling for many columns
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table Headers
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey, width: 0.5), // Horizontal lines
                      verticalInside: BorderSide.none, // No vertical lines
                      bottom: BorderSide(color: Colors.grey, width: 0.5), // Bottom line of the table
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    /*border: TableBorder.all(color: Colors.grey),

                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width*/
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'DATE TIME',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'RECEIVED AMOUNT',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'TRANSACTION ID',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'CUSTOMER EMAIL',
                              /* style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'MODE OF COLLECTION',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'OK CREDIT PERSON/ BANK/PARTNER',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'REMARK',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'STATUS',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                // Table Rows (Dynamic Data)
                /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.grey),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    children: visitData.map((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.visitDate, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.customerResponse, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${item.paymentAmount}', textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.solution.isNotEmpty ? item.solution : 'N/A', textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.status, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.reasonForNotPay.isNotEmpty ? item.reasonForNotPay : 'N/A', textAlign: TextAlign.center),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),*/

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    // Define a custom TableBorder with only horizontal lines
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey, width: 0.5), // Horizontal lines
                      verticalInside: BorderSide.none, // No vertical lines
                      bottom: BorderSide(color: Colors.grey, width: 0.5), // Bottom line of the table
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    children: collectionData.map((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.emiReceivedDate,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '₹${item.receivedAmount.toString()}', // Convert double to String
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.transactionId,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.customerEmail != null && item.customerEmail!.isNotEmpty
                                  ? item.customerEmail!
                                  : 'N/A',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (item.modeOfCollectionDetail?.isNotEmpty ?? false)
                                  ? item.modeOfCollectionDetail!.first.title
                                  : 'N/A',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.paymentPerson.isNotEmpty ? item.paymentPerson : 'N/A',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.remarkByCollection.isNotEmpty ? item.remarkByCollection : 'N/A',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.status.isNotEmpty ? item.status : 'N/A',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),

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
    );
  }

  Widget _buildCallingTab(List<VisitItemCalling> visitCalling) {
    if (visitCalling.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal scroll for table headings and data
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allow horizontal scrolling for many columns
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table Headers
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey, width: 0.5), // Horizontal lines
                      verticalInside: BorderSide.none, // No vertical lines
                      bottom: BorderSide(color: Colors.grey, width: 0.5), // Bottom line of the table
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    /*border: TableBorder.all(color: Colors.grey),

                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width*/
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Call Date',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Recall Date',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Call By',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Call Status',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Payment Amount',
                              /* style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Call Remark',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Customer Response',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Reason For NotPay',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Solution',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Reason For Customer Not Contactable',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Required New Number',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                // Table Rows (Dynamic Data)
                /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.grey),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    children: visitData.map((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.visitDate, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.customerResponse, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${item.paymentAmount}', textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.solution.isNotEmpty ? item.solution : 'N/A', textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.status, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.reasonForNotPay.isNotEmpty ? item.reasonForNotPay : 'N/A', textAlign: TextAlign.center),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),*/

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    // Define a custom TableBorder with only horizontal lines
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey, width: 0.5), // Horizontal lines
                      verticalInside: BorderSide.none, // No vertical lines
                      bottom: BorderSide(color: Colors.grey, width: 0.5), // Bottom line of the table
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    children: visitCalling.map((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.date, textAlign: TextAlign.center,style:TextStyle(color: Colors.black45) ,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.reCallDate, textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.callBy, textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.callStatus.isNotEmpty ? item.callStatus : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('₹${item.paymentAmount}', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.callRemark.isNotEmpty ? item.callRemark : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.customerResponse.isNotEmpty ? item.customerResponse : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.reasonForNotPay.isNotEmpty ? item.reasonForNotPay : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.solution.isNotEmpty ? item.solution : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.reasonForCustomerNotContactable.isNotEmpty ? item.reasonForCustomerNotContactable : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.newContactNumber ? 'Yes' : 'No', // or use 'True' : 'False'
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
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
    );
  }

  Widget _buildClosureTab(List<VisitItemClosure> closureData) {
    if (closureData.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal scroll for table headings and data
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allow horizontal scrolling for many columns
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table Headers
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey, width: 0.5), // Horizontal lines
                      verticalInside: BorderSide.none, // No vertical lines
                      bottom: BorderSide(color: Colors.grey, width: 0.5), // Bottom line of the table
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    /*border: TableBorder.all(color: Colors.grey),

                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width*/
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Pos Closer By',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'To Be Received From Customer',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Settlement Amount',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Settlement For Reason',
                              /*style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Date Of Deposit',
                              /* style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Status',
                              /* style: TextStyle(fontWeight: FontWeight.bold),*/
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Table Rows (Dynamic Data)
                /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.grey),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    children: visitData.map((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.visitDate, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.customerResponse, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${item.paymentAmount}', textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.solution.isNotEmpty ? item.solution : 'N/A', textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.status, textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.reasonForNotPay.isNotEmpty ? item.reasonForNotPay : 'N/A', textAlign: TextAlign.center),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),*/

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    // Define a custom TableBorder with only horizontal lines
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey, width: 0.5), // Horizontal lines
                      verticalInside: BorderSide.none, // No vertical lines
                      bottom: BorderSide(color: Colors.grey, width: 0.5), // Bottom line of the table
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150.0), // Set a fixed column width for data rows
                    children: closureData.map((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.posCloserBy, textAlign: TextAlign.center,style:TextStyle(color: Colors.black45) ,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('₹${item.amountToBeReceivedFromCustomer}', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('₹${item.settlementAmountByApproval}', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.settlementForReason.isNotEmpty ? item.settlementForReason : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.dateOfDeposit, textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.status.isNotEmpty ? item.status : 'N/A', textAlign: TextAlign.center,style:TextStyle(color: Colors.black45)),
                          ),
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
    );
  }

  Widget _buildNoticeTab(List<VisitItemNotice> visitNotice) {
    if (visitNotice.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: visitNotice.length,
      itemBuilder: (context, index) {
        final document = visitNotice[index];
        final isPdf = document.document.endsWith('.pdf');
        final isAvif = document.document.endsWith('.avif');
        final imageUrl = '${Api.imageUrl}${document.document}';

        return SingleChildScrollView( // Wrap in SingleChildScrollView
          child: Column(
            children: [
              if (isPdf)
                const Icon(Icons.picture_as_pdf, size: 80, color: Colors.red)
              else if (isAvif)
                AvifImage.network(
                  '${Api.imageUrl}${document.document}',
                  height: 100,
                  fit: BoxFit.contain,
                )
              else
                Image.network(
                  imageUrl,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Set button background color
                      foregroundColor: Colors.white, // Set button text color
                    ),
                    onPressed: () {
                      // Open image or PDF viewer
                      _showImageDialog(context, imageUrl, isPdf, document.document);
                    },
                    child: Text(isPdf ? 'View PDF' : 'View Image' ,),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to show dialog with large image or PDF
  void _showImageDialog(BuildContext context, String url, bool isPdf, String documentName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isPdf)
              const Icon(Icons.picture_as_pdf, size: 100, color: Colors.red)
                // Show PDF as an image (you might want to use a PDF viewer package for actual PDFs)
                  /*Image.network(
                    url, // URL for the PDF cover or thumbnail
                    fit: BoxFit.cover,
                  )*/
                  else if(url.endsWith('.avif'))
                  AvifImage.network(
                    url,
                    height: 300,
                    fit: BoxFit.contain,
                  )
                else
                // Show image
                  Image.network(
                    url,
                    fit: BoxFit.cover,
                    height: 300, // Set a height for the large image
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _downloadFile(context, url, documentName); // Pass context here

                      },
                      child: const Text('Download',style: TextStyle(color: Colors.white),),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Future<void> _downloadFile(BuildContext context, String url, String documentName) async {
    try {
      Dio dio = Dio();

      // Use the "Downloads" directory to make it more accessible
      Directory downloadDir = Directory('/storage/emulated/0/Download/Finexe Document');
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);  // Create the folder if it doesn't exist
      }

      // Set the file name and path
      if (documentName.isEmpty) {
        documentName = url.split('/').last;  // Extract file name from URL if not provided
      }
      String filePath = '${downloadDir.path}/$documentName';

      // Start downloading the file
      await dio.download(url, filePath);

      // Show the file path when download is complete
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded to: $filePath')),
      );
    } catch (e) {
      // Handle any errors during download
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading file: $e')),
      );
    }
  }

}

