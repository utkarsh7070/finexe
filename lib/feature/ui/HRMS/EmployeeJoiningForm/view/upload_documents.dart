
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/assetsImage/assets_files.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/view_model/employee_basic_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class UploadDocuments extends ConsumerWidget {
  const UploadDocuments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeDataViewModel = ref.read(employeeViewModelProvider.notifier);
    final employeeDataState = ref.watch(employeeViewModelProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload  Document'),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two columns in the grid
                        crossAxisSpacing:
                            4.0, // Horizontal spacing between items
                        mainAxisSpacing: 4.0, // Vertical spacing between items
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        String? documentFile =
                            employeeDataState.documents[index];

                        return InkWell(
                          onTap: () {
                            employeeDataViewModel
                                .addDocsMember(
                                  index,
                                );
                               
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              documentFile != '' && documentFile.isNotEmpty
                                  ? Container(
                                      padding: const EdgeInsets.all(5),
                                      height: displayHeight(context) * 0.18,
                                      width: displayHeight(context) * 0.18,
                                      decoration: const BoxDecoration(
                                          border: DashedBorder.fromBorderSide(
                                            dashLength: 10,
                                            side: BorderSide(
                                                color: Colors.black, width: 1),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.boxBagGray),
                                      child: Image.network(Api.baseUrl +
                                          employeeDataState.documents[index]))
                                  : UploadBox(
                                      isImage: true,
                                      height: displayHeight(context) * 0.18,
                                      width: displayHeight(context) * 0.18,
                                      color: AppColors.buttonBorderGray,
                                      iconData: Icons.file_upload_outlined,
                                      textColor: AppColors.titleGray,
                                      subTextColor: AppColors.textDarkGray,
                                      title:
                                          'Max size: ${employeeDataViewModel.documentsName[index].values.first}',
                                      subTitle: employeeDataViewModel
                                          .documentsName[index].keys.first,
                                    ),
                              Visibility(
                                  visible: employeeDataState.isLoading[index] ==
                                      true,
                                  child: Container(
                                       height: displayHeight(context) * 0.12,
                                      width: displayHeight(context) * 0.12,
                                    color:  AppColors.boxBagGray,
                                    child: Center(
                                        child: Lottie.asset(
                                          // fit: BoxFit.contain,
                                          height: 70,
                                        
                                      docs_loading_lottie,
                                    )),
                                  )),
                            ],
                          ),
                        );
                      }),
                  AppButton(
                    width: displayWidth(context) * 0.50,
                    label: 'Add More',
                    onTap: () {
                      employeeDataViewModel.addEmpHistory();
                    },
                  ),
                  AppButton(
                    width: displayWidth(context) * 0.50,
                    //validation is remaining
                    label: 'Next',
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.educationalDetails);
                      // employeeDataViewModel.addFamilyMember();
                    },
                  )
                ],
              )),
        ));
  }
}
