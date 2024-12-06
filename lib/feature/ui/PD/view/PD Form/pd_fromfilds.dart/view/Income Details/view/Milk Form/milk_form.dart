import 'dart:io';

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'milkviewmodel.dart';

class MilkForm extends ConsumerStatefulWidget {
  const MilkForm({super.key});

  @override
  _MilkFormState createState() => _MilkFormState();
}

class _MilkFormState extends ConsumerState<MilkForm> {

  final TextEditingController milkForm_numberofyearesController =
  TextEditingController();
  final TextEditingController milkform_numberofcattelsController =
  TextEditingController();
  final TextEditingController milkform_milkGivingCattlesController =
  TextEditingController();
  final TextEditingController currentform_milkUtilizatinController =
  TextEditingController();
  final TextEditingController currentform_observeddesignatedController =
  TextEditingController();
  final TextEditingController currentform_milkSupplyperDayController =
  TextEditingController();
  final TextEditingController currentform_nameOfDiaryController =
  TextEditingController();
  final TextEditingController currentform_ownerMobNoController =
  TextEditingController();
  final TextEditingController currentform_milkProvideSinceyearController =
  TextEditingController();
  final TextEditingController currentform_monthlyIncomefromMilkController =
  TextEditingController();
  final TextEditingController currentform_expensesOfMilkController =
  TextEditingController();
  final TextEditingController currentform_diaryAddressController =
  TextEditingController();
  @override
  Widget build(BuildContext context) {
    final images = ref.watch(imageUploadProvider); // Watch the image list state
    final imageNotifier = ref.read(imageUploadProvider.notifier);
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextFormField(
            textInputType: TextInputType.number,

            inerHint: 'Doing from number of years',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "This field is required";
              }
              return null;
            },
            controller: milkForm_numberofyearesController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'Number of Cattles',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "This field is required";
              }
              return null;
            },
            controller: milkform_numberofcattelsController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'Number of milk giving cattles',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "This field is required";
              }
              return null;
            },
            controller: milkform_milkGivingCattlesController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'Current milk utilization',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "This field is required";
              }
              return null;
            },
            controller: currentform_milkUtilizatinController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.numberWithOptions(),
            width: displayWidth(context) * 0.8,
            inerHint: 'Observed Designated Cattle Tying Area',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "this is a required  filed";
              }
              return null;
            },
            controller: currentform_milkUtilizatinController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'Total milk Supply per fay',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "this is a required  filed";
              }
              return null;
            },
            controller: currentform_milkUtilizatinController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'Name of diary',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "this is a required  filed";
              }
              return null;
            },
            controller: currentform_milkUtilizatinController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'diary owner mob no.',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "this is a required  filed";
              }
              return null;
            },
            controller: currentform_milkUtilizatinController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'Dairy Address',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "this is a required  filed";
              }
              return null;
            },
            controller: currentform_milkUtilizatinController,
            textInputAction: TextInputAction.next,
          ),

          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'Milk provide from since year',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "this is a required  filed";
              }
              return null;
            },
            controller: currentform_milkUtilizatinController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'Monthly income milk business',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "this is a required  filed";
              }
              return null;
            },
            controller: currentform_milkUtilizatinController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          CustomTextFormField(
            textInputType: TextInputType.number,
            width: displayWidth(context) * 0.8,
            inerHint: 'Expenses of milk business',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "this is a required  filed";
              }
              return null;
            },
            controller: currentform_milkUtilizatinController,
            textInputAction: TextInputAction.next,
          ),
          constSizedbox(context),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20),
            child: Text('Animal photo with customer',textAlign: TextAlign.left,
            style: AppStyles.blackText16
            ),
          ),
          constSizedbox(context),

          // Display uploaded images
          ...images.asMap().entries.map((entry) {
            final int index = entry.key;
            final File image = entry.value;

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: FileImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -2,
                  child: GestureDetector(
                    onTap: () {
                      imageNotifier.removeImage(index); // Remove the image
                    },
                    child: Image.asset(
                      'assets/images/remove.png',
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
          // Container for uploading new images
          GestureDetector(
            onTap: () => imageNotifier.pickImage(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.upload),
                  Text('Drop your file here'),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget constSizedbox(BuildContext context) {
    return SizedBox(height: displayHeight(context) * 0.02);
  }
}
