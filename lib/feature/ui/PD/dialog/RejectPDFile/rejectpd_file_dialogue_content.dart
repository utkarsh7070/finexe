
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../../Common Widgets/common_textfield.dart';
import '../../PD Forms/pd_fromfilds.dart/view_model.dart/pendency_view_modal.dart';
import '../../common imagePicker/image_picker.dart';
import '../../pd_view_model/pd_dash_viewmodel.dart';
import '../../pd_view_model/pd_request_viewmodel.dart';

class RejectpdFileDialogueContent extends ConsumerStatefulWidget {
  final String customerId;

   RejectpdFileDialogueContent({super.key,required this.customerId});

  @override
  _RejectpdFileDialogueContentState createState() => _RejectpdFileDialogueContentState();
}

class _RejectpdFileDialogueContentState extends ConsumerState<RejectpdFileDialogueContent> {
  String rejectPDFileImageUrl= '';
  final TextEditingController rijectReasonController = TextEditingController();
  final TextEditingController remarkbypdController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    remarkbypdController.dispose();
    rijectReasonController.dispose();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final pdRequestViewModel = ref.watch(pdRejectVModelProvider);
     print('customerId in rejectPD: ${widget.customerId}');
    return  Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: rijectReasonController,
            width: displayWidth(context),
            inerHint: 'Reason of Reject',
            onValidate: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          SizedBox(height: displayHeight(context)*0.02),
          CustomTextFormField(
            controller: remarkbypdController,
            width: displayWidth(context),
            inerHint: 'Remark by Pd',
            onValidate: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          SizedBox(height: displayHeight(context)*0.02),
          CommonImagePicker(
            applicantImage: '',
            onImageUploaded: (imageUrl) {
              setState(() {
                  // salaryDetails!.items!.data.bankStatementPhoto.isNotEmpty
                  //     ? salaryDetails.items!.data.bankStatementPhoto = imageUrl
                  //     : // Update the image URL
                rejectPDFileImageUrl = imageUrl;
                print('rejectPDFileImageUrl:: $rejectPDFileImageUrl');

              });
            },
          ),
          SizedBox(height: displayHeight(context)*0.03),

          SizedBox(
            width: displayWidth(context) * 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                padding: EdgeInsets.zero,
                // backgroundColor: colors,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {

                if(rejectPDFileImageUrl.isEmpty){
                  showCustomSnackBar(context, 'Please upload image for rejecting this file', AppColors.red);
                }
                else if(_formKey.currentState!.validate()){
                  ref.read(pdRejectVModelProvider.notifier).rejectPDFormRequest(widget.customerId, rijectReasonController.text,rejectPDFileImageUrl,context,remarkbypdController.text).then(
                          (value) {
                        if(value==true){
                          ref.refresh(fetchpdRefuseandAcceptListProvider);
                          ref.refresh(fetchPdRequestListProvider);
                          ref.refresh(fetchPdRefuseCasetProvider);
                          showCustomSnackBar(context, 'Reject Request Sent Succesfully', AppColors.green);
                          Navigator.pushNamed(context, AppRoutes.pdscreen);
                        }else {
                          showCustomSnackBar(context, 'Failed to reject the form check internet connection', AppColors.red);

                        }
                      });
                  }
                // Navigator.pop(context);

              },
              child: const Text('Reject',
                  style: TextStyle(color: AppColors.white)),
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.01,
          ),
          SizedBox(
            width: displayWidth(context) * 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                // backgroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                // backgroundColor: colors,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                // reasonOfRivert.clear();
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(color: AppColors.black2)),
            ),
          ),
        ],
      ),
    );;
  }
}
