import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/api/api.dart';
import '../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../home_collection_model/user_profile_model.dart';
import '../home_collection_viewmodel/fetchUserProfile.dart';

class ProfileUpdateContent extends ConsumerWidget{
  final UserProfile userProfile;
  const ProfileUpdateContent({super.key,required this.userProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDialog = ref.watch(dialogVisibilityProvider);
    final photoState = ref.watch(profileProvider);
    final photoViewModel = ref.read(profileProvider.notifier);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        width: displayWidth(context),
        child: Padding(
            padding: const EdgeInsets.only(top: 25,left: 10,right: 10,bottom: 25),
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: userProfile.imageUrl != null
                            ? NetworkImage('${Api.imageUrl}${userProfile.imageUrl}')
                            : const AssetImage('assets/images/prof.jpeg'),
                        // Placeholder image
                        onBackgroundImageError: (error, stackTrace) {
                          // Set a default image if the API image fails to load
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          showCustomSnackBar(
                              context, 'Coming Soon!', Colors.orangeAccent);
                          // photoViewModel.updatePhoto(userProfile.employeeId);
                        },
                        child: const CircleAvatar(backgroundColor: AppColors.primaryLight2,
                          radius: 15,
                          child:Icon(Icons.camera_alt,size: 15,color: AppColors.black,)
                        ),
                      ),
                    )
                  ],

                ),
                SizedBox(height: displayHeight(context)*0.02,),
                ExpansionTile(
                  showTrailingIcon: false,
                  title:  Text('Change Password',textAlign: TextAlign.center,style: AppStyles.cardTextStyle16,),children: [
                  AppFloatTextField(
                    // controller:
                    // formListController.communicationStateController,
                    // focusNode: personalFocusViewModel
                    //     .communicationStateFocusNode,
                    // currentState: personalFocusStates[
                    // 'communicationStateFocusNode'],
                    // controller: emailController,
                    onChange: (value) {
                     photoViewModel.updatePassword(value);
                    },
                    // height: !personalFormState.isCommunicationStateValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'old Password',
                    errorText: "Required old Password",
                    // isError:
                    // !personalFormState.isCommunicationStateValid,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: displayHeight(context)*0.01,),
                  AppFloatTextField(
                    // controller:
                    // formListController.communicationStateController,
                    // focusNode: personalFocusViewModel
                    //     .communicationStateFocusNode,
                    // currentState: personalFocusStates[
                    // 'communicationStateFocusNode'],
                    // controller: emailController,
                    onChange: (value) {
                      photoViewModel
                          .updateConfirmPassword(value);
                    },
                    // height: !personalFormState.isCommunicationStateValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'New Password',
                    errorText: "Required New Password ",
                    // isError:
                    // !personalFormState.isCommunicationStateValid,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: displayHeight(context)*0.01,),
                  AppButton(
                    width: displayWidth(context),
                    onTap: () {
                      photoViewModel.changePassword(context,ref);
                  },label: 'Submit',textStyle: AppStyles.buttonLightTextStyle,)
                ],
                )
              ],
            ),
          ),
      ),
    );
  }

}