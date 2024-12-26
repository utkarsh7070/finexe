import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/travel_expense_model.dart';

final fetchexpensetypeProvider =
FutureProvider<List<DropDownValueModel>>((ref) async {
  final dio = ref.read(dioProvider);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  return [
    const DropDownValueModel(name: 'Food', value: 'a'),
    const DropDownValueModel(name: 'Lodging', value: 'b'),
    const DropDownValueModel(name: 'Toll', value: 'c'),
    const DropDownValueModel(name: 'Others', value: 'd')
  ];
  // final response = await dio.get(Api.getAllModeOfCollection,
  //     options: Options(headers: {"token": token}));
  // print(response.statusMessage);
  // print(response.statusCode);
  // if (response.statusCode == 200) {
  //   print(response.data);
  //   CollectionModeResponseModel apiResponseList =
  //       CollectionModeResponseModel.fromJson(response.data);
  //   return apiResponseList.items;
  // } else {
  //   throw Exception('Failed to load data');
  // }
});

final expensedata =
StateNotifierProvider<TravelFormViewModel, TravelExpenseModel>((ref) {
  return TravelFormViewModel();
});

class TravelFormViewModel extends StateNotifier<TravelExpenseModel> {
  TravelFormViewModel()
      : super(TravelExpenseModel(expenses: [
    Expense(expenseAmount: 0, expenseType: '', receiptUrl: '')
  ]));

  final TextEditingController startTravelController = TextEditingController();
  final TextEditingController endTravelController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  // final TextEditingController expenseAmountController = TextEditingController();


  // update expense type and amount and url dynamically
  void updateExpenseController(int index,Map< String,dynamic> value) {

    final updatedExpenses = List<Expense>.from(state.expenses);
    final currentExpense = updatedExpenses[index];
    updatedExpenses[index] = Expense(
      expenseType:value['expensetype']?? currentExpense.expenseType,
      expenseAmount:value['amount']!=null? double.tryParse(value['amount'])?? currentExpense.expenseAmount:currentExpense.expenseAmount,
      receiptUrl:value['expenseurl']?? currentExpense.receiptUrl,
      dropDownController:  currentExpense.dropDownController,

      expensecontroller: currentExpense.expensecontroller, // Preserve controller
    );

    // Update the state
    state = TravelExpenseModel(

      startTravelDate: state.startTravelDate,
      endTravelDate: state.endTravelDate,
      purposeOfTravel: state.purposeOfTravel,
      travelAlongWith: state.travelAlongWith,
      travelMode: state.travelMode,
      expenses: updatedExpenses,
    );
  }


  void updateTravelData(Map<String, dynamic> updates) {
    state = TravelExpenseModel(
      startTravelDate: updates['startTravelDate'] ?? state.startTravelDate,
      endTravelDate: updates['endTravelDate'] ?? state.endTravelDate,
      purposeOfTravel: updates['purposeOfTravel'] ?? state.purposeOfTravel,
      travelAlongWith:updates['travelAlong'] ??state.travelAlongWith,
      travelMode:updates['travelMode']?? state.travelMode,
      expenses: updates['expenses'] ?? state.expenses,
    );
  }


  void addEmptyExpense(Expense expense) {
    // Instead of modifying the state directly, we create a new TravelExpenseModel
    state = TravelExpenseModel(
      startTravelDate: state.startTravelDate,
      endTravelDate: state.endTravelDate,
      purposeOfTravel: state.purposeOfTravel,
      travelAlongWith: state.travelAlongWith,
      travelMode: state.travelMode,
      expenses: [...state.expenses, expense], // Adding the new expense
    );
  }

// pick reciept in image for expense

  Future<XFile?> pickImage(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      updateExpenseController(index,{'expenseurl':image.path});
    }
    return null;
  }
  // Method to remove an expense by its type (for example)
  void removeExpense(int index) {
    state = TravelExpenseModel(
        startTravelDate: state.startTravelDate,
        endTravelDate: state.endTravelDate,
        purposeOfTravel: state.purposeOfTravel,
        travelAlongWith: state.travelAlongWith,
        travelMode: state.travelMode,
        expenses: List.of(state.expenses)
          ..removeAt(index) // Exclude the expense at the given index

    );
  }

  // show date picker
  void showdatepicker(BuildContext context, String field) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      cancelText: 'reset',
      context: context,
      initialDate: selectedDate.add(const Duration(days: 1)),
      // Start from tomorrow
      firstDate: selectedDate.add(const Duration(days: 1)),
      // First selectable date is tomorrow
      lastDate: selectedDate.add(const Duration(days: 3)),
    );

    if (picked != null) {
      field == 'start'
          ? startTravelController.text = picked.toString()
          : endTravelController.text = picked.toString();
    }
  }
}