import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final pdExpensesProvider = StateNotifierProvider<PdExpensesViewModel, List<PdExpenseEntry>>(
      (ref) => PdExpensesViewModel(),
);


class PdExpensesViewModel extends StateNotifier<List<PdExpenseEntry>> {
  PdExpensesViewModel() : super([_createInitialEntry()]);

  static PdExpenseEntry _createInitialEntry() {
    return PdExpenseEntry(
      fileNoController: TextEditingController(),
      customerNameController: TextEditingController(),
      kmTravelFromBranchController: TextEditingController(),
    );
  }

  void addExpenseEntry() {
    state = [...state, _createInitialEntry()];
  }

  void removeExpenseEntry(int index) {
    if (index >= 0 && index < state.length) {
      _disposeControllers(state[index]);
      state = [...state]..removeAt(index);
    }
  }

  void updateExpenseField(int index, String fieldName, dynamic value) {
    if (index >= 0 && index < state.length) {
      final entry = state[index];
      final updatedEntry = entry.copyWith(
        dateOfVisit: fieldName == 'dateOfVisit' && value != null && value.isNotEmpty
            ? value
            : entry.dateOfVisit, // Keep the existing value if null/empty
        denominator: fieldName == 'denominator' ? value : entry.denominator,
      );
      state = [...state]..[index] = updatedEntry;
      print("Updated Entry: $updatedEntry");
    }
  }


  void updateControllerValue(int index, String fieldName, String value) {
    if (index >= 0 && index < state.length) {
      final entry = state[index];
      switch (fieldName) {
        case 'fileNo':
          entry.fileNoController.text = value;
          break;
        case 'customerName':
          entry.customerNameController.text = value;
          break;
        case 'kmTravelFromBranch':
          entry.kmTravelFromBranchController.text = value;
          break;
      }
    }
  }

  void resetEntry(int index) {
    if (index >= 0 && index < state.length) {
      final entry = state[index];
      entry.fileNoController.clear();
      entry.customerNameController.clear();
      entry.kmTravelFromBranchController.clear();
      final updatedEntry = entry.copyWith(
        dateOfVisit: '',
        denominator: const [],
      );
      state = [...state]..[index] = updatedEntry;
    }
  }

  void submitPdExpensesData() {
    for (var entry in state) {
      final fileNo = entry.fileNoController.text;
      final customerName = entry.customerNameController.text;
      final kmTravelFromBranch = entry.kmTravelFromBranchController.text;
      // Add your submission logic (API call, saving data, etc.)
    }
  }

  void updateDenominator(int index, List<String> newDenominator) {
    if (index >= 0 && index < state.length) {
      final entry = state[index];
      final updatedEntry = entry.copyWith(denominator: newDenominator);
      state = [...state]..[index] = updatedEntry;
    }
  }

  Future<void> openDatePicker(int index, BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate); // Format the date
      updateExpenseField(index, 'dateOfVisit', formattedDate);
    }
  }


  bool isRentDateValid(String rentDate) {
    try {
      final DateTime currentDate = DateTime.now();
      final DateTime rentDateTime = DateTime.parse(rentDate);
      return rentDateTime.isBefore(currentDate);
    } catch (e) {
      print("Invalid rent date format: $e");
      return false; // Default to invalid if parsing fails
    }
  }


  @override
  void dispose() {
    for (final entry in state) {
      _disposeControllers(entry);
    }
    super.dispose();
  }

  void _disposeControllers(PdExpenseEntry entry) {
    entry.fileNoController.dispose();
    entry.customerNameController.dispose();
    entry.kmTravelFromBranchController.dispose();
  }
}


// class PdExpenseEntry {
//   final String dateOfVisit;
//   final String fileNo;
//   final String customerName;
//   final String kmTravelFromBranch;
//   final List<String> denominator;
//   final bool isRentDateValid;
//
//   PdExpenseEntry({
//     this.dateOfVisit = '',
//     this.fileNo = '',
//     this.customerName = '',
//     this.kmTravelFromBranch = '',
//     this.denominator = const [],
//     this.isRentDateValid = true,
//   });
//
//   PdExpenseEntry copyWith({
//     String? dateOfVisit,
//     String? fileNo,
//     String? customerName,
//     String? kmTravelFromBranch,
//     List<String>? denominator,
//     bool? isRentDateValid,
//   }) {
//     return PdExpenseEntry(
//       dateOfVisit: dateOfVisit ?? this.dateOfVisit,
//       fileNo: fileNo ?? this.fileNo,
//       customerName: customerName ?? this.customerName,
//       kmTravelFromBranch: kmTravelFromBranch ?? this.kmTravelFromBranch,
//       denominator: denominator ?? this.denominator,
//       isRentDateValid: isRentDateValid ?? this.isRentDateValid,
//     );
//   }
// }


class PdExpenseEntry {
  final TextEditingController fileNoController;
  final TextEditingController customerNameController;
  final TextEditingController kmTravelFromBranchController;
  final String dateOfVisit;
  final List<String> denominator;

  PdExpenseEntry({
    required this.fileNoController,
    required this.customerNameController,
    required this.kmTravelFromBranchController,
    this.dateOfVisit = '',
    this.denominator = const ['Approve', 'Reject'],
  });

  PdExpenseEntry copyWith({
    TextEditingController? fileNoController,
    TextEditingController? customerNameController,
    TextEditingController? kmTravelFromBranchController,
    String? dateOfVisit,
    List<String>? denominator,
  }) {
    return PdExpenseEntry(
      fileNoController: fileNoController ?? this.fileNoController,
      customerNameController: customerNameController ?? this.customerNameController,
      kmTravelFromBranchController: kmTravelFromBranchController ?? this.kmTravelFromBranchController,
      dateOfVisit: dateOfVisit ?? this.dateOfVisit,
      denominator: denominator ?? this.denominator,
    );
  }
}

final dateProvider = StateNotifierProvider<DateNotifier, DateTime?>((ref) {
  return DateNotifier();
});

class DateNotifier extends StateNotifier<DateTime?> {
  DateNotifier() : super(null);

  void updateDate(DateTime newDate) {
    state = newDate;
  }
}
