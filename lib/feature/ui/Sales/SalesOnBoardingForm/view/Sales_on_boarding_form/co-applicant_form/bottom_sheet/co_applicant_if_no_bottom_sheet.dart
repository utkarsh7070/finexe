import 'dart:io';

import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../../base/utils/namespase/font_size.dart';
import '../../../../../../../base/utils/widget/app_button.dart';
import '../../../../view_model/application_form_view_model.dart';
import '../../../../view_model/co_applicant_form_view_model.dart';

class CoApplicationPhotoBottomSheet extends ConsumerWidget {
  const CoApplicationPhotoBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getOtpClicked = ref.watch(getOpt);
    final applicantFormState = ref.watch(coApplicantViewModelProvider);
    final applicantFormViewModel =
        ref.read(coApplicantViewModelProvider.notifier);
    final checkBoxTerms = ref.watch(checkBoxTermsConditionApplicant);
    // final selectedValue = ref.watch(applicantRoleProvider);
    final index = ref.watch(listIndex);
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Upload Aadhar Image'),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  applicantFormViewModel.pickAadhaar1Images(index);
                },
                child: Visibility(
                  visible:
                      applicantFormState[index].aadhaarPhotoFilePath1 == '',
                  replacement: SizedBox(
                    height: displayHeight(context) * 0.15,
                    width: displayWidth(context) * 0.40,
                    child: Image.file(
                        File(applicantFormState[index].aadhaarPhotoFilePath1)),
                  ),
                  child: UploadBox(
                    isImage: true,
                    height: displayHeight(context) * 0.15,
                    width: displayWidth(context) * 0.40,
                    color: AppColors.buttonBorderGray,
                    iconData: Icons.file_upload_outlined,
                    textColor: AppColors.titleGray,
                    subTextColor: AppColors.primary,
                    title: 'Max size: 10MB',
                    subTitle: 'Front Image',
                  ),
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  applicantFormViewModel.pickAadhaar2Images(index);
                },
                child: Visibility(
                  visible:
                      applicantFormState[index].aadhaarPhotoFilePath2 == '',
                  replacement: SizedBox(
                    height: displayHeight(context) * 0.15,
                    width: displayWidth(context) * 0.40,
                    child: Image.file(
                        File(applicantFormState[index].aadhaarPhotoFilePath2)),
                  ),
                  child: UploadBox(
                    isImage: true,
                    height: displayHeight(context) * 0.15,
                    width: displayWidth(context) * 0.40,
                    color: AppColors.buttonBorderGray,
                    iconData: Icons.file_upload_outlined,
                    textColor: AppColors.titleGray,
                    subTextColor: AppColors.primary,
                    title: 'Max size: 10MB',
                    subTitle: 'Front Image',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.03,
          ),
          AppButton(
            isFill: true,
            bgColor: AppColors.primaryLight,
            borderColor: AppColors.primary,
            onTap: () {},
            label: 'Confirm',
            textStyle: AppStyles.smallTextStyleRich.copyWith(
                color: AppColors.white,
                fontSize: FontSize.fontSize16,
                fontWeight: FontWeight.w500),
            width: displayWidth(context),
            height: displayHeight(context) * 0.06,
          )
        ],
      ),
    );
  }
}
