import 'dart:io';

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/ui/PD/common_textfield.dart';
import 'package:finexe/feature/ui/PD/pd_fromfilds.dart/view_model.dart/samagra_details_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/utils/widget/upload_box.dart'; // Make sure you import this for Riverpod

class SamagraDetailsForm extends ConsumerStatefulWidget {
  const SamagraDetailsForm({super.key});

  @override
  _SamagraDetailsFormState createState() => _SamagraDetailsFormState();
}

class _SamagraDetailsFormState extends ConsumerState<SamagraDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _samagraform_residancetypeController =
      TextEditingController();
  TextEditingController _samagraform_headnameController =
      TextEditingController();
  TextEditingController _samagraform_dependednameController =
      TextEditingController();
  TextEditingController _samagraform_ageController = TextEditingController();
  TextEditingController _samagraform_relationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pickedImage = ref.watch(imageProvider);
    return ExpansionTile(
      title: Text('Samagra Detail’s'),
      children: [
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      textInputType: TextInputType.number,
                      inerHint: 'Samagra Family ID No',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Samagra Family ID No";
                        }
                        return null;
                      },
                      controller: _samagraform_residancetypeController,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Samagra ID Head Name',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "It is a required field";
                        }
                        return null;
                      },
                      controller: _samagraform_headnameController,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  pickedImage[0] == null
                      ? GestureDetector(
                          onTap: () {
                            ref.read(imageProvider.notifier).pickFirstImage();
                          },
                          child:
                          UploadBox(
                            isImage: true,
                            height: displayHeight(context) * 0.16,
                            width: displayWidth(context),
                            color: AppColors.buttonBorderGray,
                            iconData: Icons.file_upload_outlined,
                            textColor: AppColors.gray5,
                            subTextColor: AppColors.primary,
                            title: 'Support: JPG, PNG',
                            subTitle: 'Click SSMID Image',
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(pickedImage[0]!.path),
                              height: displayHeight(context) * 0.15,
                              width: displayWidth(context),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  constSizedbox(context),
                  pickedImage[1] == null
                      ? GestureDetector(
                          onTap: () {
                            ref.read(imageProvider.notifier).pickSecondImage();
                          },
                          child:
                          UploadBox(
                            isImage: true,
                            height: displayHeight(context) * 0.16,
                            width: displayWidth(context),
                            color: AppColors.buttonBorderGray,
                            iconData: Icons.file_upload_outlined,
                            textColor: AppColors.gray5,
                            subTextColor: AppColors.primary,
                            title: 'Support: JPG, PNG',
                            subTitle: 'Click Gas Diary Photo',
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(pickedImage[1]!.path),
                              height: displayHeight(context) * 0.15,
                              width: displayWidth(context),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  constSizedbox(context),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bill Detail’s',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Depended Name',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please Enter reason for DPD";
                        }
                        return null;
                      },
                      controller: _samagraform_dependednameController,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      textInputType: TextInputType.number,
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Age',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please Enter reason for DPD";
                        }
                        return null;
                      },
                      controller: _samagraform_ageController,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Relation',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please Enter reason for DPD";
                        }
                        return null;
                      },
                      controller: _samagraform_relationController,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Add Member',
                          style: AppStyles.whiteText16,
                        )),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: AppColors.green,
                                content: Text(
                                  'Form submitted successfully!',
                                  style: AppStyles.whiteText16,
                                )),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: AppColors.red,
                                content: Text(
                                  'Please fill all required details!',
                                  style: AppStyles.whiteText16,
                                )),
                          );
                        }
                      },
                      child: Text(
                        'Next',
                        style: AppStyles.whiteText16,
                      ))
                ],
              ),
            ))
      ],
    );
  }

  constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }
}
