import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

// Common class for a paginated data grid
class CommonPaginatedDataGrid<T> extends StatelessWidget {
  final List<T> data; // Data list of generic type T
  final List<GridColumn> columns; // Columns configuration for the DataGrid
  final int pageSize; // Number of rows per page
  final List<DataGridRow> Function(List<T> data) buildRows; // Function to build rows
  final DataGridRowAdapter Function(DataGridRow row) buildRowAdapter; // Function to build row adapter
  final List<int> availableRowsPerPage; // Options for rows per page

  const CommonPaginatedDataGrid({super.key, 
    required this.data,
    required this.columns,
    required this.pageSize,
    required this.buildRows,
    required this.buildRowAdapter,
    this.availableRowsPerPage = const [10, 20, 50],
  });

  @override
  Widget build(BuildContext context) {
    final dataSource = _CommonDataGridSource(
      data: data,
      buildRows: buildRows,
      buildRowAdapter: buildRowAdapter,
      pageSize: pageSize,
    );

    return Column(
      children: [
        Expanded(
          child: SfDataGrid(
            source: dataSource,
            columns: columns,
          ),
        ),
        SfDataPagerTheme(
          data: const SfDataPagerThemeData(
            // itemStyle: DataPagerItemStyle(
            //   selectedItemColor: Colors.blue,
            //   itemColor: Colors.white,
            //   textStyle: TextStyle(color: Colors.black),
            ),

          child: SfDataPager(
            delegate: dataSource,
            pageCount: (data.length / pageSize).ceil().toDouble(),
            availableRowsPerPage: availableRowsPerPage,
            // pageSize: pageSize,
            onRowsPerPageChanged: (int? rowsPerPage) {
              if (rowsPerPage != null) {
                dataSource.updatePageSize(rowsPerPage);
              }
            },
          ),
        ),
      ],
    );
  }
}

// Data source for the CommonPaginatedDataGrid
class _CommonDataGridSource<T> extends DataGridSource {
  final List<T> data;
  final List<DataGridRow> Function(List<T> data) buildRows;
  final DataGridRowAdapter Function(DataGridRow row) buildRowAdapter;
  int pageSize;

  List<DataGridRow> paginatedRows = [];

  _CommonDataGridSource({
    required this.data,
    required this.buildRows,
    required this.buildRowAdapter,
    required this.pageSize,
  }) {
    _buildPaginatedRows();
  }

  @override
  List<DataGridRow> get rows => paginatedRows;

  void _buildPaginatedRows() {
    paginatedRows = buildRows(data);
  }

  void updatePageSize(int newPageSize) {
    pageSize = newPageSize;
    notifyListeners();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return buildRowAdapter(row);
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    final int startRowIndex = newPageIndex * pageSize;
    final int endRowIndex = startRowIndex + pageSize;
    paginatedRows = buildRows(
      data.getRange(startRowIndex, endRowIndex > data.length ? data.length : endRowIndex).toList(),
    );
    notifyListeners();
    return true;
  }
}
