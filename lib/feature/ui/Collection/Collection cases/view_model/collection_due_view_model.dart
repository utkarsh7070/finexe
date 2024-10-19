// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// // final visitPendingData= StateNotifierProvider<VisitPendingModel,>((ref) {
// //
// // },)
//
// final collectionDueDropDown = StateProvider<List<DropDownValueModel>>(
//   (ref) {
//     return [
//       const DropDownValueModel(name: 'None', value: "none"),
//       const DropDownValueModel(
//           name: 'Customer Will Pay EMI', value: "CustomerWillPayEmi"),
//       const DropDownValueModel(
//           name: 'Customer Will Not Pay EMI', value: "CustomerWillNotPayEmi"),
//       const DropDownValueModel(
//           name: 'Customer Not Contactable', value: "CustomerNotContactable"),
//     ];
//   },
// );
//
// //--------------------drop down----------------------------------
//
// final paymentCollectionDueFocusProvider =
//     StateNotifierProvider<PaymentStatusFocusProvider, Map<String, bool>>((ref) {
//   return PaymentStatusFocusProvider();
// });
//
// final collectionDueDropDownControllerProvider =
//     StateProvider<SingleValueDropDownController>((ref) {
//   return SingleValueDropDownController();
// });
//
// final paymentCollectionDueViewModelProvider =
//     StateNotifierProvider<PaymentStatusViewModel, PaymentStatusModel>(
//         (ref) => PaymentStatusViewModel());
//
// class PaymentStatusViewModel extends StateNotifier<PaymentStatusModel> {
//   PaymentStatusViewModel() : super(PaymentStatusModel());
//
//   void updatePaymentStatus(String value) {
//     final isValid = _validatePaymentStatus(value);
//     state = state.copyWith(paymentStatus: value, isPaymentStatusValid: isValid);
//     // copyWith(kycDocument: value, isKycValid: isValid);
//   }
//
//   void updatePaymentAmount(String value) {
//     final isValid = _validatePaymentAmount(value);
//     state = state.copyWith(paymentAmount: value, isPaymentAmountValid: isValid);
//     // copyWith(kycDocument: value, isKycValid: isValid);
//   }
//
//   void updateDate(String value) {
//     final isValid = _validateDate(value);
//     state = state.copyWith(date: value, isDateValid: isValid);
//     // copyWith(kycDocument: value, isKycValid: isValid);
//   }
//
//   void updateReason(String value) {
//     final isValid = _validateReason(value);
//     state = state.copyWith(reason: value, isReasonValid: isValid);
//     // copyWith(kycDocument: value, isKycValid: isValid);
//   }
//
//   void updateSolution(String value) {
//     final isValid = _validateSolution(value);
//     state = state.copyWith(solution: value, isSolutionValid: isValid);
//     // copyWith(kycDocument: value, isKycValid: isValid);
//   }
//
//   bool validateCustomerPayForm(int index) {
//     final isPaymentStatusValid = _validatePaymentStatus(state.paymentStatus);
//     final isPaymentAmountValid = _validatePaymentAmount(state.paymentAmount);
//     final isDateValid = _validateDate(state.date);
//     state = state.copyWith(
//       isPaymentStatusValid: isPaymentStatusValid,
//       isPaymentAmountValid: isPaymentAmountValid,
//       isDateValid: isDateValid,
//     );
//     return isPaymentAmountValid && isPaymentStatusValid;
//   }
//
//   bool validateCustomerNotPay() {
//     final isPaymentStatusValid = _validatePaymentStatus(state.paymentStatus);
//     final isReasonValid = _validateReason(state.reason);
//     final isSolutionValid = _validateSolution(state.solution);
//     final isDateValid = _validateDate(state.date);
//     state = state.copyWith(
//       isPaymentStatusValid: isPaymentStatusValid,
//       isReasonValid: isReasonValid,
//       isSolutionValid: isSolutionValid,
//       isDateValid: isDateValid,
//     );
//     return isDateValid &&
//         isSolutionValid &&
//         isReasonValid &&
//         isPaymentStatusValid;
//   }
//
// // bool validateSelectedValue() {
// //   final selected = state.paymentStatus;
// //   return selected =='CustomerWillPayEmi';
// //
// // }
// }
//
// bool _validatePaymentStatus(String paymentStatus) {
//   return paymentStatus.isNotEmpty;
// }
//
// bool _validatePaymentAmount(String paymentAmount) {
//   return paymentAmount.isNotEmpty;
// }
//
// bool _validateDate(String date) {
//   return date.isNotEmpty;
// }
//
// bool _validateReason(String reason) {
//   return reason.isNotEmpty;
// }
//
// bool _validateSolution(String solution) {
//   return solution.isNotEmpty;
// }
//
// class PaymentStatusFocusProvider extends StateNotifier<Map<String, bool>> {
//   final FocusNode paymentStatusFocusNode;
//   final FocusNode paymentAmountFocusNode;
//   final FocusNode dateFocusNode;
//   final FocusNode reasonFocusNode;
//   final FocusNode solutionFocusNode;
//
//   PaymentStatusFocusProvider()
//       : paymentStatusFocusNode = FocusNode(),
//         paymentAmountFocusNode = FocusNode(),
//         dateFocusNode = FocusNode(),
//         reasonFocusNode = FocusNode(),
//         solutionFocusNode = FocusNode(),
//         super({
//           'paymentStatusFocusNode': false,
//           'paymentAmountFocusNode': false,
//           'dateFocusNode': false,
//           'reasonFocusNode': false,
//           'solutionFocusNode': false,
//         }) {
//     paymentStatusFocusNode.addListener(
//       () => _focusListener('paymentStatusFocusNode', paymentStatusFocusNode),
//     );
//     paymentAmountFocusNode.addListener(
//       () => _focusListener('paymentAmountFocusNode', paymentAmountFocusNode),
//     );
//     dateFocusNode.addListener(
//       () => _focusListener('dateFocusNode', dateFocusNode),
//     );
//     reasonFocusNode.addListener(
//       () => _focusListener('reasonFocusNode', reasonFocusNode),
//     );
//     solutionFocusNode.addListener(
//       () => _focusListener('solutionFocusNode', solutionFocusNode),
//     );
//   }
//
//   void _focusListener(String field, FocusNode focusNode) {
//     state = {
//       ...state,
//       field: focusNode.hasFocus,
//     };
//   }
//
//   @override
//   void dispose() {
//     paymentStatusFocusNode.removeListener(
//       () => _focusListener('paymentStatusFocusNode', paymentStatusFocusNode),
//     );
//     paymentAmountFocusNode.removeListener(
//       () => _focusListener('paymentAmountFocusNode', paymentAmountFocusNode),
//     );
//     dateFocusNode.removeListener(
//       () => _focusListener('dateFocusNode', dateFocusNode),
//     );
//     reasonFocusNode.removeListener(
//       () => _focusListener('reasonFocusNode', reasonFocusNode),
//     );
//     solutionFocusNode.removeListener(
//       () => _focusListener('solutionFocusNode', solutionFocusNode),
//     );
//     paymentStatusFocusNode.dispose();
//     paymentAmountFocusNode.dispose();
//     dateFocusNode.dispose();
//     reasonFocusNode.dispose();
//     solutionFocusNode.dispose();
//
//     super.dispose();
//   }
// }
//
// class PaymentStatusModel {
//   final int selectedValue;
//   final String paymentStatus;
//   final bool isPaymentStatusValid;
//   final String paymentAmount;
//   final bool isPaymentAmountValid;
//   final String date;
//   final bool isDateValid;
//   final String reason;
//   final bool isReasonValid;
//   final String solution;
//   final bool isSolutionValid;
//
//   PaymentStatusModel({
//     this.selectedValue = 0,
//     this.paymentStatus = '',
//     this.isPaymentStatusValid = true,
//     this.paymentAmount = '',
//     this.isPaymentAmountValid = true,
//     this.date = '',
//     this.isDateValid = true,
//     this.reason = '',
//     this.isReasonValid = true,
//     this.solution = '',
//     this.isSolutionValid = true,
//   });
//
//   PaymentStatusModel copyWith({
//     int? selectedValue,
//     String? paymentStatus,
//     bool? isPaymentStatusValid,
//     String? paymentAmount,
//     bool? isPaymentAmountValid,
//     String? date,
//     bool? isDateValid,
//     String? reason,
//     bool? isReasonValid,
//     String? solution,
//     bool? isSolutionValid,
//   }) {
//     return PaymentStatusModel(
//       selectedValue: selectedValue ?? this.selectedValue,
//       paymentStatus: paymentStatus ?? this.paymentStatus,
//       isPaymentStatusValid: isPaymentStatusValid ?? this.isPaymentStatusValid,
//       paymentAmount: paymentAmount ?? this.paymentAmount,
//       isPaymentAmountValid: isPaymentAmountValid ?? this.isPaymentAmountValid,
//       date: date ?? this.date,
//       isDateValid: isDateValid ?? this.isDateValid,
//       reason: reason ?? this.reason,
//       isReasonValid: isReasonValid ?? this.isReasonValid,
//       solution: solution ?? this.solution,
//       isSolutionValid: isSolutionValid ?? this.isSolutionValid,
//     );
//   }
// }
// //-------------------------------end dropdown------------------------------
