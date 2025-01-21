

import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/api/api.dart';
import '../../../../base/internetConnection/connection_overlay.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/app_style.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../style/neumorphic_convex_style.dart';
import '../view_model/hrms_profile_update_view_model.dart';


class HrmsProfileUpdateView extends ConsumerStatefulWidget {
  const HrmsProfileUpdateView({Key? key}) : super(key: key);

  @override
  _HrmsProfileUpdateViewState createState() => _HrmsProfileUpdateViewState();
}

class _HrmsProfileUpdateViewState extends ConsumerState<HrmsProfileUpdateView> {

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(hrmsLoginUserProfileProvider);

    final imageState = ref.watch(hrmsImageUploadViewModelProvider);
    final hrmsImageRequestViewModel =
        ref.read(hrmsImageUploadViewModelProvider.notifier);

    return NetworkListener(
      context: context,
      child: Scaffold(
        /*backgroundColor: AppColors.attendanceBgColor1,*/
        appBar: customAppBar(context,hrmsImageRequestViewModel),
        body: userProfileAsync.when(
            data: (userProfile) {
              return Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Visibility(
                          visible: imageState != '',
                          replacement: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            radius: 60,
                            backgroundImage: userProfile
                                        .employeePhoto.isNotEmpty &&
                                    userProfile.employeePhoto.contains('upload')
                                ? NetworkImage(
                                    '${Api.imageUrl}${userProfile.employeePhoto}')
                                : const AssetImage('assets/images/prof.jpeg')
                                    as ImageProvider,
                            onBackgroundImageError: (error, stackTrace) {
                              // Handle error, use a default image
                            },
                          ),
                          child: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            radius: 60,
                            backgroundImage:
                                NetworkImage('${Api.imageUrl}${imageState}'),
                            onBackgroundImageError: (error, stackTrace) {
                              // Handle error, use a default image
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () async {
                              // Handle edit action
                              hrmsImageRequestViewModel.clickImage();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppColors.attendanceBgColor1,
                                // Background color for the icon
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 16,
                                color: AppColors.primary, // Icon color
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    userProfile.employeName,
                    style: AppStyles.TextStyle16,
                  ),
                  Text(
                    userProfile.designationId ?? '',
                    style: AppStyles.blacktext14
                        .copyWith(color: AppColors.gray7),
                  ),

                  Image.asset('assets/images/hrms_profile_bg.png',),

                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => NoDataFound(
                  retry: true,
                  ontap: () {
                    ref.refresh(hrmsLoginUserProfileProvider);
                  },
                )),
      ),
    );
  }

  PreferredSizeWidget customAppBar(BuildContext context, HrmsImageRequestViewModel hrmsImageRequestViewModel,) {
    return PreferredSize(
      preferredSize: Size(displayWidth(context), displayHeight(context) * 0.09),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Back button on the left
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: NeumorphicWidget(
                      depth: 10,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.darkTextColor,size: 25,),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ),



              // Icons on the right
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: NeumorphicWidget(
                      depth: 10,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: AppColors.darkTextColor,size: 25,),
                        onPressed: () {
                          hrmsImageRequestViewModel.clickImage();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
