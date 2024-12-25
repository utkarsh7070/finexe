import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';


class TravelExpenseModel {
// Main fields
  final String startTravelDate;
  final String endTravelDate;
  final String purposeOfTravel;
  final String travelAlongWith;
  final String travelMode;


// List of expenses
  final List<Expense> expenses;


  TravelExpenseModel({
    this.startTravelDate = '',
    this.endTravelDate = '',
    this.purposeOfTravel = '',
    this.travelAlongWith = '',
    this.travelMode = '',
    required this.expenses, // Make expenses optional, not default empty list
  });


// fromJson method
  factory TravelExpenseModel.fromJson(Map<String, dynamic> json) {
    return TravelExpenseModel(
      startTravelDate: json['startTravelDate'] as String,
      endTravelDate: json['endTravelDate'] as String,
      purposeOfTravel: json['purposeOfTravel'] as String,
      travelAlongWith: json['travelAlongWith'] as String,
      travelMode: json['travelMode'] as String,
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }


// toJson method
  Map<String, dynamic> toJson() {
    return {
      'startTravelDate': startTravelDate,
      'endTravelDate': endTravelDate,
      'purposeOfTravel': purposeOfTravel,
      'travelAlongWith': travelAlongWith,
      'travelMode': travelMode,
      'expenses': expenses!.map((e) => e.toJson()).toList(),
    };
  }
}


class Expense {
  final String expenseType;
  final double expenseAmount;
  final String receiptUrl;
  final TextEditingController expensecontroller;
  final SingleValueDropDownController dropDownController;


  Expense({
    this.expenseType = '',
    this.expenseAmount = 0,
    this.receiptUrl = '',
    TextEditingController? expensecontroller,
    SingleValueDropDownController? dropDownController,
  }) : expensecontroller = expensecontroller ?? TextEditingController(),
        dropDownController = dropDownController ?? SingleValueDropDownController();


// fromJson method
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      expenseType: json['expenseType'] as String,
      expenseAmount: (json['expenseAmount'] as num).toDouble(),
      receiptUrl: json['receiptUrl'] as String,
    );
  }


// toJson method
  Map<String, dynamic> toJson() {
    return {
      'expenseType': expenseType,
      'expenseAmount': expenseAmount,
      'receiptUrl': receiptUrl,
    };
  }
}