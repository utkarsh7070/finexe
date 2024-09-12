import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../../base/utils/widget/upload_box.dart';
import '../../view_model/sales_on_boarding_form.dart';

class StepperContentOne extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = ref.watch(optionRoleProvider);
    return Column(
      children: [
        UploadBox(
          height: displayHeight(context) * 0.15,
          width: displayWidth(context),
          color: AppColors.buttonBorderGray,
          iconData: Icons.file_upload_outlined,
          textColor: AppColors.buttonBorderGray,
          title: 'Max size: 10MB',
          subTitle: 'Co-Applicant Photo',
        ),
        Text('Is Customer Mobile No. Linked With Aadhaar ?'),
        Row(
          children: [
            adhaarLinkRadios(
                context: context,
                title: 'Yes',
                value: OptionRole.Yes,
                ref: ref,
                selectedValue: selectedValue),
            adhaarLinkRadios(
                context: context,
                title: 'No',
                value: OptionRole.NO,
                ref: ref,
                selectedValue: selectedValue),
          ],
        ),
        Text('Personal Detail’s'),
      ],
    );
  }
}

Widget adhaarLinkRadios(
    {required BuildContext context,
    required OptionRole selectedValue,
    required WidgetRef ref,
    required String title,
    required OptionRole value}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.30,
    child: Row(
      children: [
        Radio<OptionRole>(
          value: value,
          groupValue: selectedValue,
          onChanged: (value) {
            if (value != null) {
              ref.read(optionRoleProvider.notifier).select(value);
            }
          },
        ),
        Text(
          title,
        )
      ],
    ),
  );
}

// Widget ifYesLinkedAdhaar(){
//   return Container(child:Column(children: [
//     Text('Aadhar Number'),
//     AppFloatTextField(
//       focusNode: focusViewModel.passFocusNode,
//       currentState: focusStates['passFocusNode'],
//       height: passwordValidations
//           ? displayHeight(context) * 0.09
//           : null,
//       // focusNode: FocusNode(),
//       onValidate: (value) {
//         print(value);
//         if (value!.isEmpty) {
//           return "password is a required field";
//         }
//         return '';
//       },
//       onFiledSubmitted: (value) {
//         ref
//             .read(passwordValidationProvider.notifier)
//             .checkPassword(value);
//       },
//       inerHint: 'Enter Aadhaar Number',
//       errorText: "Aadhaar Number is a required field",
//       isError: passwordValidations,
//       textInputAction: TextInputAction.next,
//       isSuffix: true,
//       obscureText: obscureValue,
//       suffixIcon: obscureValue
//           ? CupertinoIcons.eye_slash
//           : CupertinoIcons.eye,
//       suffixOnTap: () {
//         if (obscureValue != true) {
//           ref.read(obscureTextProvider.notifier).state = true;
//         } else {
//           ref.read(obscureTextProvider.notifier).state = false;
//         }
//       },
//       hint: 'Password',
//       controller: _passwordController,
//     ),
//   ],),);
// }
enum OptionRole { Yes, NO, NON }
