


import 'package:dio/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/HRMS/LeaveManagement/model/get_all_reporting_manager.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../model/all_employee_list_model.dart';
import '../model/expense_image_upload_model.dart';


final expenseSubmitViewModelProvider = StateNotifierProvider<ExpenseSubmitViewModel, ExpenseSubmitState>((ref) {
  return ExpenseSubmitViewModel();
});

class ExpenseSubmitState {
  final bool isLoading;
  final String? uploadedSelfieUrl;

  ExpenseSubmitState({this.isLoading = false, this.uploadedSelfieUrl});

  ExpenseSubmitState copyWith({bool? isLoading, String? uploadedSelfieUrl}) {
    return ExpenseSubmitState(
      isLoading: isLoading ?? this.isLoading,
      uploadedSelfieUrl: uploadedSelfieUrl ?? this.uploadedSelfieUrl,
    );
  }
}

class ExpenseSubmitViewModel extends StateNotifier<ExpenseSubmitState> {
  ExpenseSubmitViewModel() : super(ExpenseSubmitState());

  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  // Method to pick image from gallery
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await uploadImage(pickedFile.path);
    }
  }

  // Method to upload image
  Future<void> uploadImage(String imagePath) async {
    state = state.copyWith(isLoading: true);

    try {
      String? token = speciality.getToken();
      // Prepare form data for upload
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath),
      });

      // API call to upload image
      final response = await _dio.post(
        Api.uploadImageCollection,
        data: formData,
        options: Options(headers: {"token": token}), // Replace with your token logic
      );

      if (response.statusCode == 200) {
        final imageResponse = ExpenseImageUploadResponseModel.fromJson(response.data);
        state = state.copyWith(
          isLoading: false,
          uploadedSelfieUrl: imageResponse.items.image, // Update state with image URL

        );
        print('Attached Expense image url ${imageResponse.items.image}');

      } else {
        state = state.copyWith(isLoading: false);
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }


  Future<void> submitForm(String imageUrl) async {
    // Your form data logic here
    final formData = {
      'merchantName':'' ,
      'category':'' ,
      'attendees':'' ,
      'reportingManager':'' ,
      'description':'' ,
      'amount':'' ,
      'imageUrl': imageUrl,
      // Add other fields as needed
    };

    try {
      String? token = speciality.getToken();
      final response = await _dio.post(
        Api.expenseSubmitForm,
        data: formData,
        options: Options(headers: {"token": token}),
      );

      print('Expense Form Submitted ${response.data}');

      if (response.statusCode == 200) {

        print('Expense Form Submitted Successfully');
        // Handle successful submission
      } else {
        throw Exception('Failed to submit expense form');
      }
    } catch (e) {
      // Handle errors
    }
  }


}

/*final expenseSubmitViewModelProvider = Provider((ref) => ExpenseSubmitViewModel());

class ExpenseSubmitViewModel {
  final Dio _dio = Dio();
  String? uploadedSelfieUrl;

}*/

class ExpenseFormControllerNotifier extends StateNotifier<void> {
  final TextEditingController merchantNameController = TextEditingController();
  final TextEditingController expenseCategoryController = TextEditingController();
  final TextEditingController employeeListController = TextEditingController();
  final TextEditingController repManagerController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();

  ExpenseFormControllerNotifier() : super(null);

  // Static dropdown data for loan amount and monthly income
  final List<String> expenseCategoryOptions = [
    'Travel',
    'Food',
    'Accommodation',
    'Miscellaneous'
  ];

  // Method to pick a date
  Future<void> pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      startDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }


  @override
  void dispose() {
    merchantNameController.dispose();
    expenseCategoryController.dispose();
    employeeListController.dispose();
    repManagerController.dispose();
    startDateController.dispose();
    descriptionController.dispose();
    totalAmountController.dispose();
    super.dispose();
  }
}


final expenseFormControllerProvider = Provider.autoDispose<ExpenseFormControllerNotifier>((ref) {
  final controllerNotifier = ExpenseFormControllerNotifier();
  ref.onDispose(() => controllerNotifier.dispose()); // Dispose the controller when the provider is no longer used
  return controllerNotifier;
});

final fetchAllManagerProvider = FutureProvider.family.autoDispose<List<ReportingManager>,BuildContext>((ref,context) async {
  String? token = speciality.getToken();
  final dio = ref.read(dioProvider);
  final response = await dio.get(Api.getReportingManager,
    options: Options(headers: {"token": token}
      , validateStatus: (status) => true,),);

  var responseData = response.data;
  print('fetch Reporting Manager response: $responseData');
  var message = responseData['message'];
   print('message: $message');

  try {
    if (response.statusCode == 200 && responseData['status'] == true) {
     // CustomSnackBar(message: message, snackColor: Colors.green);

      GetAllReportingManagerModel apiResponseList =
      GetAllReportingManagerModel.fromJson(response.data);
      return apiResponseList.items.managersData;

    } else {
      CustomSnackBar(message: message, snackColor: Colors.red);
      print('Error message: $message');
      throw Exception('Failed to load manager data');
    }
  }on DioException catch (error) {
    throw Exception(error);
    // throw Exception(error);
  }catch (e) {
    // Handle unexpected errors
    CustomSnackBar(message: message, snackColor: Colors.red);
    print('Unexpected error: $e');
    throw Exception(e);
  }

});

final fetchAllEmployeeProvider = FutureProvider.family.autoDispose<List<Employee>,BuildContext>((ref,context) async {
  String? token = speciality.getToken();
  final dio = ref.read(dioProvider);
  final response = await dio.get(Api.getEmployeeList,
    options: Options(headers: {"token": token}
      , validateStatus: (status) => true,),);

  var responseData = response.data;
  print('fetch Employee list response: $responseData');
  var message = responseData['message'];
  print('message: $message');

  try {
    if (response.statusCode == 200 && responseData['status'] == true) {
      // CustomSnackBar(message: message, snackColor: Colors.green);

      AllEmployeeResponseModel apiResponseList =
      AllEmployeeResponseModel.fromJson(response.data);
     // return apiResponseList.items;

      // Filter non-empty employeName and null-safe check
      final validEmployees = (apiResponseList.items ?? [])
          .where((employee) => employee.employeName != null && employee.employeName!.trim().isNotEmpty)
          .toList();

      return validEmployees;

    } else {
      CustomSnackBar(message: message, snackColor: Colors.red);
      print('Error message: $message');
      throw Exception('Failed to load Employee data');
    }
  }on DioException catch (error) {
    throw Exception(error);
    // throw Exception(error);
  }catch (e) {
    // Handle unexpected errors
    CustomSnackBar(message: message, snackColor: Colors.red);
    print('Unexpected error: $e');
    throw Exception(e);
  }

});




