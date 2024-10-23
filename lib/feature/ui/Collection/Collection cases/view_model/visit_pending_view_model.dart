import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/collection_mode_response_model.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/get_mode_by_id_response_model.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/update_emi_submit_request_model.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_submit_request_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../model/get_visit_pending_response_data.dart';
import '../model/visit_pending_items_model.dart';
import '../model/visit_update_upload_image_responce_model.dart';

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
StateNotifierProvider<ClosuerViewModel, ClosuerModel>(
        (ref) => ClosuerViewModel());

final updateEmiFocusProvider =
StateNotifierProvider<UpdateEmiFocusProvider, Map<String, bool>>((ref) {
  return UpdateEmiFocusProvider();
});

final updateEmiViewModelProvider =
StateNotifierProvider<UpdateEmiViewModel, UpdateEmiModel>((ref) {
  final dio = ref.read(dioProvider);
  return UpdateEmiViewModel(dio);
});

final paymentStatusViewModelProvider =
StateNotifierProvider<PaymentStatusViewModel, PaymentStatusModel>((ref) {
  final dio = ref.read(dioProvider);

  final position = ref.watch(currentLocationProvider);
  return PaymentStatusViewModel(dio, position);
});

class PaymentStatusViewModel extends StateNotifier<PaymentStatusModel> {
  final Dio dio;
  final AsyncValue<Position> position;
  String imageApi = '';

  TextEditingController dateController = TextEditingController();
  final SingleValueDropDownController dropDownControllerProvider =
  SingleValueDropDownController();
  final ImagePicker picker = ImagePicker();

  PaymentStatusViewModel(this.dio, this.position) : super(PaymentStatusModel());

  Future<XFile?> clickPhoto() async {
    state = state.copyWith(isLoading: true);
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      state = state.copyWith(photoFile: pickedFile.path);
      return pickedFile;
    }
    return null;
  }

  Future<void> uploadImage(String image) async {
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image),
    });
    print(image);
    final String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
    final response = await dio.post(Api.uploadImageCollection,
        data: formData, options: Options(headers: {"token": token}));
    if (response.statusCode == 200) {
      VisitUpdateUploadImageResponseModel imageResponseModel =
      VisitUpdateUploadImageResponseModel.fromJson(response.data);
      state = state.copyWith(isLoading: false);
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
      initialDate: selectedDate.add(Duration(days: 1)),
      // Start from tomorrow
      firstDate: selectedDate.add(Duration(days: 1)),
      // First selectable date is tomorrow
      lastDate: selectedDate.add(Duration(days: 3)),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      if (kDebugMode) {
        print(picked);
      }
    }
    if (picked != null && picked != '') {
      String? formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      print(formattedDate);
      dateController.text = formattedDate;
      state = state.copyWith(date: formattedDate);
    } else {}
  }

  Future<void> visitFormSubmit({required ItemsDetails datas}) async {
    position.when(
      data: (data) async {
        final requestModel = VisitUpdateSubmitRequestModel(
            ld: datas.ld!,
            customerName: datas.customerName!,
            visitDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
            revisitDate: state.date,
            newContactNumber: int.parse(datas.mobile!),
            customerResponse: state.reason,
            paymentAmount: int.parse(state.paymentAmount),
            reasonForNotPay: state.reason,
            solution: state.solution,
            reasonForCustomerNotContactable: state.reason,
            visitSelfie: imageApi,
            address: datas.address!,
            latitude: data.latitude,
            longitude: data.longitude);

        const String token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
        final response = await dio.post(Api.visitFormSubmit,
            data: requestModel.toJson(),
            options: Options(headers: {"token": token}));
        print(response.statusMessage);
        print(response.statusCode);
        if (response.statusCode == 200) {
          return true;
          if (kDebugMode) {
            print('image ${response.data}');
          }
        } else {
          throw Exception('Failed to load data');
          return false;
        }
      },
      error: (error, stackTrace) {
        return false;
      },
      loading: () {},
    );
  }

  @override
  void dispose() {
    dropDownControllerProvider.dispose();
    dateController.dispose();
    super.dispose();
  }

  void updatePhotoValue(String value, context) {
    state = state.copyWith(photoFile: value);
    dateController.text = '';
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

  bool validateCustomerPayForm(int index) {
    final isPaymentStatusValid = _validatePaymentStatus(state.paymentStatus);
    final isPaymentAmountValid = _validatePaymentAmount(state.paymentAmount);
    final isDateValid = _validateDate(state.date);
    state = state.copyWith(
      isPaymentStatusValid: isPaymentStatusValid,
      isPaymentAmountValid: isPaymentAmountValid,
      isDateValid: isDateValid,
    );
    return isPaymentAmountValid && isPaymentStatusValid;
  }

  bool validateCustomerNotPay() {
    final isPaymentStatusValid = _validatePaymentStatus(state.paymentStatus);
    final isReasonValid = _validateReason(state.reason);
    final isSolutionValid = _validateSolution(state.solution);
    final isDateValid = _validateDate(state.date);
    state = state.copyWith(
      isPaymentStatusValid: isPaymentStatusValid,
      isReasonValid: isReasonValid,
      isSolutionValid: isSolutionValid,
      isDateValid: isDateValid,
    );
    return isDateValid &&
        isSolutionValid &&
        isReasonValid &&
        isPaymentStatusValid;
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

  void updatePhotoValue(String value, context) {
    state = state.copyWith(photoFile: value);

    Navigator.pop(context);
  }
  void updateCreditPerson(String id){
    state = state.copyWith(commonId: id);
  }

  Future<void> updateEmiSubmitButton({required ItemsDetails detail}) async {
    UpdateEmiSubmitRequestModel requestModel = UpdateEmiSubmitRequestModel(
        ld: detail.ld!,
        collectedBy: '',
        customerName: detail.customerName!,
        mobileNo: int.parse(detail.mobile!),
        receivedAmount: int.parse(state.emiAmount),
        transactionId: state.transactionId,
        transactionImage: imageApi!,
        modeOfCollectionId: state.modeOfCollectionId,
        commonId: state.commonId,
        bankName: state.bankName,
        customerEmail: state.receipt,
        emiReceivedDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        remarkByCollection: state.remark,
        partner: detail.partner!);

    const String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
    final response = await dio.post(Api.visitFormSubmit,
        data: requestModel.toJson(),
        options: Options(headers: {"token": token}));
    print(response.statusMessage);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // return true;
      if (kDebugMode) {
        print('image ${response.data}');
      }
    } else {
      throw Exception('Failed to load data');
      // return false;
    }
  }


  Future<XFile?> clickPhoto() async {
    state = state.copyWith(isLoading: true);
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      state = state.copyWith(photoFile: pickedFile.path);
      return pickedFile;
    }
    return null;
  }

  Future<void> uploadImage(String image) async {
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image),
    });
    print(image);
    final String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
    final response = await dio.post(Api.uploadImageCollection,
        data: formData, options: Options(headers: {"token": token}));
    if (response.statusCode == 200) {
      VisitUpdateUploadImageResponseModel imageResponseModel =
      VisitUpdateUploadImageResponseModel.fromJson(response.data);
      state = state.copyWith(isLoading: false);
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

  Future<void> openFeilds(String id) async {
    state = state.copyWith(modeOfCollectionId: id);
    print('id $id');
    const String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
    Response response = await dio.get(Api.getModeById,
        queryParameters: {"modeOfCollectionId": id},
        options: Options(headers: {"token": token}));
    print(response.statusMessage);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      GetModeByIdResponseModel apiResponseList =
      GetModeByIdResponseModel.fromJson(response.data);
      List<DropDownValueModel> list = [];
      print(apiResponseList);
      state = state.copyWith(isEmail: apiResponseList.items.modeDetail.email);
      state = state.copyWith(
          isExtraFormOpen: apiResponseList.items.modeDetail.extraForm);
      state = state.copyWith(modeTitle: apiResponseList.items.modeDetail.title);

      state = state.copyWith(
          modeTitle: apiResponseList.items.dropdownDetail.modelName);
      for (final drop in apiResponseList.items.detail) {
        list.add(DropDownValueModel(name: '${drop.title}', value: drop.id));
      }
      state = state.copyWith(subDropdown: list);
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
  }
}

class ClosuerViewModel extends StateNotifier<ClosuerModel> {
  ClosuerViewModel() : super(ClosuerModel());

  void updateDate(String value) {
    final isValid = _validateDate(value);
    state = state.copyWith(date: value, isDate: isValid);
  }

  void updateAmount(String value) {
    final isValid = _validateDate(value);
    state = state.copyWith(amount: value, isAmount: isValid);
  }

  void updateReason(String value) {
    final isValid = _validateReason(value);
    state = state.copyWith(reason: value, isReason: isValid);
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

class PaymentStatusModel {
  final bool isLoading;
  final int selectedValue;
  final String photoFile;
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

  PaymentStatusModel({
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

  PaymentStatusModel copyWith({
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
    return PaymentStatusModel(
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

  ClosuerModel({this.amount = '',
    this.date = '',
    this.reason = '',
    this.isAmount = true,
    this.isDate = true,
    this.isReason = true});

  ClosuerModel copyWith({
    String? amount,
    String? reason,
    String? date,
    bool? isAmount,
    bool? isDate,
    bool? isReason,
  }) {
    return ClosuerModel(
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
  final String dropdownDetail;
  final String emiAmount;
  final String transactionId;
  final String transactionImage;
  final String remark;
  final String bankName;
  final String receipt;
  final bool isEmiAmount;
  final bool isTransactionId;
  final bool isTransactionImage;
  final bool isRemark;
  final bool isBankName;
  final bool isReceipt;
  final bool isExtraFormOpen;
  final bool isEmail;
  final String modeTitle;

  UpdateEmiModel({
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
    this.receipt = '',
    this.isEmiAmount = true,
    this.isTransactionId = true,
    this.isTransactionImage = true,
    this.isRemark = true,
    this.isBankName = true,
    this.isReceipt = true,
    this.isLoading = false});

  UpdateEmiModel copyWith({
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
StateProvider<GoogleMapController?>((ref) => null);

// Provider to manage the polyline for directions
final polylineProvider = StateProvider<List<Polyline>>((ref) => []);

// Provider to fetch directions between two points
final directionsProvider =
FutureProvider.family<List<LatLng>, LatLng>((ref, destination) async {
  final currentLocation = await ref.watch(currentLocationProvider.future);

  final polylinePoints = PolylinePoints();
  const apiKey =
      'AIzaSyCiUeNk2R6jiihpsymrcQhGC586itXxAYg'; // Replace with your actual API key

  final result = await polylinePoints.getRouteBetweenCoordinates(
    request: PolylineRequest(
      origin: PointLatLng(currentLocation.latitude, currentLocation.longitude),
      destination: PointLatLng(destination.latitude, destination.longitude),
      mode: TravelMode.driving,
    ),
    googleApiKey: apiKey,
  );

  if (result.points.isNotEmpty) {
    // Convert the points to a list of LatLng
    return result.points
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
  } else {
    return [];
  }
});
//-----------------------------end map--------------------------------------------------------

final fetchVisitPendingDataProvider =
FutureProvider<List<Map<String, String>>>((ref) async {
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
  final Map<String, String> queryParam = {"status": "pending"};
  final dio = ref.read(dioProvider);
  final response = await dio.get(Api.collectionVisitPending,
      queryParameters: queryParam, options: Options(headers: {"token": token}));
  print(response.statusMessage);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.data);
    GetVisitPendingResponseData apiResponseList =
    GetVisitPendingResponseData.fromJson(response.data);
    return apiResponseList.items;
  } else {
    throw Exception('Failed to load data');
  }
});

final fetchGetAllModeOfCollectionProvider =
FutureProvider<List<ModeItem>>((ref) async {
  const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
  final dio = ref.read(dioProvider);
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
