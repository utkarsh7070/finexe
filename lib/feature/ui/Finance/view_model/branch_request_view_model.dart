
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';


final bankRequestController = StateNotifierProvider<FormDataControllerNotifier, FormDataController>(
      (ref) => FormDataControllerNotifier(),
);

class FormDataController {
  // TextEditingControllers
  final TextEditingController branchNameController;
  final TextEditingController branchAddressController;
  final TextEditingController ownerNameController;
  final TextEditingController residentialAddressController;
  final TextEditingController ownerContactController;
  final TextEditingController accountNameController;
  final TextEditingController accountNumberController;
  final TextEditingController accountIfscController;
  final TextEditingController accountBankNameController;
  final TextEditingController brokerNameController;
  final TextEditingController brokerAccountNumberController;
  final TextEditingController brokerIfscController;
  final TextEditingController brokerBankNameController;
  final TextEditingController pmRentController;
  final TextEditingController rentAdvanceAmountController;
  final TextEditingController rentDateController;
  final TextEditingController rentBrokerExpenseController;
  final String uploadedImages;
  final String uploadedImagesOne;
  final String uploadedImagesTwo;
  final String uploadedImagesThree;
  final String uploadedImagesFour;

  // FocusNodes
  final FocusNode branchFocusNode;
  final FocusNode clusterFocusNode;
  final FocusNode branchAddressFocusNode;
  final FocusNode ownerNameFocusNode;
  final FocusNode residentialAddressFocusNode;
  final FocusNode ownerContactFocusNode;
  final FocusNode accountNameFocusNode;
  final FocusNode accountNumberFocusNode;
  final FocusNode accountIfscFocusNode;
  final FocusNode accountBankNameFocusNode;
  final FocusNode brokerNameFocusNode;
  final FocusNode brokerAccountNumberFocusNode;
  final FocusNode brokerIfscFocusNode;
  final FocusNode brokerBankNameFocusNode;
  final FocusNode pmRentFocusNode;
  final FocusNode rentAdvanceAmountFocusNode;
  final FocusNode rentDateFocusNode;
  final FocusNode rentBrokerExpenseFocusNode;

  // Validation Flags
  bool isBranchNameValid;
  bool isBranchAddressValid;
  bool isAccountNameValid;
  bool isAccountNumberValid;
  bool isAccountIfscValid;
  bool isAccountBankNameValid;
  bool isOwnerNameValid;
  bool isOwneResidentialValid;
  bool isOwnerContactValid;
  bool isBrokerNameValid;
  bool isBrokerNumberValid;
  bool isBrokerIfscValid;
  bool isBrokerBankNameValid;
  bool isRentPMRentValid;
  bool isRentAmountValid;
  bool isRentBrokerExpenseValid;
  bool isRentDateValid;

  // Cluster Options
  final List<String> clusterOptions;
  final List<String> selectedClusterOptions;

  // Image upload
  // final ImagePicker picker ;

  FormDataController({
    required this.branchNameController,
    required this.branchAddressController,
    required this.ownerNameController,
    required this.residentialAddressController,
    required this.ownerContactController,
    required this.accountNameController,
    required this.accountNumberController,
    required this.accountIfscController,
    required this.accountBankNameController,
    required this.brokerNameController,
    required this.brokerAccountNumberController,
    required this.brokerIfscController,
    required this.brokerBankNameController,
    required this.pmRentController,
    required this.rentAdvanceAmountController,
    required this.rentDateController,
    required this.rentBrokerExpenseController,
    required this.uploadedImages,
    required this.uploadedImagesOne,
    required this.uploadedImagesTwo,
    required this.uploadedImagesThree,
    required this.uploadedImagesFour,
    required this.branchFocusNode,
    required this.clusterFocusNode,
    required this.branchAddressFocusNode,
    required this.ownerNameFocusNode,
    required this.residentialAddressFocusNode,
    required this.ownerContactFocusNode,
    required this.accountNameFocusNode,
    required this.accountNumberFocusNode,
    required this.accountIfscFocusNode,
    required this.accountBankNameFocusNode,
    required this.brokerNameFocusNode,
    required this.brokerAccountNumberFocusNode,
    required this.brokerIfscFocusNode,
    required this.brokerBankNameFocusNode,
    required this.pmRentFocusNode,
    required this.rentAdvanceAmountFocusNode,
    required this.rentDateFocusNode,
    required this.rentBrokerExpenseFocusNode,
    this.isBranchNameValid = false,
    this.isBranchAddressValid = false,
    this.isAccountNameValid = false,
    this.isAccountNumberValid = false,
    this.isAccountIfscValid = false,
    this.isAccountBankNameValid = false,
    this.isOwnerNameValid = false,
    this.isOwneResidentialValid = false,
    this.isOwnerContactValid = false,
    this.isBrokerNameValid = false,
    this.isBrokerNumberValid = false,
    this.isBrokerIfscValid = false,
    this.isBrokerBankNameValid = false,
    this.isRentPMRentValid = false,
    this.isRentAmountValid = false,
    this.isRentBrokerExpenseValid = false,
    this.isRentDateValid = true,
    this.clusterOptions = const["Indore", "Dewas", "Guna", "Ujjain", "Bhopal"],
   this.selectedClusterOptions = const[],
  });


  FormDataController copyWith({
    TextEditingController? branchNameController,
    TextEditingController? branchAddressController,
    TextEditingController? ownerNameController,
    TextEditingController? residentialAddressController,
    TextEditingController? ownerContactController,
    TextEditingController? accountNameController,
    TextEditingController? accountNumberController,
    TextEditingController? accountIfscController,
    TextEditingController? accountBankNameController,
    TextEditingController? brokerNameController,
    TextEditingController? brokerAccountNumberController,
    TextEditingController? brokerIfscController,
    TextEditingController? brokerBankNameController,
    TextEditingController? pmRentController,
    TextEditingController? rentAdvanceAmountController,
    TextEditingController? rentDateController,
    TextEditingController? rentBrokerExpenseController,
    String? uploadedImages,
    String? uploadedImagesOne,
    String? uploadedImagesTwo,
    String? uploadedImagesThree,
    String? uploadedImagesFour,
    FocusNode? branchFocusNode,
    FocusNode? clusterFocusNode,
    FocusNode? branchAddressFocusNode,
    FocusNode? ownerNameFocusNode,
    FocusNode? residentialAddressFocusNode,
    FocusNode? ownerContactFocusNode,
    FocusNode? accountNameFocusNode,
    FocusNode? accountNumberFocusNode,
    FocusNode? accountIfscFocusNode,
    FocusNode? accountBankNameFocusNode,
    FocusNode? brokerNameFocusNode,
    FocusNode? brokerAccountNumberFocusNode,
    FocusNode? brokerIfscFocusNode,
    FocusNode? brokerBankNameFocusNode,
    FocusNode? pmRentFocusNode,
    FocusNode? rentAdvanceAmountFocusNode,
    FocusNode? rentDateFocusNode,
    FocusNode? rentBrokerExpenseFocusNode,
    bool? isBranchNameValid,
    bool? isBranchAddressValid,
    bool? isAccountNameValid,
    bool? isAccountNumberValid,
    bool? isAccountIfscValid,
    bool? isAccountBankNameValid,
    bool? isOwnerNameValid,
    bool? isOwneResidentialValid,
    bool? isOwnerContactValid,
    bool? isBrokerNameValid,
    bool? isBrokerNumberValid,
    bool? isBrokerIfscValid,
    bool? isBrokerBankNameValid,
    bool? isRentPMRentValid,
    bool? isRentAmountValid,
    bool? isRentBrokerExpenseValid,
    bool? isRentDateValid,
    List<String>? clusterOptions,
    List<String>? selectedClusterOptions,
  }) {
    return FormDataController(
      branchNameController: branchNameController ?? this.branchNameController,
      clusterOptions: clusterOptions ?? this.clusterOptions,
      branchAddressController: branchAddressController ?? this.branchAddressController,
      ownerNameController: ownerNameController ?? this.ownerNameController,
      residentialAddressController: residentialAddressController ?? this.residentialAddressController,
      ownerContactController: ownerContactController ?? this.ownerContactController,
      accountNameController: accountNameController ?? this.accountNameController,
      accountNumberController: accountNumberController ?? this.accountNumberController,
      accountIfscController: accountIfscController ?? this.accountIfscController,
      accountBankNameController: accountBankNameController ?? this.accountBankNameController,
      brokerNameController: brokerNameController ?? this.brokerNameController,
      brokerAccountNumberController: brokerAccountNumberController ?? this.brokerAccountNumberController,
      brokerIfscController: brokerIfscController ?? this.brokerIfscController,
      brokerBankNameController: brokerBankNameController ?? this.brokerBankNameController,
      pmRentController: pmRentController ?? this.pmRentController,
      rentAdvanceAmountController: rentAdvanceAmountController ?? this.rentAdvanceAmountController,
      rentDateController: rentDateController ?? this.rentDateController,
      rentBrokerExpenseController: rentBrokerExpenseController ?? this.rentBrokerExpenseController,
      branchFocusNode: branchFocusNode ?? this.branchFocusNode,
      clusterFocusNode: clusterFocusNode ?? this.clusterFocusNode,
      branchAddressFocusNode: branchAddressFocusNode ?? this.branchAddressFocusNode,
      ownerNameFocusNode: ownerNameFocusNode ?? this.ownerNameFocusNode,
      residentialAddressFocusNode: residentialAddressFocusNode ?? this.residentialAddressFocusNode,
      ownerContactFocusNode: ownerContactFocusNode ?? this.ownerContactFocusNode,
      accountNameFocusNode: accountNameFocusNode ?? this.accountNameFocusNode,
      accountNumberFocusNode: accountNumberFocusNode ?? this.accountNumberFocusNode,
      accountIfscFocusNode: accountIfscFocusNode ?? this.accountIfscFocusNode,
      accountBankNameFocusNode: accountBankNameFocusNode ?? this.accountBankNameFocusNode,
      brokerNameFocusNode: brokerNameFocusNode ?? this.brokerNameFocusNode,
      brokerAccountNumberFocusNode: brokerAccountNumberFocusNode ?? this.brokerAccountNumberFocusNode,
      brokerIfscFocusNode: brokerIfscFocusNode ?? this.brokerIfscFocusNode,
      brokerBankNameFocusNode: brokerBankNameFocusNode ?? this.brokerBankNameFocusNode,
      pmRentFocusNode: pmRentFocusNode ?? this.pmRentFocusNode,
      rentAdvanceAmountFocusNode: rentAdvanceAmountFocusNode ?? this.rentAdvanceAmountFocusNode,
      rentDateFocusNode: rentDateFocusNode ?? this.rentDateFocusNode,
      rentBrokerExpenseFocusNode: rentBrokerExpenseFocusNode ?? this.rentBrokerExpenseFocusNode,
      isAccountNameValid: isAccountNameValid ?? this.isAccountNameValid,
      isAccountNumberValid: isAccountNumberValid ?? this.isAccountNumberValid,
      isAccountIfscValid: isAccountIfscValid ?? this.isAccountIfscValid,
      isAccountBankNameValid: isAccountBankNameValid ?? this.isAccountBankNameValid,
      isBranchNameValid: isBranchNameValid ?? this.isBranchNameValid,
      isBranchAddressValid: isBranchAddressValid ?? this.isBranchAddressValid,

      // ---------- Owner ------
       isOwnerNameValid: isOwnerNameValid ?? this.isOwnerNameValid,
       isOwneResidentialValid: isOwneResidentialValid ?? this.isOwneResidentialValid,
       isOwnerContactValid: isOwnerContactValid ?? this.isOwnerContactValid,

    // ------- Broker ---
     isBrokerNameValid: isBrokerNameValid ?? this.isBrokerNameValid,
     isBrokerNumberValid: isBrokerNumberValid ?? this.isBrokerNumberValid,
     isBrokerIfscValid: isBrokerIfscValid ?? this.isBrokerIfscValid,
     isBrokerBankNameValid: isBrokerBankNameValid ?? this.isBrokerBankNameValid,

    // ------ Rent ---
     isRentPMRentValid: isRentPMRentValid ?? this.isRentPMRentValid,
      isRentAmountValid: isRentAmountValid ?? this.isRentAmountValid,
      isRentBrokerExpenseValid: isRentBrokerExpenseValid ?? this.isRentBrokerExpenseValid,
      isRentDateValid: isRentDateValid ?? this.isRentDateValid,

      selectedClusterOptions: selectedClusterOptions ?? this.selectedClusterOptions,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      uploadedImagesOne: uploadedImagesOne ?? this.uploadedImagesOne,
      uploadedImagesTwo: uploadedImagesTwo ?? this.uploadedImagesTwo,
      uploadedImagesThree: uploadedImagesThree ?? this.uploadedImagesThree,
      uploadedImagesFour: uploadedImagesFour ?? this.uploadedImagesFour,
    );
  }
}

class FormDataControllerNotifier extends StateNotifier<FormDataController> {
  FormDataControllerNotifier() : super(FormDataController(
    branchNameController: TextEditingController(),
    branchAddressController: TextEditingController(),
    ownerNameController: TextEditingController(),
    residentialAddressController: TextEditingController(),
    ownerContactController: TextEditingController(),
    accountNameController: TextEditingController(),
    accountNumberController: TextEditingController(),
    accountIfscController: TextEditingController(),
    accountBankNameController: TextEditingController(),
    brokerNameController: TextEditingController(),
    brokerAccountNumberController: TextEditingController(),
    brokerIfscController: TextEditingController(),
    brokerBankNameController: TextEditingController(),
    pmRentController: TextEditingController(),
    rentAdvanceAmountController: TextEditingController(),
    rentDateController: TextEditingController(),
    rentBrokerExpenseController: TextEditingController(),
    uploadedImages: '',
    uploadedImagesOne: '',
    uploadedImagesTwo: '',
    uploadedImagesThree: '',
    uploadedImagesFour: '',
    branchFocusNode: FocusNode(),
    clusterFocusNode: FocusNode(),
    branchAddressFocusNode: FocusNode(),
    ownerNameFocusNode: FocusNode(),
    residentialAddressFocusNode: FocusNode(),
    ownerContactFocusNode: FocusNode(),
    accountNameFocusNode: FocusNode(),
    accountNumberFocusNode: FocusNode(),
    accountIfscFocusNode: FocusNode(),
    accountBankNameFocusNode: FocusNode(),
    brokerNameFocusNode: FocusNode(),
    brokerAccountNumberFocusNode: FocusNode(),
    brokerIfscFocusNode: FocusNode(),
    brokerBankNameFocusNode: FocusNode(),
    pmRentFocusNode: FocusNode(),
    rentAdvanceAmountFocusNode: FocusNode(),
    rentDateFocusNode: FocusNode(),
    rentBrokerExpenseFocusNode: FocusNode(), clusterOptions: [],
  ));

  // Update and validate Account Name
  void updateAccountNameValidation(String value) {
    final isValid = value.isNotEmpty; // Example validation
    state = state.copyWith(
      isAccountNameValid: isValid,
    );
  }

  // Update and validate Account Number
  void updateAccountNumberValidation(String value) {
    final isValid = value.length == 12; // Example: Account number must be 12 digits
    state = state.copyWith(
      isAccountNumberValid: isValid,
    );
  }

  // Update and validate IFSC Code
  void updateAccountIfscValidation(String value) {
    final isValid = value.length == 11; // Example: IFSC code must be 11 characters
    state = state.copyWith(
      isAccountIfscValid: isValid,
    );
  }

  // Update and validate Bank Name
  void updateAccountBankNameValidation(String value) {
    final isValid = value.isNotEmpty; // Example: Bank name must not be empty
    state = state.copyWith(
      isAccountBankNameValid: isValid,
    );
  }

  // Update and validate Branch Selection
  void updateBranchName(String branch) {
    final isValid = branch.isNotEmpty; // Example: Branch must be selected
    state = state.copyWith(
      isBranchNameValid: isValid,
    );
  }

  // Update and validate Cluster Selection
  void updateClusterSelection(List<String> cluster) {
    state = state.copyWith(
      selectedClusterOptions:cluster,
    );
  }

  // Update and validate Branch address
  void updateBranchAddress(String branch) {
    final isValid = branch.isNotEmpty; // Example: Branch must be selected
    state = state.copyWith(
      isBranchAddressValid: isValid,
    );
  }

  // Update and validate Owner Selection
  void updateOwnerName(String branch) {
    final isValid = branch.isNotEmpty; // Example: Branch must be selected
    state = state.copyWith(
      isOwnerNameValid: isValid,
    );
  }

  void updateOwnerResidential(String branch) {
    final isValid = branch.isNotEmpty; // Example: Branch must be selected
    state = state.copyWith(
      isOwneResidentialValid: isValid,
    );
  }

  void updateOwnerContact(String branch) {
    final isValid = branch.isNotEmpty; // Example: Branch must be selected
    state = state.copyWith(
      isOwnerContactValid: isValid,
    );
  }

  // ------------ broker valdation
  void updateBrokerNameValidation(String value) {
    final isValid = value.isNotEmpty; // Example validation
    state = state.copyWith(
      isBranchNameValid: isValid,
    );
  }

  // Update and validate Broker Number
  void updateBrokerAccountNumberValidation(String value) {
    final isValid = value.length == 12; // Example: Account number must be 12 digits
    state = state.copyWith(
      isBrokerNumberValid: isValid,
    );
  }

  // Update and validate IFSC Code
  void updateBrokerIfscValidation(String value) {
    final isValid = value.length == 11; // Example: IFSC code must be 11 characters
    state = state.copyWith(
      isBrokerIfscValid: isValid,
    );
  }
  // Update and validate IFSC Code
  void updateBrokerBankValidation(String value) {
    final isValid = value.length == 11; // Example: IFSC code must be 11 characters
    state = state.copyWith(
      isBrokerBankNameValid: isValid,
    );
  }


  // Update and validate Rent Amount
  void updateRentAmountValidation(String value) {
    final isValid = double.tryParse(value) != null; // Example: Rent must be a valid number
    state = state.copyWith(
      isRentAmountValid: isValid,
    );
  }

  // Update and validate Rent Advance Amount
  void updateRentPMRentValidation(String value) {
    final isValid = double.tryParse(value) != null; // Example: Rent advance amount must be a valid number
    state = state.copyWith(
      isRentPMRentValid: isValid,
    );
  }
  // Update and validate Rent Advance Amount

  void updateRentBrokerExpensValidation(String value) {
    final isValid = double.tryParse(value) != null; // Example: Rent advance amount must be a valid number
    state = state.copyWith(
      isRentBrokerExpenseValid: isValid,
    );
  }


  // ----------- Image picker Start ----
  // Example function to update uploaded images
  void updateUploadedImages(String imageField, String imagePath) {
    // Dynamically update the corresponding field based on the field name
    switch (imageField) {
      case 'uploadedImages':
        state = state.copyWith(uploadedImages: imagePath);
        break;
      case 'uploadedImagesOne':
        state = state.copyWith(uploadedImagesOne: imagePath);
        break;
      case 'uploadedImagesTwo':
        state = state.copyWith(uploadedImagesTwo: imagePath);
        break;
      case 'uploadedImagesThree':
        state = state.copyWith(uploadedImagesThree: imagePath);
        break;
      case 'uploadedImagesFour':
        state = state.copyWith(uploadedImagesFour: imagePath);
        break;
      default:
        print('Unknown image field: $imageField');
    }
  }


  Future<void> pickImage(String imageField) async {
    await Permission.photos.request();

    if (await Permission.photos.status.isGranted) {
      try {
        final ImagePicker picker = ImagePicker();
        XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);

        if (pickedImage != null) {
          print('Picked Image Path: ${pickedImage.path}');

          // Update the state dynamically based on the field name
          switch (imageField) {
            case 'uploadedImages':
              state = state.copyWith(uploadedImages: pickedImage.path);
              break;
            case 'uploadedImagesOne':
              state = state.copyWith(uploadedImagesOne: pickedImage.path);
              break;
            case 'uploadedImagesTwo':
              state = state.copyWith(uploadedImagesTwo: pickedImage.path);
              break;
            case 'uploadedImagesThree':
              state = state.copyWith(uploadedImagesThree: pickedImage.path);
              break;
            case 'uploadedImagesFour':
              state = state.copyWith(uploadedImagesFour: pickedImage.path);
              break;
          }
        }
      } catch (e) {
        print('Failed to pick image: $e');
      }
    } else {
      print('Permission denied for picking images');
    }
  }

  // ----------- Image picker End ----


  // ----------- date piker setup -------
  bool _validateDate(String date) {
    return date.isNotEmpty;
  }

  void updateDate(DateTime value) {
    // Format the date as yyyy-MM-dd
    final formattedDate = DateFormat('yyyy-MM-dd').format(value).toString();
    // Validate and store the formatted date
    final isValid = _validateDate(formattedDate);
    state = state.copyWith( isRentDateValid: isValid);
  }

  // ---------- Date picker Open -------
  Future<void> openDatePicker(WidgetRef ref, DateTime? initialDate) async {
    final pickedDate = await showDatePicker(
      context: ref.context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      updateDate(pickedDate); // Update the date in the state
      ref
          .read(dateProvider.notifier)
          .updateDate(pickedDate); // Use ref to read the provider
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