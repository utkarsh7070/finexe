import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerDetailProvider extends ChangeNotifier {
  final List<String> sections = [
    "Loan Detail's",
    "Application Detail's",
    "Co - Application Detail's 01",
    "Co - Application Detail's 02",
    "Guarantor Detail's",
    "Cibil Detail's",
  ];

  String _searchText = "";
  int _selectedSegment = 2;

  String get searchText => _searchText;

  int get selectedSegment => _selectedSegment;

  List<String> get filteredSections => sections
      .where((section) =>
          section.toLowerCase().contains(_searchText.toLowerCase()))
      .toList();

  void updateSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  void updateSegment(int value) {
    _selectedSegment = value;
    notifyListeners();
  }
}

// StateNotifierProvider for the CustomerDetailProvider
final customerDetailProvider = ChangeNotifierProvider<CustomerDetailProvider>(
  (ref) => CustomerDetailProvider(),
);
