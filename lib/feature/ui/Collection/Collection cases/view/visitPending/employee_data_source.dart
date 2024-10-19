import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CommonDataGridSource<T> extends DataGridSource {
  final List<T> data;
  final List<DataGridRow> Function(List<T> data) buildRows;
  final DataGridRowAdapter Function(DataGridRow row) buildRowAdapter;
  int pageSize;
  int pageIndex = 0;
  List<DataGridRow> paginatedRows = [];

  CommonDataGridSource({
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
    final startRowIndex = pageIndex * pageSize;
    final endRowIndex = startRowIndex + pageSize;
    paginatedRows = buildRows(
      data.getRange(startRowIndex, endRowIndex > data.length ? data.length : endRowIndex).toList(),
    );
  }

  void updatePageSize(int newPageSize) {
    pageSize = newPageSize;
    _buildPaginatedRows();
    notifyListeners();
  }

  void updatePageIndex(int newPageIndex) {
    pageIndex = newPageIndex;
    _buildPaginatedRows();
    notifyListeners();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return buildRowAdapter(row);
  }

  CommonDataGridSource<T> copyWithPageSize(int newPageSize) {
    return CommonDataGridSource<T>(
      data: data,
      buildRows: buildRows,
      buildRowAdapter: buildRowAdapter,
      pageSize: newPageSize,
    );
  }

  CommonDataGridSource<T> copyWithPageIndex(int newPageIndex) {
    return CommonDataGridSource<T>(
      data: data,
      buildRows: buildRows,
      buildRowAdapter: buildRowAdapter,
      pageSize: pageSize,
    )..updatePageIndex(newPageIndex);
  }
}
