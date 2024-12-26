import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a model for a single branch expense entry
class BranchExpenseEntry {
  final TextEditingController branchController;
  final TextEditingController amountController;
  final String? selectedBranchType;
  final String? claimType;
  final List<String> branchType;

  BranchExpenseEntry({
    required this.branchController,
    required this.amountController,
    this.selectedBranchType ='',
    this.claimType,
    this.branchType = const ['WIP', 'Complete', 'Tea Bill','Water Bill'],
  });

  BranchExpenseEntry copyWith({
    TextEditingController? branchController,
    TextEditingController? amountController,
    String? selectedBranchType,
    String? claimType,
    List<String>? branchType,
  }) {
    return BranchExpenseEntry(
      branchController: branchController ?? this.branchController,
      amountController: amountController ?? this.amountController,
      selectedBranchType: selectedBranchType ?? this.selectedBranchType,
      claimType: claimType ?? this.claimType,
      branchType: branchType ?? this.branchType,
    );
  }
}

// Provider for managing branch expenses
class BranchExpensesProvider extends StateNotifier<List<BranchExpenseEntry>> {
  BranchExpensesProvider() : super([_createInitialEntry()]);

  // Create the initial entry
  static BranchExpenseEntry _createInitialEntry() {
    return BranchExpenseEntry(
      branchController: TextEditingController(),
      amountController: TextEditingController(),
    );
  }

  // Add a new expense entry
  void addExpenseEntry() {
    state = [...state, _createInitialEntry()];
  }

  // Remove an expense entry by index
  void removeExpenseEntry(int index) {
    if (index >= 0 && index < state.length) {
      _disposeControllers(state[index]);
      state = [...state]..removeAt(index);
    }
  }

  // Update a specific field in an entry
  void updateExpenseField(int index, String fieldName, dynamic value) {
    if (index >= 0 && index < state.length) {
      final entry = state[index];
      final updatedEntry = entry.copyWith(
        branchController:
        fieldName == 'branch' ? TextEditingController(text: value) : entry.branchController,
        amountController:
        fieldName == 'amount' ? TextEditingController(text: value) : entry.amountController,
        selectedBranchType: fieldName == 'branchType' ? value : entry.selectedBranchType,
        claimType: fieldName == 'claimType' ? value : entry.claimType,
      );
      state = [...state]..[index] = updatedEntry;
    }
  }

  // Update the claim type
  void updateClaimType(int index, String selectedOption) {
    if (index >= 0 && index < state.length) {
      final entry = state[index];
      final updatedEntry = entry.copyWith(claimType: selectedOption);
      state = [...state]..[index] = updatedEntry;
    }
  }

  // Submit the branch expenses data (for demonstration purposes)
  void submitBranchExpensesData() {
    for (var entry in state) {
      final branch = entry.branchController.text;
      final amount = entry.amountController.text;
      final branchType = entry.selectedBranchType;
      final claimType = entry.claimType;

      print('Submitting Data: $branch, $amount, $branchType, $claimType');
    }
  }

  // Dispose of controllers
  void _disposeControllers(BranchExpenseEntry entry) {
    entry.branchController.dispose();
    entry.amountController.dispose();
  }

  @override
  void dispose() {
    for (final entry in state) {
      _disposeControllers(entry);
    }
    super.dispose();
  }
}

// Riverpod provider
final branchExpensesProvider = StateNotifierProvider<BranchExpensesProvider, List<BranchExpenseEntry>>(
      (ref) => BranchExpensesProvider(),
);
