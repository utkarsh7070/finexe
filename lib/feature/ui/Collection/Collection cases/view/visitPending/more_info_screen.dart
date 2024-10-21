import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../base/utils/namespase/app_style.dart';
import '../../../../../base/utils/namespase/font_size.dart';
import '../../view_model/more_info_view_model.dart';
import 'employee_data_source.dart';

class CollectionMoreInfoScreen extends ConsumerStatefulWidget {
  const CollectionMoreInfoScreen({super.key});

  @override
  _MoreInfoScreen createState() => _MoreInfoScreen();
}
class _MoreInfoScreen extends ConsumerState<CollectionMoreInfoScreen>  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // final dataSource = ref.watch(employeeDataGridSourceProvider);
    final employees = ref.watch(dataProvider);
    final columns = ref.watch(columnProvider);
    final dataSource = ref.watch(employeeDataGridSourceProvider);
    final selectedTab = ref.watch(selectedTabProvider);
    // final employeeDataSource = EmployeeDataSource(employees);
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Info'),
      ),
      body: SizedBox(
        width: displayWidth(context),
        height: displayHeight(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ExpansionTile(
                childrenPadding: const EdgeInsets.only(left: 16,bottom: 10),
                shape: const Border(
                    bottom: BorderSide(
                  color: AppColors.dividerColor,
                )),
                title: const Text('Applicant Details'),
                children: <Widget>[
                  textData(context, text1: 'LD No', text2: 'FINC956'),
                  textData(context, text1: 'Customer', text2: 'Lakhan'),
                  textData(context, text1: 'Father Name', text2: 'Ramprasad'),
                ],
              ),
              // const Divider(
              //   thickness: 1,
              //   color: AppColors.dividerColor,
              // ),
              ExpansionTile(
                shape: const Border(
                    bottom: BorderSide(
                  color: AppColors.dividerColor,
                )),
                childrenPadding: const EdgeInsets.only(left: 16,bottom: 10),
                title: const Text('Co-Applicant Details'),
                children: <Widget>[
                  textData(context, text1: 'Name', text2: 'Radha Bai'),
                  textData(context, text1: 'Mobile No', text2: '7805809432'),
                  textData(context,
                      text1: 'Address',
                      text2:
                          'Gram Panali Panali Rajgarh Madhya Pradesh 465683'),
                ],
              ),
              // const Divider(
              //   thickness: 1,
              //   color: AppColors.dividerColor,
              // ),
              ExpansionTile(
                shape: const Border(
                    bottom: BorderSide(
                  color: AppColors.dividerColor,
                )),
                childrenPadding: const EdgeInsets.only(left: 16,bottom: 10),
                title: const Text('Guarantor Details'),
                children: <Widget>[
                  textData(context, text1: 'Name', text2: 'Radha Bai'),
                  textData(context, text1: 'Mobile No', text2: '7805809432'),
                  textData(context,
                      text1: 'Address',
                      text2:
                          'Gram Panali Panali Rajgarh Madhya Pradesh 465683'),
                ],
              ),
              // const Divider(
              //   thickness: 1,
              //   color: AppColors.dividerColor,
              // ),
              ExpansionTile(
                shape: const Border(
                    bottom: BorderSide(
                  color: AppColors.dividerColor,
                )),
                childrenPadding: const EdgeInsets.only(left: 16,bottom: 10),
                // shape: const RoundedRectangleBorder(),
                title: const Text('Payment Summery'),
                children: <Widget>[
                  textData(context, text1: 'LD No', text2: 'FINC956'),
                  textData(context, text1: 'LD No', text2: 'FINC956'),
                  textData(context, text1: 'LD No', text2: 'FINC956'),
                ],
              ),
              // const Divider(
              //   thickness: 1,
              //   color: AppColors.dividerColor,
              // ),
              SizedBox(height: displayHeight(context) * 0.03),
              Container(
                padding: const EdgeInsets.only(left: 16),
                height: displayHeight(context) * 0.05,
                width: displayWidth(context),
                color: AppColors.primaryLight1,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Additional Info',
                      style: AppStyles.TextStyle16.copyWith(
                          fontSize: FontSize.fontSizeS),
                    )),
              ),
              SizedBox(height: displayHeight(context)*0.02,),
              CustomSlidingSegmentedControl<int>(innerPadding: EdgeInsets.all(5),
                padding:10,
                initialValue: 1,
                children: const {
                  1: Text('Visit'),
                  2: Text('Collection'),
                  3: Text('Calling'),
                  4: Text('Notice'),
                  5: Text('Closuer'),
                },
                decoration: BoxDecoration(
                  color: CupertinoColors.lightBackgroundGray,
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
                onValueChanged: (v) {
                  ref.read(selectedTabProvider.notifier).state = v;
                  print(v);
                },
              ),
              // SizedBox(
              //   width: displayWidth(context),
              //   height: displayHeight(context)*0.04,
              //   child: TabBar(
              //     onTap: (index) {
              //       ref.read(selectedTabProvider.notifier).state = index;
              //     },
              //     tabs: const [
              //       Tab(text: 'Tab 1'),
              //       Tab(text: 'Tab 2'),
              //       Tab(text: 'Tab 3'),
              //       Tab(text: 'Tab 4'),
              //     ],
              //   ),
              // ),

              SizedBox(
                height: displayHeight(context) * 0.40,
                child: SfDataGrid(
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  //   footer:
                  // Container(
                  //   color: Colors.grey[300],
                  //   alignment: Alignment.center,
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Total Employees: ${employees.length}',
                  //         style: const TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //       Text(
                  //         'Average Salary: \$${employees.map((e) => e.salary).reduce((a, b) => a + b) / employees.length}',
                  //         style: const TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  source: dataSource,
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: 'id',
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'ID',
                            ))),
                    GridColumn(
                        columnName: 'name',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('Name'))),
                    GridColumn(
                        columnName: 'designation',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Designation',
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'salary',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('Salary'))),
                  ],
                ),
              ),
              SfDataPagerTheme(
                data: const SfDataPagerThemeData(
                  itemBorderColor: AppColors.primaryLight,
                ),
                child: SfDataPager(

                  delegate: dataSource,
                  pageCount: (employees.length / dataSource.pageSize)
                      .ceil()
                      .toDouble(),
                  availableRowsPerPage: const [10, 20, 50],
                  // pageSize: employeeDataSource.pageSize,
                  onRowsPerPageChanged: (int? rowsPerPage) {
                    dataSource.pageSize = rowsPerPage ?? 10;
                    dataSource.handlePageChange(0, 0);
                  },
                ),
              ),
            ],
          ),
        ),
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
}
