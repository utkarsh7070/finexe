import 'dart:developer';
import 'dart:io';
import 'package:bson/bson.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/collection_mode_response_model.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/get_mode_by_id_response_model.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/update_emi_submit_request_model.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_submit_request_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../../../../base/api/dio_exception.dart';
import '../model/visit_closure_submit_request_model.dart';
import '../model/get_visit_pending_response_data.dart';
import '../model/visit_pending_items_model.dart';
import '../model/visit_update_upload_image_responce_model.dart';
import 'package:path/path.dart' as path;

final updateVisitDropDown = StateProvider<List<DropDownValueModel>>(
      (ref) {
    return [
      const DropDownValueModel(name: 'None', value: "none"),
      const DropDownValueModel(
          name: 'Customer Will Pay EMI', value: "CustomerWillPayEmi"),
      const DropDownValueModel(
          name: 'Customer Will Not Pay EMI', value: "CustomerWillNotPayEmi"),
      const DropDownValueModel(
          name: 'Customer Not Contactable', value: "CustomerNotContactable"),
    ];
  },
);

final modeOfCollectionDropDown = StateProvider<List<DropDownValueModel>>(
      (ref) {
    return [
      const DropDownValueModel(name: 'Partner', value: "partner"),
      const DropDownValueModel(name: 'Online', value: "online"),
      const DropDownValueModel(name: 'Ok Credit', value: "okCredit"),
    ];
  },
);

final bankDropDown = StateProvider<List<DropDownValueModel>>(
      (ref) {
    return [
      const DropDownValueModel(name: 'Hdfc', value: "hdfc"),
      const DropDownValueModel(name: 'New Bank', value: "newBank"),
      const DropDownValueModel(name: 'Bandhan Bank', value: "bandhanBank"),
    ];
  },
);

final creditDropDown = StateProvider<List<DropDownValueModel>>(
      (ref) {
    return [
      const DropDownValueModel(name: 'Roshan', value: "roshan"),
      const DropDownValueModel(name: 'Sagar', value: "sagar"),
      const DropDownValueModel(name: 'Purvi', value: "purvi"),
    ];
  },
);

//--------------------drop down----------------------------------

final paymentStatusFocusProviderFocusProvider =
StateNotifierProvider<PaymentStatusFocusProvider, Map<String, bool>>((ref) {
  return PaymentStatusFocusProvider();
});

final closuerFocusProvider =
StateNotifierProvider<ClosuerFocusProvider, Map<String, bool>>((ref) {
  return ClosuerFocusProvider();
});

final closuerViewModelProvider =
StateNotifierProvider<ClosuerViewModel, ClosuerModel>((ref) {
  final dio = ref.watch(dioProvider);
  return ClosuerViewModel(dio);
});

final updateEmiFocusProvider =
StateNotifierProvider<UpdateEmiFocusProvider, Map<String, bool>>((ref) {
  return UpdateEmiFocusProvider();
});

final updateEmiViewModelProvider =
StateNotifierProvider.autoDispose<UpdateEmiViewModel, UpdateEmiModel>(
        (ref) {
      final dio = ref.read(dioProvider);
      return UpdateEmiViewModel(dio);
    });

final updateVisitViewModelProvider =
StateNotifierProvider.autoDispose<UpdateVisitViewModel, UpdateVisitModel>(
        (ref) {
      final dio = ref.read(dioProvider);

      final position = ref.watch(currentLocationProvider);
      return UpdateVisitViewModel(dio, position);
    });

class UpdateVisitViewModel extends StateNotifier<UpdateVisitModel> {
  final Dio dio;
  final AsyncValue<Position> position;
  String imageApi = '';

  TextEditingController dateController = TextEditingController();
  final SingleValueDropDownController dropDownControllerProvider =
  SingleValueDropDownController();
  final ImagePicker picker = ImagePicker();

  UpdateVisitViewModel(this.dio, this.position) : super(UpdateVisitModel());

  @override
  void dispose() {
    dropDownControllerProvider.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<XFile?> clickPhoto() async {
    state = state.copyWith(isLoading: true);
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final isValid = _validateTransactionImage(pickedFile.path);
      state = state.copyWith(photoFile: pickedFile.path, isPhotoFile: isValid);
      final imagePath = await compressImage(File(pickedFile.path));
      await uploadImage(imagePath!.path);
      return pickedFile;
    }
    return null;
  }

  Future<XFile?> compressImage(File file) async {
    String fileName = path.basename(file.path);
    final String targetPath = '${file.parent.path}/compressed_$fileName';
    final compressedBytes = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, // Source path
      targetPath, // Target path
      quality: 10, // Compression quality (0-100)
    );
    return compressedBytes;
  }

  Future<void> uploadImage(String image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image),
    });
    if (kDebugMode) {
      print(image);
    }
    // final String token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
    final response = await dio.post(Api.uploadImageCollection,
        data: formData, options: Options(headers: {"token": token}));
    if (response.statusCode == 200) {
      VisitUpdateUploadImageResponseModel imageResponseModel =
      VisitUpdateUploadImageResponseModel.fromJson(response.data);
      state = state.copyWith(isLoading: false);
      state = state.copyWith(transitionImage: imageResponseModel.items.image);
      if (kDebugMode) {
        print('image ${imageResponseModel.items.image}');
        imageApi = imageResponseModel.items.image;
        print(imageApi);
      }
    } else {
      state = state.copyWith(isLoading: false);
      throw Exception('Failed to load data');
    }
  }

  Future<void> dateFilter(BuildContext context) async {
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
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      if (kDebugMode) {
        print(picked);
      }
    }
    if (picked != null && picked != '') {
      String? formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      if (kDebugMode) {
        print(formattedDate);
      }
      dateController.text = formattedDate;
      state = state.copyWith(date: formattedDate);
    } else {}
  }

  bool validateForm(String? value, BuildContext context) {
    print(value);
    if (value != null) {
      switch (value) {
        case 'CustomerWillPayEmi':
          return validateCustomerPayForm(context);
        case 'CustomerWillNotPayEmi':
          return validateCustomerNotPay(context);
        case 'CustomerNotContactable':
          return validateCustomerNotContactable(context);
        case '':
          return false;
        default:
          return false;
      }
    } else {
      showCustomSnackBar(
          context, 'Please Select Payment Status', Colors.red.shade200);
      return false;
    }
  }

  Future<void> visitFormSubmit(
      {required ItemsDetails datas, required BuildContext context}) async {
    if (state.isLoading == true) {
      return;
    }
    state = state.copyWith(isButtonVissible: true);
    state = state.copyWith(isLoading: true);

    print('image of uploaded $imageApi');

    final strDate = DateFormat('dd/MM/yyyy').parse(state.date);
    final date = DateFormat('yyyy-MM-dd').format(strDate);
    final requestModel = VisitUpdateSubmitRequestModel(
      ld: datas.ld ?? '',
      customerName: datas.customerName ?? '',
      visitDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      revisitDate: date,
      newContactNumber: datas.mobile ?? '',
      customerResponse: dropDownControllerProvider.dropDownValue?.name ?? '',
      paymentAmount: state.paymentAmount,
      reasonForNotPay: state.reason,
      solution: state.solution,
      reasonForCustomerNotContactable: state.reason,
      visitSelfie: '${Api.imageBaseProUrl}${state.transitionImage}',
      address: datas.address ?? '',
      // latitude: data.latitude,
      // longitude: data.longitude
    );

    print(requestModel);
    String? token = speciality.getToken();

    try {
      final response = await dio.post(Api.visitFormSubmit,
          data: requestModel.toJson(),
          options: Options(headers: {"token": token}));
      if (kDebugMode) {
        print(response.statusMessage);
        print(response.statusCode);
        print(response.data);
      }
      if (response.statusCode == 200) {
        log('updated vist test');
        showCustomSnackBar(context, response.data['message'], Colors.green);
      } else {
        showCustomSnackBar(context, response.data['message'], Colors.green);
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ExceptionHandler().handleError(e);
    } finally {
      state = state.copyWith(isButtonVissible: false);
      state = state.copyWith(isLoading: false);
    }
  }

  void updatePhotoValue(context) {
    // state = state.copyWith(photoFile: value);
    // dateController.text = '';
    Navigator.pop(context);
  }

  void updatePaymentStatus(String value) {
    final isValid = _validatePaymentStatus(value);
    state = state.copyWith(paymentStatus: value, isPaymentStatusValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updatePaymentAmount(String value) {
    final isValid = _validatePaymentAmount(value);
    state = state.copyWith(paymentAmount: value, isPaymentAmountValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateDate(String value) {
    final isValid = _validateDate(value);
    state = state.copyWith(date: value, isDateValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateReason(String value) {
    final isValid = _validateReason(value);
    state = state.copyWith(reason: value, isReasonValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateSolution(String value) {
    final isValid = _validateSolution(value);
    state = state.copyWith(solution: value, isSolutionValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateTransactionImage(String value) {
    final isValid = _validateTransactionImage(value);
    state = state.copyWith(photoFile: value, isPhotoFile: isValid);
  }

  bool validateCustomerPayForm(BuildContext context) {
    final isPaymentAmountValid = _validatePaymentAmount(state.paymentAmount);
    final isDateValid = _validateDate(state.date);
    final isPhoto = _validateTransactionImage(state.photoFile);
    if (state.transitionImage.isEmpty) {
      showCustomSnackBar(
          context, 'Image is not uploaded in server', Colors.red.shade200);
    }
    state = state.copyWith(
        isPaymentAmountValid: isPaymentAmountValid,
        isDateValid: isDateValid,
        isPhotoFile: isPhoto);
    return isPaymentAmountValid &&
        isDateValid &&
        isPhoto &&
        state.transitionImage.isNotEmpty;
  }

  bool validateCustomerNotContactable(BuildContext context) {
    final isDate = _validateDate(state.date);
    final isReasonValid = _validateReason(state.reason);
    final isImage = _validateTransactionImage(state.photoFile);
    if (state.transitionImage.isEmpty) {
      showCustomSnackBar(
          context, 'Image is not uploaded in server', Colors.red.shade200);
    }
    state = state.copyWith(
        isDateValid: isDate,
        isPhotoFile: isImage,
        isReasonValid: isReasonValid);
    return isDate &&
        isReasonValid &&
        isImage &&
        state.transitionImage.isNotEmpty;
  }

  bool validateCustomerNotPay(BuildContext context) {
    // final isPaymentStatusValid = _validatePaymentStatus(dropDownControllerProvider.dropDownValue!.name);
    final isReasonValid = _validateReason(state.reason);
    final isSolutionValid = _validateSolution(state.solution);
    final isDateValid = _validateDate(state.date);
    final isPhoto = _validateTransactionImage(state.photoFile);
    if (state.transitionImage.isEmpty) {
      showCustomSnackBar(
          context, 'Image is not uploaded in server', Colors.red.shade200);
    }
    state = state.copyWith(
      // isPaymentStatusValid: isPaymentStatusValid,
        isReasonValid: isReasonValid,
        isSolutionValid: isSolutionValid,
        isDateValid: isDateValid,
        isPhotoFile: isPhoto);
    return isDateValid &&
        isSolutionValid &&
        isReasonValid &&
        state.transitionImage.isNotEmpty &&
        isPhoto;
  }

// bool validateSelectedValue() {
//   final selected = state.paymentStatus;
//   return selected =='CustomerWillPayEmi';
//
// }
}

bool _validatePaymentStatus(String paymentStatus) {
  return paymentStatus.isNotEmpty;
}

bool _validatePaymentAmount(String paymentAmount) {
  return paymentAmount.isNotEmpty;
}

bool _validateDate(String date) {
  return date.isNotEmpty;
}

bool _validateEmiAmount(String date) {
  return date.isNotEmpty;
}

bool _validateTransactionId(String date) {
  return date.isNotEmpty;
}

bool _validateTransactionImage(String date) {
  return date.isNotEmpty;
}

bool _validateRemark(String date) {
  return date.isNotEmpty;
}

bool _validateBankName(String date) {
  return date.isNotEmpty;
}

bool _validateReceipt(String date) {
  return date.isNotEmpty;
}

bool _validateReason(String reason) {
  return reason.isNotEmpty;
}

bool _validateSolution(String solution) {
  return solution.isNotEmpty;
}

class UpdateEmiViewModel extends StateNotifier<UpdateEmiModel> {
  final Dio dio;

  UpdateEmiViewModel(this.dio) : super(UpdateEmiModel());

  final SingleValueDropDownController modeOfCollectionController =
  SingleValueDropDownController();
  final SingleValueDropDownController bankNameController =
  SingleValueDropDownController();
  final SingleValueDropDownController creditPersonController =
  SingleValueDropDownController();
  final ImagePicker picker = ImagePicker();
  String? imageApi = '';

  @override
  void dispose() {
    modeOfCollectionController.dispose();
    bankNameController.dispose();
    creditPersonController.dispose();
    super.dispose();
  }

  void updatePhotoValue(context) {
    // state = state.copyWith(photoFile: value);
    Navigator.pop(context);
  }

  void updateCreditPerson(String id) {
    state = state.copyWith(commonId: id);
  }

  bool validPartner(context) {
    final isPhoto = _validateTransactionImage(state.photoFile);
    final isAmount = _validateEmiAmount(state.emiAmount);
    final isTransactionId = _validateTransactionId(state.transactionId);
    final isRemark = _validateRemark(state.remark);
    if (state.transactionImage.isEmpty) {
      showCustomSnackBar(
          context, 'Image is not upload in server', Colors.red.shade200);
    }
    state = state.copyWith(
        isTransactionImage: isPhoto,
        isTransactionId: isTransactionId,
        isEmiAmount: isAmount,
        isRemark: isRemark);
    return isPhoto &&
        isAmount &&
        isTransactionId &&
        isRemark &&
        state.transactionImage.isNotEmpty;
  }

  bool validAccountDeposit(context) {
    final isBank = bankNameController.dropDownValue?.value != null;
    final isPhoto = _validateTransactionImage(state.photoFile);
    final isAmount = _validateEmiAmount(state.emiAmount);
    final isTransactionId = _validateTransactionId(state.transactionId);
    final isMentionMail = _validateReceipt(state.receipt ?? '');
    final isRemark = _validateRemark(state.remark);
    if (!isBank) {
      showCustomSnackBar(
          context, 'Please select bank name', Colors.red.shade200);
    } else if (state.transactionImage.isEmpty) {
      showCustomSnackBar(
          context, 'Image is not upload in server', Colors.red.shade200);
    }
    state = state.copyWith(
        isReceipt: isMentionMail,
        isTransactionImage: isPhoto,
        isTransactionId: isTransactionId,
        isEmiAmount: isAmount,
        isRemark: isRemark);
    return isPhoto &&
        isAmount &&
        isTransactionId &&
        isRemark &&
        isMentionMail &&
        isBank &&
        state.transactionImage.isNotEmpty;
  }

  bool validCashCollection(context) {
    final isCreditPerson = creditPersonController.dropDownValue?.value != null;
    final isAmount = _validateEmiAmount(state.emiAmount);
    final isMentionMail = _validateReceipt(state.receipt ?? '');
    final isRemark = _validateRemark(state.remark);
    if (!isCreditPerson) {
      showCustomSnackBar(
          context, 'Please select credit person', Colors.red.shade200);
    }
    state = state.copyWith(
        isReceipt: isMentionMail, isEmiAmount: isAmount, isRemark: isRemark);
    return isAmount && isRemark && isMentionMail && isCreditPerson;
  }

  bool validation(String value, context) {
    print(value);
    switch (value) {
      case 'direct partner deposit':
        return validPartner(context);
      case 'fincooper account deposit':
        return validAccountDeposit(context);
      case 'cashCollection':
        return validCashCollection(context);
      case '':
        return false;
      default:
        return false;
    }
  }

  //   print('Update EMI Input -${requestModel.toJson()}');
  //   String? token = speciality.getToken();
  //   final response = await dio.post(Api.updateEmiSubmit,
  //       data: requestModel.toJson(),
  //       options: Options(
  //         headers: {"token": token},
  //         validateStatus: (status) => true,
  //       ));
  //   if (kDebugMode) {
  //     print(response.statusMessage);
  //     print(response.statusCode);
  //   }

  //
  //   var responseData = response.data;
  //   print('Emi Paid response: $responseData');
  //   var message = responseData['message'];
  //

  //   if (response.statusCode == 200 || responseData['status'] == true) {
  //     showCustomSnackBar(context, 'Update EMI Submitted', Colors.green);
  //     state = state.copyWith(isButtonVissible: false);
  //     updatePhotoValue(context);
  //     ref.refresh(fetchVisitPendingDataProvider);
  //     ref.invalidate(updateEmiViewModelProvider);
  //     if (kDebugMode) {
  //       print('EmiUpdateResponse ${response.data}');
  //     }
  //   } else if (response.statusCode == 400 || responseData['status'] == false) {
  //     // isLoading = false;
  //     showCustomSnackBar(context, message, Colors.red);
  //     print('Emi paid message ${response.statusMessage}');
  //   } else {
  //     throw Exception('Failed to load data');
  //     // return false;

  //   }
  // }*/

  Future<void> updateEmiSubmitButton({required ItemsDetails detail,
    required BuildContext context,
    required WidgetRef ref}) async {
    state = state.copyWith(isButtonVissible: true);
    if (state.isLoading == true) {
      print('Second time click ');
      return;
    }
    state = state.copyWith(isLoading: true);
    if (kDebugMode) {
      print(
          'Ld o:-${detail.ld}, customerName:- ${detail
              .customerName}, mobile:- ${detail.mobile}, commonId:- ${state
              .commonId}, image:- ${state.transactionImage}');
    }
    ObjectId? result1 = parseObjectId(state.commonId);
    UpdateEmiSubmitRequestModel requestModel = UpdateEmiSubmitRequestModel(
        fatherName: detail.fatherName ?? '',
        ld: detail.ld ?? '',
        collectedBy: '',
        customerName: detail.customerName ?? '',
        mobileNo: int.parse(detail.mobile ?? ''),
        receivedAmount: int.parse(state.emiAmount),
        transactionId: state.transactionId,
        transactionImage: state.transactionImage,
        modeOfCollectionId: state.modeOfCollectionId,
        commonId: result1,
        bankName: state.bankName,
        customerEmail: state.receipt,
        emiReceivedDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        remarkByCollection: state.remark,
        partner: detail.partner!);

    print('Update EMI Input -${requestModel.toJson()}');

    String? token = speciality.getToken();
    try {
      final response = await dio.post(Api.updateEmiSubmit,
          data: requestModel.toJson(),
          options: Options(
            headers: {"token": token},
            validateStatus: (status) => true,
          ));
      if (kDebugMode) {
        print(response.statusMessage);
        print(response.statusCode);
      }

      var responseData = response.data;
      print('Emi Paid response: $responseData');

      if (response.statusCode == 200) {
        showCustomSnackBar(context, 'Update EMI Submitted', Colors.green);
        updatePhotoValue(context);
        if (kDebugMode) {
          print('EmiUpdateResponse ${response.data}');
        }
      }
    } catch (e) {
      ExceptionHandler().handleError(e);
    } finally {
      state = state.copyWith(isButtonVissible: false);
      state = state.copyWith(isLoading: false);
    }
  }

  Future<XFile?> clickPhoto() async {
    state = state.copyWith(isLoading: true);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = state.copyWith(photoFile: pickedFile.path);
      final imagePath = await compressImage(File(pickedFile.path));
      await uploadImage(imagePath!.path);
      return pickedFile;
    }
    state = state.copyWith(isLoading: false);
    return null;
  }

  Future<XFile?> compressImage(File file) async {
    String fileName = path.basename(file.path);
    final String targetPath = '${file.parent.path}/compressed_$fileName';
    final compressedBytes = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, // Source path
      targetPath, // Target path
      quality: 10, // Compression quality (0-100)
    );
    return compressedBytes;
  }

  ObjectId? parseObjectId(String? id) {
    if (id == null || id.isEmpty) {
      return null; // Return null if the input is empty or null
    }

    try {
      return ObjectId.parse(id); // Parse the ObjectId if valid
    } catch (e) {
      print("Invalid ObjectId: $e"); // Log the error if parsing fails
      return null;
    }
  }

  Future<void> uploadImage(String image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image),
    });
    if (kDebugMode) {
      print(image);
    }
    try {
      final response = await dio.post(Api.uploadImageCollection,
          data: formData, options: Options(headers: {"token": token}));
      if (response.statusCode == 200) {
        print('image url response $response');
        VisitUpdateUploadImageResponseModel imageResponseModel =
        VisitUpdateUploadImageResponseModel.fromJson(response.data);
        state = state.copyWith(isLoading: false);
        state =
            state.copyWith(transactionImage: imageResponseModel.items.image);
        if (kDebugMode) {
          print('image url ${imageResponseModel.items.image}');
          print('image url1 ${response.data}');
        }
        imageApi = imageResponseModel.items.image;
        print(imageApi);
      }
    } catch (e) {
      ExceptionHandler().handleError(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }


Future<void> openFeilds(String id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  state = state.copyWith(modeOfCollectionId: id);
  if (kDebugMode) {
    print('modeOfCollectionId id $id');
  }
  try{
    Response response = await dio.get(Api.getModeById,
        queryParameters: {"modeOfCollectionId": id},
        options: Options(headers: {"token": token}));
    print(response.statusMessage);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      GetModeByIdResponseModel apiResponseList =
      GetModeByIdResponseModel.fromJson(response.data);
      print("select ${apiResponseList.message}");
      List<DropDownValueModel> list = [];
      print(apiResponseList);
      state = state.copyWith(
          modeTitle: apiResponseList.items.dropdownDetail?.modelName,
          isExtraFormOpen: apiResponseList.items.modeDetail.extraForm,
          isEmailVisible: apiResponseList.items.modeDetail.email,
          isTransactionImageVisible:
          apiResponseList.items.modeDetail.transactionImage,
          isTransactionIdVisible:
          apiResponseList.items.modeDetail.transactionId);
      if (apiResponseList.items.detail != null) {
        for (final drop in apiResponseList.items.detail ?? []) {
          list.add(DropDownValueModel(name: '${drop.title}', value: drop.id));
        }
        state = state.copyWith(subDropdown: list);
      }
    }
  }catch(e){
    ExceptionHandler().handleError(e);
  }
}

void updateTransactionId(String value) {
  final isValid = _validateTransactionId(value);
  state = state.copyWith(transactionId: value, isTransactionId: isValid);
}

void updateEmiAmount(String value) {
  final isValid = _validateEmiAmount(value);
  state = state.copyWith(emiAmount: value, isEmiAmount: isValid);
}

void updateTransactionImage(String value) {
  final isValid = _validateTransactionImage(value);
  state =
      state.copyWith(transactionImage: value, isTransactionImage: isValid);
}

void updateRemark(String value) {
  final isValid = _validateRemark(value);
  state = state.copyWith(remark: value, isRemark: isValid);
}

void updateBankName(String value) {
  final isValid = _validateBankName(value);
  state = state.copyWith(bankName: value, isBankName: isValid);
}

void updateReceipt(String value) {
  final isValid = _validateReceipt(value);
  state = state.copyWith(receipt: value, isReceipt: isValid);
}}

class ClosuerViewModel extends StateNotifier<ClosuerModel> {
  final Dio dio;

  ClosuerViewModel(this.dio) : super(ClosuerModel());

  void updateDate(DateTime value) {
    // Format the date as yyyy-MM-dd
    final formattedDate = DateFormat('yyyy-MM-dd').format(value).toString();
    // Validate and store the formatted date
    final isValid = _validateDate(formattedDate);
    state = state.copyWith(date: formattedDate, isDate: isValid);
  }

  void updateAmount(String value) {
    final isValid = _validateDate(value);
    state = state.copyWith(amount: value, isAmount: isValid);
  }

  void updateReason(String value) {
    final isValid = _validateReason(value);
    state = state.copyWith(reason: value, isReason: isValid);
  }

  bool validateClosuerForm() {
    final isDate = _validateDate(state.date);
    final isReason = _validateReason(state.reason);
    final isAmount = _validatePaymentAmount(state.amount);
    state =
        state.copyWith(isDate: isDate, isReason: isReason, isAmount: isAmount);
    return isDate && isReason && isAmount;
  }

  void closeClosureDialog(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> openDatePicker(WidgetRef ref, DateTime? initialDate) async {
    final pickedDate = await showDatePicker(
      context: ref.context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      print(pickedDate);
      updateDate(pickedDate); // Update the date in the state
      ref
          .read(dateProvider.notifier)
          .updateDate(pickedDate); // Use ref to read the provider
    }
  }

  Future<void> visitClosureFormSubmit(BuildContext context,
      {required ItemsDetails data}) async {
    if (state.isLoading == true) {
      return;
    }
    state = state.copyWith(isLoading: true);
    VisitClosureSubmitRequestModel requestModel =
    VisitClosureSubmitRequestModel(
      ld: data.ld!,
      customerName: data.customerName!,
      mobileNo: int.parse(data.mobile!),
      amountToBeReceivedFromCustomer: int.parse(state.amount),
      dateOfDeposit: state.date,
      settlementForReason: state.reason,
    );

    String? toke = speciality.getToken();
    try {
      final response = await dio.post(Api.visitCloseFormSubmit,
          data: requestModel.toJson(),
          options: Options(headers: {"token": toke}));
      if (kDebugMode) {
        print(response.statusMessage);
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        showCustomSnackBar(context, 'Closure submitted', Colors.green);
        if (kDebugMode) {
          print('VisitClosureResponse ${response.data}');
        }
      }
    } catch (e) {
      ExceptionHandler().handleError(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

// Provider to manage the selected date
final dateProvider = StateNotifierProvider<DateNotifier, DateTime?>((ref) {
  return DateNotifier();
});

class DateNotifier extends StateNotifier<DateTime?> {
  DateNotifier() : super(null);

  void updateDate(DateTime newDate) {
    state = newDate;
  }
}

class PaymentStatusFocusProvider extends StateNotifier<Map<String, bool>> {
  final FocusNode paymentStatusFocusNode;
  final FocusNode paymentAmountFocusNode;
  final FocusNode dateFocusNode;
  final FocusNode reasonFocusNode;
  final FocusNode solutionFocusNode;

  PaymentStatusFocusProvider()
      : paymentStatusFocusNode = FocusNode(),
        paymentAmountFocusNode = FocusNode(),
        dateFocusNode = FocusNode(),
        reasonFocusNode = FocusNode(),
        solutionFocusNode = FocusNode(),
        super({
        'paymentStatusFocusNode': false,
        'paymentAmountFocusNode': false,
        'dateFocusNode': false,
        'reasonFocusNode': false,
        'solutionFocusNode': false,
      }) {
    paymentStatusFocusNode.addListener(
          () =>
          _focusListener('paymentStatusFocusNode', paymentStatusFocusNode),
    );
    paymentAmountFocusNode.addListener(
          () =>
          _focusListener('paymentAmountFocusNode', paymentAmountFocusNode),
    );
    dateFocusNode.addListener(
          () => _focusListener('dateFocusNode', dateFocusNode),
    );
    reasonFocusNode.addListener(
          () => _focusListener('reasonFocusNode', reasonFocusNode),
    );
    solutionFocusNode.addListener(
          () => _focusListener('solutionFocusNode', solutionFocusNode),
    );
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    paymentStatusFocusNode.removeListener(
          () =>
          _focusListener('paymentStatusFocusNode', paymentStatusFocusNode),
    );
    paymentAmountFocusNode.removeListener(
          () =>
          _focusListener('paymentAmountFocusNode', paymentAmountFocusNode),
    );
    dateFocusNode.removeListener(
          () => _focusListener('dateFocusNode', dateFocusNode),
    );
    reasonFocusNode.removeListener(
          () => _focusListener('reasonFocusNode', reasonFocusNode),
    );
    solutionFocusNode.removeListener(
          () => _focusListener('solutionFocusNode', solutionFocusNode),
    );
    paymentStatusFocusNode.dispose();
    paymentAmountFocusNode.dispose();
    dateFocusNode.dispose();
    reasonFocusNode.dispose();
    solutionFocusNode.dispose();

    super.dispose();
  }
}

class ClosuerFocusProvider extends StateNotifier<Map<String, bool>> {
  final FocusNode amountClosuerFocusNode;
  final FocusNode dateClosuerFocusNode;
  final FocusNode reasonClosuerFocusNode;

  ClosuerFocusProvider()
      : amountClosuerFocusNode = FocusNode(),
        dateClosuerFocusNode = FocusNode(),
        reasonClosuerFocusNode = FocusNode(),
        super({
        'amountClosuerFocusNode': false,
        'dateClosuerFocusNode': false,
        'reasonClosuerFocusNode': false,
      }) {
    amountClosuerFocusNode.addListener(
          () =>
          _focusListener('amountClosuerFocusNode', amountClosuerFocusNode),
    );
    dateClosuerFocusNode.addListener(
          () => _focusListener('dateClosuerFocusNode', dateClosuerFocusNode),
    );
    reasonClosuerFocusNode.addListener(
          () =>
          _focusListener('reasonClosuerFocusNode', reasonClosuerFocusNode),
    );
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    amountClosuerFocusNode.removeListener(
          () =>
          _focusListener('amountClosuerFocusNode', amountClosuerFocusNode),
    );
    dateClosuerFocusNode.removeListener(
          () => _focusListener('dateClosuerFocusNode', dateClosuerFocusNode),
    );
    reasonClosuerFocusNode.removeListener(
          () =>
          _focusListener('reasonClosuerFocusNode', reasonClosuerFocusNode),
    );
    amountClosuerFocusNode.dispose();
    dateClosuerFocusNode.dispose();
    reasonClosuerFocusNode.dispose();
    super.dispose();
  }
}

class UpdateVisitModel {
  final bool isLoading;
  final bool isButtonVissible;
  final int selectedValue;
  final String photoFile;
  final String transitionImage;
  final bool isPhotoFile;
  final String paymentStatus;
  final bool isPaymentStatusValid;
  final String paymentAmount;
  final bool isPaymentAmountValid;
  final String date;
  final bool isDateValid;
  final String reason;
  final bool isReasonValid;
  final String solution;
  final bool isSolutionValid;

  UpdateVisitModel({
    this.isButtonVissible = false,
    this.transitionImage = '',
    this.isPhotoFile = true,
    this.isLoading = false,
    this.photoFile = '',
    this.selectedValue = 0,
    this.paymentStatus = '',
    this.isPaymentStatusValid = true,
    this.paymentAmount = '',
    this.isPaymentAmountValid = true,
    this.date = '',
    this.isDateValid = true,
    this.reason = '',
    this.isReasonValid = true,
    this.solution = '',
    this.isSolutionValid = true,
  });

  UpdateVisitModel copyWith({
    bool? isButtonVissible,
    String? transitionImage,
    bool? isPhotoFile,
    String? photoFile,
    bool? isLoading,
    int? selectedValue,
    String? paymentStatus,
    bool? isPaymentStatusValid,
    String? paymentAmount,
    bool? isPaymentAmountValid,
    String? date,
    bool? isDateValid,
    String? reason,
    bool? isReasonValid,
    String? solution,
    bool? isSolutionValid,
  }) {
    return UpdateVisitModel(
      isButtonVissible: isButtonVissible ?? this.isButtonVissible,
      transitionImage: transitionImage ?? this.transitionImage,
      isPhotoFile: isPhotoFile ?? this.isPhotoFile,
      isLoading: isLoading ?? this.isLoading,
      photoFile: photoFile ?? this.photoFile,
      selectedValue: selectedValue ?? this.selectedValue,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      isPaymentStatusValid: isPaymentStatusValid ?? this.isPaymentStatusValid,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      isPaymentAmountValid: isPaymentAmountValid ?? this.isPaymentAmountValid,
      date: date ?? this.date,
      isDateValid: isDateValid ?? this.isDateValid,
      reason: reason ?? this.reason,
      isReasonValid: isReasonValid ?? this.isReasonValid,
      solution: solution ?? this.solution,
      isSolutionValid: isSolutionValid ?? this.isSolutionValid,
    );
  }
}

class ClosuerModel {
  final String amount;
  final String date;
  final String reason;
  final bool isAmount;
  final bool isDate;
  final bool isReason;
  final bool isLoading;

  ClosuerModel({this.isLoading = false,
    this.amount = '',
    this.date = '',
    this.reason = '',
    this.isAmount = true,
    this.isDate = true,
    this.isReason = true});

  ClosuerModel copyWith({
    bool? isLoading,
    String? amount,
    String? reason,
    String? date,
    bool? isAmount,
    bool? isDate,
    bool? isReason,
  }) {
    return ClosuerModel(
        isLoading: isLoading ?? this.isLoading,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        reason: reason ?? this.reason,
        isAmount: isAmount ?? this.isAmount,
        isDate: isDate ?? this.isDate,
        isReason: isReason ?? this.isAmount);
  }
}

class UpdateEmiModel {
  final String modeOfCollectionId;
  final String commonId;
  final String photoFile;
  final List<DropDownValueModel> subDropdown;
  final bool isLoading;
  final bool isButtonVissible;
  final bool isTransactionId;
  final bool isTransactionIdVisible;
  final bool isTransactionImage;
  final bool isTransactionImageVisible;
  final String dropdownDetail;
  final String emiAmount;
  final String transactionId;
  final String transactionImage;
  final String remark;
  final String bankName;
  final String? receipt;
  final bool isEmiAmount;
  final bool isRemark;
  final bool isBankName;
  final bool isReceipt;
  final bool isReceiptVisible;
  final bool isExtraFormOpen;
  final bool isEmail;
  final bool isEmailVisible;
  final String modeTitle;

  UpdateEmiModel({this.isButtonVissible = false,
    this.isTransactionImageVisible = false,
    this.isReceiptVisible = false,
    this.isEmailVisible = false,
    this.isTransactionIdVisible = false,
    this.modeOfCollectionId = '',
    this.commonId = '',
    this.photoFile = '',
    this.subDropdown = const [],
    this.dropdownDetail = '',
    this.modeTitle = '',
    this.isEmail = false,
    this.isExtraFormOpen = false,
    this.emiAmount = '',
    this.transactionId = '',
    this.transactionImage = '',
    this.remark = '',
    this.bankName = '',
    this.receipt,
    this.isEmiAmount = true,
    this.isTransactionId = true,
    this.isTransactionImage = false,
    this.isRemark = true,
    this.isBankName = true,
    this.isReceipt = true,
    this.isLoading = false});

  UpdateEmiModel copyWith({
    bool? isButtonVissible,
    bool? isTransactionImageVisible,
    bool? isReceiptVisible,
    bool? isEmailVisible,
    bool? isTransactionIdVisible,
    String? modeOfCollectionId,
    String? commonId,
    String? photoFile,
    List<DropDownValueModel>? subDropdown,
    bool? isLoading,
    String? dropdownDetail,
    String? modeTitle,
    bool? isExtraFormOpen,
    bool? isEmail,
    String? emiAmount,
    String? transactionId,
    String? transactionImage,
    String? remark,
    String? bankName,
    String? receipt,
    bool? isEmiAmount,
    bool? isTransactionId,
    bool? isTransactionImage,
    bool? isRemark,
    bool? isBankName,
    bool? isReceipt,
  }) {
    return UpdateEmiModel(
        isButtonVissible: isButtonVissible ?? this.isButtonVissible,
        isEmailVisible: isEmailVisible ?? this.isEmailVisible,
        isReceiptVisible: isReceiptVisible ?? this.isReceiptVisible,
        isTransactionIdVisible:
        isTransactionIdVisible ?? this.isTransactionIdVisible,
        isTransactionImageVisible:
        isTransactionImageVisible ?? this.isTransactionImageVisible,
        modeOfCollectionId: modeOfCollectionId ?? this.modeOfCollectionId,
        commonId: commonId ?? this.commonId,
        photoFile: photoFile ?? this.photoFile,
        subDropdown: subDropdown ?? this.subDropdown,
        isLoading: isLoading ?? this.isLoading,
        dropdownDetail: dropdownDetail ?? this.dropdownDetail,
        modeTitle: modeTitle ?? this.modeTitle,
        isEmail: isEmail ?? this.isEmail,
        isExtraFormOpen: isExtraFormOpen ?? this.isExtraFormOpen,
        emiAmount: emiAmount ?? this.emiAmount,
        transactionId: transactionId ?? this.transactionId,
        bankName: bankName ?? this.bankName,
        receipt: receipt ?? this.receipt,
        remark: remark ?? this.remark,
        transactionImage: transactionImage ?? this.transactionImage,
        isBankName: isBankName ?? this.isBankName,
        isEmiAmount: isEmiAmount ?? this.isEmiAmount,
        isReceipt: isReceipt ?? this.isReceipt,
        isRemark: isRemark ?? this.isRemark,
        isTransactionId: isTransactionId ?? this.isTransactionId,
        isTransactionImage: isTransactionImage ?? this.isTransactionImage);
  }
}

class UpdateEmiFocusProvider extends StateNotifier<Map<String, bool>> {
  final FocusNode emiAmountFocusNode;
  final FocusNode transactionIdFocusNode;
  final FocusNode bankNameFocusNode;
  final FocusNode receiptFocusNode;
  final FocusNode remarkFocusNode;
  final FocusNode transactionImageFocusNode;
  final FocusNode modeOfCollection;
  final FocusNode creditPersonFocusNode;

  UpdateEmiFocusProvider()
      : emiAmountFocusNode = FocusNode(),
        transactionIdFocusNode = FocusNode(),
        bankNameFocusNode = FocusNode(),
        receiptFocusNode = FocusNode(),
        remarkFocusNode = FocusNode(),
        transactionImageFocusNode = FocusNode(),
        modeOfCollection = FocusNode(),
        creditPersonFocusNode = FocusNode(),
        super({
        'emiAmountFocusNode': false,
        'transactionIdFocusNode': false,
        'bankNameFocusNode': false,
        'receiptFocusNode': false,
        'remarkFocusNode': false,
        'transactionImageFocusNode': false,
        'modeOfCollection': false,
        'creditPersonFocusNode': false,
      }) {
    emiAmountFocusNode.addListener(
          () => _focusListener('emiAmountFocusNode', emiAmountFocusNode),
    );
    transactionIdFocusNode.addListener(
          () =>
          _focusListener('transactionIdFocusNode', transactionIdFocusNode),
    );
    bankNameFocusNode.addListener(
          () => _focusListener('bankNameFocusNode', bankNameFocusNode),
    );
    receiptFocusNode.addListener(
          () => _focusListener('receiptFocusNode', receiptFocusNode),
    );
    remarkFocusNode.addListener(
          () => _focusListener('remarkFocusNode', remarkFocusNode),
    );
    transactionImageFocusNode.addListener(
          () =>
          _focusListener(
              'transactionImageFocusNode', transactionImageFocusNode),
    );
    modeOfCollection.addListener(
          () => _focusListener('modeOfCollection', modeOfCollection),
    );
    creditPersonFocusNode.addListener(
          () => _focusListener('creditPersonFocusNode', creditPersonFocusNode),
    );
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    emiAmountFocusNode.removeListener(
          () => _focusListener('emiAmountFocusNode', emiAmountFocusNode),
    );
    transactionIdFocusNode.removeListener(
          () =>
          _focusListener('transactionIdFocusNode', transactionIdFocusNode),
    );
    bankNameFocusNode.removeListener(
          () => _focusListener('bankNameFocusNode', bankNameFocusNode),
    );
    receiptFocusNode.removeListener(
          () => _focusListener('receiptFocusNode', receiptFocusNode),
    );
    remarkFocusNode.removeListener(
          () => _focusListener('remarkFocusNode', remarkFocusNode),
    );
    transactionImageFocusNode.removeListener(
          () =>
          _focusListener(
              'transactionImageFocusNode', transactionImageFocusNode),
    );
    modeOfCollection.removeListener(
          () => _focusListener('modeOfCollection', modeOfCollection),
    );
    creditPersonFocusNode.removeListener(
          () => _focusListener('creditPersonFocusNode', creditPersonFocusNode),
    );
    emiAmountFocusNode.dispose();
    transactionIdFocusNode.dispose();
    bankNameFocusNode.dispose();
    receiptFocusNode.dispose();
    remarkFocusNode.dispose();
    transactionImageFocusNode.dispose();
    modeOfCollection.dispose();
    creditPersonFocusNode.dispose();
    super.dispose();
  }
}
//-------------------------------end dropdown------------------------------

//----------------------------Google Map---------------------------------------

// Provider to get the current location
final currentLocationProvider = FutureProvider<Position>((ref) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  // Check for location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  // Return the current position
  Position position =
  await Geolocator.getCurrentPosition(locationSettings: locationSettings);

  return position;
});

// Provider to manage the Google Map controller
final mapControllerProvider =
StateProvider.autoDispose<GoogleMapController?>((ref) {
  return null;
});

// Provider to manage the polyline for directions
// final polylineProvider = StateProvider<List<Polyline>>((ref) => []);

// Provider to fetch directions between two points
// final directionsProvider =
//     FutureProvider.family<List<LatLng>, LatLng>((ref, destination) async {
//   final currentLocation = await ref.watch(currentLocationProvider.future);

//   // final polylinePoints = PolylinePoints();
//   const apiKey =
//       'AIzaSyCiUeNk2R6jiihpsymrcQhGC586itXxAYg'; // Replace with your actual API key
//   final String url =
//       'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

//   List<LatLng> decodePolyline(String encoded) {
//     PolylinePoints polylinePoints = PolylinePoints();
//     List<PointLatLng> points = polylinePoints.decodePolyline(encoded);

//     return points
//         .map((point) => LatLng(point.latitude, point.longitude))
//         .toList();
//   }

//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     if (data['routes'].isNotEmpty) {
//       final String polyline = data['routes'][0]['overview_polyline']['points'];

//       return decodePolyline(polyline);
//     } else {
//       throw Exception('No routes found');
//     }
//   } else {
//     throw Exception('Failed to fetch directions');
//   }

//   // final result = await polylinePoints.getRouteBetweenCoordinates(
//   //   request: PolylineRequest(
//   //     origin: PointLatLng(currentLocation.latitude, currentLocation.longitude),
//   //     destination: PointLatLng(destination.latitude, destination.longitude),
//   //     mode: TravelMode.driving,
//   //   ),
//   //   googleApiKey: apiKey,
//   // );
//   // print(result.points.isNotEmpty);
//   // if (result.points.isNotEmpty) {
//   //   // print(result.points.isNotEmpty);
//   //   // Convert the points to a list of LatLng
//   //   return result.points
//   //       .map((point) => LatLng(point.latitude, point.longitude))
//   //       .toList();
//   // } else {
//   //   return [];
//   // }
// });

//-----------------------------end map--------------------------------------------------------
final searchResultsProvider = StateProvider<List<ItemsDetails>>((ref) => []);

void searchupdate(ref, String searchterm, List<ItemsDetails> listOfLists) {
  final filteredResults = listOfLists.where((item) {
    return item.customerName != null &&
        (item.customerName!.toLowerCase().contains(searchterm.toLowerCase()) ||
            item.ld!.toLowerCase().contains(searchterm.toLowerCase()));
  }).toList();

  ref
      .read(searchResultsProvider.notifier)
      .state = filteredResults;
}

final fetchVisitPendingDataProvider =
FutureProvider<List<ItemsDetails>>((ref) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  print(token);

  // final String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
  final Map<String, String> queryParam = {"status": "pending"};
  final dio = ref.read(dioProvider);
  final response = await dio.get(Api.collectionVisitPending,
      queryParameters: queryParam, options: Options(headers: {"token": token}));
  print(response.statusMessage);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.data);
    List<dynamic> itemsList = response.data['items'] as List;

    // Now map this List<dynamic> to List<ItemsDetails>
    List<ItemsDetails> listOfLists = itemsList.map((map) {
      return ItemsDetails.fromJson(map);
    }).toList();

    // For debugging, print the address of the last item
    // print(listOfLists[listOfLists.length - 1].address);

    GetVisitPendingResponseData apiResponseList =
    GetVisitPendingResponseData.fromJson(response.data);
    print('>>>>>>>>>>>>> ${apiResponseList.message}');

    // List<ItemsDetails> listOfLists = response.data['items']!.map((map) {
    //   return ItemsDetails.fromJson(map);
    // }).toList();
    // print(listOfLists[listOfLists.length-1].address);
    ref
        .read(searchResultsProvider.notifier)
        .state = listOfLists;
    print(' length of the data ${response.data['items'].length}');
    return listOfLists;
  } else {
    throw Exception('Failed to load data');
  }
});

// Provider for search query state
/*final searchQueryProvider = StateProvider<String>((ref) => '');

// FutureProvider for filtered visit pending data based on search query
final filteredVisitPendingDataProvider =
FutureProvider<List<Map<String, String>>>((ref) async {
  final searchQuery = ref.watch(searchQueryProvider); // No `.state` here
  final visitPendingData = await ref.watch(fetchVisitPendingDataProvider.future);

  if (searchQuery.isEmpty) {
    return visitPendingData;
  }

  // Filter the data based on the search query
  return visitPendingData.where((item) {
    return item.values.any((value) =>
        value.toLowerCase().contains(searchQuery.toLowerCase()));
  }).toList();
});*/

//-----------------------------end map--------------------------------------------------------
// final searchResultsProvider = StateProvider<List<ItemsDetails>>((ref) => []);

final fetchCollectionDueDataProvider =
FutureProvider<List<Map<dynamic, dynamic>>>((ref) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  // final String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
  final dio = ref.read(dioProvider);

  final response = await dio.get(Api.collectionVisitPending,
      options: Options(headers: {"token": token}));
  print(response.statusMessage);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.data);
    GetVisitPendingResponseData apiResponseList =
    GetVisitPendingResponseData.fromJson(response.data);
    return apiResponseList.items!;
  } else {
    throw Exception('Failed to load data');
  }
});

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2YzlmODJmYjY1ZDhjNGRkMWUzMDQ1NSIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MzA3MTYyMzh9.mGoOPIWs1iw1VODnpuRaxTx8Op_HBc-Eb0727uYyoUw

final fetchGetAllModeOfCollectionProvider =
FutureProvider<List<ModeItem>>((ref) async {
  final dio = ref.read(dioProvider);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  //
  final response = await dio.get(Api.getAllModeOfCollection,
      options: Options(headers: {"token": token}));
  print(response.statusMessage);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.data);
    CollectionModeResponseModel apiResponseList =
    CollectionModeResponseModel.fromJson(response.data);
    return apiResponseList.items;
  } else {
    throw Exception('Failed to load data');
  }
});

// return GetVisitPendingResponseData(status: status, subCode: subCode, message: message, error: error, items: items)
// // final content = json.decode(
// //   await rootBundle.loadString('assets/configurations.json'),
// ) as Map<String, Object?>;
//
// return Configuration.fromJson(content);
