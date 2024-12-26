import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../view/visitPending/employee_data_source.dart';

// Data model for Employee
class DataModel {
  DataModel(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final double salary;
}

final selectedTabProvider = StateProvider<int>((ref) => 0);

// Provider to provide the data based on the selected tab
final dataProvider = Provider<List<DataModel>>((ref) {
  final selectedTab = ref.watch(selectedTabProvider);
  // Return different data based on the selected tab
  switch (selectedTab) {
    case 1:
      return List.generate(20, (index) => DataModel(index, 'Item A$index', 'Description A$index', 100.0 + index));
    case 2:
      return List.generate(15, (index) => DataModel(index, 'Item B$index', 'Description B$index', 200.0 + index));
    case 3:
      return List.generate(25, (index) => DataModel(index, 'Item C$index', 'Description C$index', 300.0 + index));
    default:
      return List.generate(10, (index) => DataModel(index, 'Item D$index', 'Description D$index', 400.0 + index));
  }
});

// Provider to define columns for each tab
final columnProvider = Provider<List<GridColumn>>((ref) {
  final selectedTab = ref.watch(selectedTabProvider);
  // Return different column configurations based on the selected tab
  switch (selectedTab) {
    case 1:
      return [
        GridColumn(
          columnName: 'id',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('ID')),
        ),
        GridColumn(
          columnName: 'name',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('Item Name')),
        ),
        GridColumn(
          columnName: 'description',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('Description')),
        ),
        GridColumn(
          columnName: 'value',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('Value')),
        ),
      ];
    case 2:
      return [
        GridColumn(
          columnName: 'id',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('ID')),
        ),
        GridColumn(
          columnName: 'name',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('Name')),
        ),
      ];
    case 3:
      return [
        GridColumn(
          columnName: 'id',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('ID')),
        ),
        GridColumn(
          columnName: 'value',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('Value')),
        ),
      ];
    default:
      return [
        GridColumn(
          columnName: 'id',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('ID')),
        ),
        GridColumn(
          columnName: 'name',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('Name')),
        ),
        GridColumn(
          columnName: 'description',
          label: Container(padding: const EdgeInsets.all(8.0), alignment: Alignment.center, child: const Text('Description')),
        ),
      ];
  }
});
// Provider to create a data source for the grid
// final dataSourceProvider = Provider<DataGridSource>((ref) {
//   final data = ref.watch(dataProvider);
//
//   return CommonDataSource(
//     data: data,
//     buildRows: (data) => data.map<DataGridRow>((e) {
//       return DataGridRow(cells: [
//         DataGridCell<int>(columnName: 'id', value: e.id),
//         DataGridCell<String>(columnName: 'name', value: e.name),
//         DataGridCell<String>(columnName: 'description', value: e.designation),
//         DataGridCell<double>(columnName: 'value', value: e.salary),
//       ]);
//     }).toList(),
//   );
// });



// // Provider for managing pagination state and DataGrid source
final employeeDataGridSourceProvider = StateNotifierProvider<EmployeeDataGridSourceNotifier, CommonDataGridSource<DataModel>>((ref) {
  final employees = ref.watch(dataProvider);
  return EmployeeDataGridSourceNotifier(employees);
});

// StateNotifier for managing the data source state
class EmployeeDataGridSourceNotifier extends StateNotifier<CommonDataGridSource<DataModel>> {
  EmployeeDataGridSourceNotifier(List<DataModel> employees)
      : super(CommonDataGridSource<DataModel>(
    data: employees,
    buildRows: (employees) => employees.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: e.id),
        DataGridCell<String>(columnName: 'name', value: e.name),
        DataGridCell<String>(columnName: 'designation', value: e.designation),
        DataGridCell<double>(columnName: 'salary', value: e.salary),
      ]);
    }).toList(),
    buildRowAdapter: (row) => DataGridRowAdapter(cells: [
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(row.getCells()[2].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString()),
      ),
    ]),
    pageSize: 10,
  ));

  void updatePageSize(int newPageSize) {
    state = state.copyWithPageSize(newPageSize);
  }

  void handlePageChange(int oldPageIndex, int newPageIndex) {
    state = state.copyWithPageIndex(newPageIndex);
  }
}
