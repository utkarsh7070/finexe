import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/dialog/CustomPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendencyReject extends ConsumerStatefulWidget {
  const PendencyReject({super.key});

  @override
  ConsumerState<PendencyReject> createState() => _PendencyRejectState();
}

class _PendencyRejectState extends ConsumerState<PendencyReject> {
  TextEditingController pendencyDetailFormApproveAmount =
      TextEditingController();
  TextEditingController pendencyDetailFormFinalDecision =
      TextEditingController();
  TextEditingController pendencyDetailFormRemark = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SizedBox sizedBoxWithContext(BuildContext context, double heightFactor) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightFactor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const BeveledRectangleBorder(side: BorderSide.none),
      title: const Text("Pendency & Reject"),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Approved Amount',
                  onValidate: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: pendencyDetailFormApproveAmount,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Final Decision',
                  onValidate: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: pendencyDetailFormFinalDecision,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Remark',
                  onValidate: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: pendencyDetailFormRemark,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),
              sizedBoxWithContext(context, 0.03),
              SizedBox(
                width: displayWidth(context) * 0.9,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    CustomPopup.showPopup(
                      context: context,
                      title: 'Mark as Complete',
                      message:
                          'This will mark the entry as \n rejected. Are you sure you want to proceed?',
                      imagePath: 'assets/images/confirmComplete.png',
                      buttonName: 'Set as Pending',
                      buttonColor: Color(0xFFEE6C52),
                      rejectText: 'No, I Don\'t',
                      rejectTextColor: Colors.grey,
                      onReject: () {
                        Navigator.of(context).pop();
                        // Handle rejection logic here
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                        // Handle cancel logic here
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/right_white.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "Complete",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Or',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: displayWidth(context) * 0.42,
                    height: displayHeight(context) * 0.065,
                    child: ElevatedButton(
                      onPressed: () {
                        //Mark as Complete
                        // showCustomPopup(
                        //   context,
                        //   'Set as Pending',
                        //   'This will mark the entry as \n pending. Are you sure you want to proceed?',
                        //   'Set as pending',
                        //   'assets/images/confirmpending.png',
                        //   buttonColor: Color(0xFFFFA500),
                        //   rejectText: "No I Don't",
                        //   rejectTextColor: Colors.grey,
                        // );

                        CustomPopup.showPopup(
                          context: context,
                          title: 'Set as Pending',
                          message:
                              'This will mark the entry as \n rejected. Are you sure you want to proceed?',
                          imagePath: 'assets/images/confirmpending.png',
                          buttonName: 'Yes i Do',
                          buttonColor: Color(0xFFEE6C52),
                          rejectText: "Reject",
                          rejectTextColor: Colors.grey,
                          onReject: () {
                            Navigator.of(context).pop();
                            // Handle rejection logic here
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                            // Handle cancel logic here
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        backgroundColor: AppColors.greypink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/pendingicon.png',
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Pending",
                            // style: TextStyle(
                            //     color: Color(0xFFFFA500),
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w500),
                            style: AppStyles.yellowText16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: displayWidth(context) * 0.42,
                    height: displayHeight(context) * 0.065,
                    child: ElevatedButton(
                      onPressed: () {
                        CustomPopup.showPopup(
                          context: context,
                          title: 'Rejection Confirm',
                          message:
                              'This will mark the entry as \n rejected. Are you sure you want to proceed?',
                          imagePath: 'assets/images/confirmReject.png',
                          buttonName: 'No, I Don\'t',
                          buttonColor: Color(0xFFEE6C52),
                          rejectText: "Reject",
                          rejectTextColor: Colors.grey,
                          onReject: () {
                            Navigator.of(context).pop();
                            // Handle rejection logic here
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                            // Handle cancel logic here
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        backgroundColor: AppColors.greypink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/rejecticon.png',
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Reject",
                            style: AppStyles.redText16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  void showCustomPopup(
    BuildContext context,
    String title,
    String message,
    String buttonName,
    String imagePath, {
    Color buttonColor =
        Colors.blue, // Customizable button color with default value
    String rejectText =
        "Reject", // Customizable reject button text with default value
    Color rejectTextColor =
        Colors.red, // Customizable reject text color with default value
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomPopup(
          title: title,
          message: message,
          imagePath: imagePath,
          buttonName: buttonName,
          onReject: () {
            // Implement Reject action here
            Navigator.of(context).pop();
          },
          onCancel: () {
            // Dismiss the popup
            Navigator.of(context).pop();
          },
          buttonColor: buttonColor, // Pass custom button color
          rejectText: rejectText, // Pass custom reject button text
          rejectTextColor: rejectTextColor, // Pass custom reject text color
        );
      },
    );
  }
}
