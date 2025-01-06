
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/samagra_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../../../base/utils/widget/upload_box.dart';
import '../../../common imagePicker/file_picker.dart';
import '../../../common imagePicker/image_picker.dart';
import '../model/Submit Data Models/samagra_details_model.dart';
import '../view_model.dart/samagra_details_viewmodel.dart'; // Make sure you import this for Riverpod
final isExpSamagraDetailProvider = StateProvider<bool>((ref) => false);

class SamagraDetailsForm extends ConsumerStatefulWidget {
  // const SamagraDetailsForm({super.key});
  final String customerId;
  const SamagraDetailsForm({super.key, required this.customerId});
  @override
  _SamagraDetailsFormState createState() => _SamagraDetailsFormState();
}

class _SamagraDetailsFormState extends ConsumerState<SamagraDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _samagraFamilyIdNoController =
      TextEditingController();
  final TextEditingController _samagraIdHeadNameController =
      TextEditingController();

  // List to store family member data
  final List<Map<String, TextEditingController>> familyMembers = [
    {
      'dependedName': TextEditingController(),
      'age': TextEditingController(),
      'relation': TextEditingController(),
    }
  ];

  String sssmIDimageUrl = '';
  String gasDiaryImageUrl = '';
  String electrictyUrl = '';
  String meterPhotoUrl = '';

  // List<String> imgeUrl = [];
  @override
  void dispose() {
    _samagraFamilyIdNoController.dispose();
    _samagraIdHeadNameController.dispose();
    for (var member in familyMembers) {
      member['dependedName']?.dispose();
      member['age']?.dispose();
      member['relation']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {//isExpSamagraDetailProvider
    // final imageLoading = ref.watch(imageProvider.notifier).isLoading;
    // final pickedImage = ref.watch(imageProvider);
    final isLoading = ref.watch(samagraSubmitProvider).isLoading;
    print('gasDiaryImageUrl: $gasDiaryImageUrl');
    print('sssmIDimageUrl: $sssmIDimageUrl');
    final sssmidimage = ref.watch(sssMidimageProvider);

    final isExpanded = ref.watch(isExpSamagraDetailProvider);
    // final gasPhtotoImage = ref.watch(gasDiaryPhotoProvider);
    final getSamagraFormDetails = ref.watch(samagraDetailDetailsProvider(widget.customerId));

    // final isUploading = ref.watch(uploadImageProvider).isLoading;

    return ExpansionTile(
          title: const Text('Samagra Detail’s'),
          onExpansionChanged: (expanded) {
            ref.read(isExpSamagraDetailProvider.notifier).state = expanded;
            if (expanded) {
              // Trigger data fetch when the tile is expanded
              ref.refresh(samagraDetailDetailsProvider(widget.customerId));
            }
          },
          initiallyExpanded: isExpanded,
          children: [
            getSamagraFormDetails.when(
                data: (samagradata) {
                  if (_samagraFamilyIdNoController.text.isEmpty) {
                    _samagraFamilyIdNoController.text =
                        samagradata.items?.samagraDetail?.samagraFamilyIdNo ?? '';
                    _samagraIdHeadNameController.text =
                        samagradata.items?.samagraDetail?.samagraIdHeadName ?? '';
                    // familyMembers[index]['dependedName'] ?? samagradata
                    // Clear the current family members list to avoid duplication
                    familyMembers.clear();

                    // Populate family members list with data from the server
                    if (samagradata.items?.familyMember != null) {
                      for (var member in samagradata.items!.familyMember!) {
                        familyMembers.add({
                          'dependedName': TextEditingController(text: member.name ?? ''),
                          'age': TextEditingController(text: member.age?.toString() ?? ''),
                          'relation': TextEditingController(text: member.relation ?? ''),
                        });
                      }
                    }

                  }
                  // print(
                  //     ' samagradata.sSSMPhoto:: ${Api.baseUrl}v1${samagradata.items?.sSSMPhoto!}');
                  return  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Column(
                          children: [
                            constSizedbox(context),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 15),
                            //   child: CustomTextFormField(
                            //     textInputType: TextInputType.number,
                            //     inerHint: 'Samagra Family ID No',
                            //     onValidate: (value) {
                            //       if (value!.trim().isEmpty) {
                            //         return "Enter Samagra Family ID No";
                            //       }
                            //       return null;
                            //     },
                            //     controller: _samagraFamilyIdNoController,
                            //     textInputAction: TextInputAction.next,
                            //   ),
                            // ),
                            // constSizedbox(context),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 15),
                            //   child: CustomTextFormField(
                            //     width: displayWidth(context) * 0.8,
                            //     inerHint: 'Samagra ID Head Name',
                            //     onValidate: (value) {
                            //       if (value!.trim().isEmpty) {
                            //         return "It is a required field";
                            //       }
                            //       return null;
                            //     },
                            //     controller: _samagraIdHeadNameController,
                            //     textInputAction: TextInputAction.next,
                            //   ),
                            // ),
                            constSizedbox(context),
                            

                            const Text('sssMid Photo'),
                            CommonImagePicker(
                              applicantImage: samagradata.items?.sSSMPhoto ?? '',
                              onImageUploaded: (imageUrl) {
                                setState(() {
                                  if(samagradata.items?.sSSMPhoto !=null){
                                    samagradata.items!.sSSMPhoto!.isNotEmpty
                                        ? samagradata.items!.sSSMPhoto = imageUrl
                                        : // Update the image URL
                                    sssmIDimageUrl = imageUrl;
                                    print('sssmIDimageUrl:: $sssmIDimageUrl');
                                  }

                                });
                              },
                            ),
                            constSizedbox(context),
                            const Text('gasDiary Photo'),
                            CommonImagePicker(
                              applicantImage: samagradata.items?.gasDiaryPhoto ?? '',
                              onImageUploaded: (imageUrl) {
                                setState(() {
                                  if(samagradata.items?.gasDiaryPhoto !=null){
                                    samagradata.items!.gasDiaryPhoto!.isNotEmpty
                                        ? samagradata.items!.gasDiaryPhoto = imageUrl
                                        : // Update the image URL
                                    gasDiaryImageUrl = imageUrl;
                                    print('gasDiaryImageUrl:: $gasDiaryImageUrl');
                                  }

                                });
                              },
                            ),


                            //*****************************************************

                            // samagradata.items?.sSSMPhoto!.isEmpty &&
                            //     gasDiaryImageUrl.isEmpty
                            //     ? GestureDetector(
                            //   // onTap: () {
                            //   //   ref.read(imageProvider.notifier).pickSecondImage();
                            //   // },
                            //   onTap: () {
                            //     String? imagePathsecond;
                            //
                            //     ref
                            //         .read(gasDiaryPhotoProvider.notifier)
                            //         .pickSecondImage()
                            //         .then(
                            //           (value) {
                            //         if (value != null) {
                            //           imagePathsecond = value.path;
                            //
                            //           //  paymentViewModel.updateTransactionImage(imagePath!);
                            //
                            //           print('imagepath ${imagePathsecond}');
                            //           ref
                            //               .read(gasDiaryPhotoProvider.notifier)
                            //               .uploadImage(
                            //             value.path,
                            //           )
                            //               .then(
                            //                 (value) {
                            //               setState(() {
                            //                 gasDiaryImageUrl = value;
                            //                 // imgeUrl.add(imageApi);
                            //                 print(
                            //                     'gasDiaryImageUrl:: $gasDiaryImageUrl');
                            //                 // print(
                            //                 //     'imgeUrl length:: ${imgeUrl.length}');
                            //               });
                            //             },
                            //           );
                            //         } else {
                            //           print('elsepart');
                            //         }
                            //       },
                            //     );
                            //   },
                            //   child:
                            //   //  isUploading!
                            //   //     ? SizedBox(
                            //   //         height: displayHeight(context) * 0.16,
                            //   //         width: displayWidth(context) * 0.91,
                            //   //         child: Center(
                            //   //           child: CupertinoActivityIndicator(),
                            //   //         ))
                            //   //     :
                            //   Padding(
                            //     padding: const EdgeInsets.only(right: 15),
                            //     child: UploadBox(
                            //       isImage: true,
                            //       height: displayHeight(context) * 0.16,
                            //       width: displayWidth(context) * 0.91,
                            //       color: AppColors.buttonBorderGray,
                            //       iconData: Icons.file_upload_outlined,
                            //       textColor: AppColors.gray5,
                            //       subTextColor: AppColors.primary,
                            //       title: 'Support: JPG, PNG',
                            //       subTitle: 'Click Gas Diary Photo',
                            //     ),
                            //   ),
                            // )
                            //     : Stack(
                            //   children: [
                            //     Padding(
                            //       padding:
                            //       const EdgeInsets.only(right: 15, top: 10),
                            //       child: ClipRRect(
                            //         borderRadius: BorderRadius.circular(12),
                            //         child: gasPhtotoImage != null ||
                            //             samagradata.gasDiaryPhoto == null
                            //             ? Image.file(
                            //           File(gasPhtotoImage!.path),
                            //           height:
                            //           displayHeight(context) * 0.15,
                            //           width: displayWidth(context),
                            //           fit: BoxFit.cover,
                            //         )
                            //             : CachedNetworkImage(
                            //           imageUrl:
                            //           '${Api.baseUrl}${samagradata.gasDiaryPhoto!}',
                            //           height:
                            //           displayHeight(context) * 0.16,
                            //           width: displayWidth(context) * 0.91,
                            //           fit: BoxFit.cover,
                            //           placeholder: (context, url) =>
                            //           const Center(
                            //             child:
                            //             CircularProgressIndicator(),
                            //           ),
                            //           errorWidget:
                            //               (context, url, error) =>
                            //               Image.asset(
                            //                 'assets/images/no_internet.jpg',
                            //                 height: 56,
                            //                 width: 56,
                            //                 fit: BoxFit.cover,
                            //               ),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       right: 10,
                            //       top: 3,
                            //       child: GestureDetector(
                            //         onTap: () {
                            //           if (samagradata.gasDiaryPhoto != null ||
                            //               samagradata
                            //                   .gasDiaryPhoto!.isNotEmpty) {
                            //             setState(() {
                            //               print(
                            //                   'delete image from server gasDiaryPhoto ');
                            //               samagradata.gasDiaryPhoto =
                            //               ''; // Clear the locally stored URL if needed
                            //             });
                            //           } else {
                            //             ref
                            //                 .read(
                            //                 gasDiaryPhotoProvider.notifier)
                            //                 .removeSecondImage(); // Remove the image
                            //           }
                            //         },
                            //         child: Image.asset(
                            //           'assets/images/remove.png',
                            //           height: 25,
                            //           width: 25,
                            //           fit: BoxFit.cover,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            //*******************************************
                          constSizedbox(context),
                          constSizedbox(context),
                          const Text('Electricity Bill Photo')  ,

                            CommonFilePicker(
                              applicantFile: samagradata.items?.electricityBillPhoto ?? '',
                              onFileUploaded: (imageUrl) {
                                setState(() {
                                  if(samagradata.items?.electricityBillPhoto !=null){
                                    samagradata.items!.electricityBillPhoto!.isNotEmpty
                                        ? samagradata.items!.electricityBillPhoto = imageUrl
                                        : // Update the image URL
                                    electrictyUrl = imageUrl;
                                    print('electrictyUrl:: $electrictyUrl');
                                  }

                                });
                              },
                            ),

                            constSizedbox(context),
                            const Text('Meter Photo')  ,

                            CommonFilePicker(
                              applicantFile: samagradata.items?.meterPhoto ?? '',
                              onFileUploaded: (imageUrl) {
                                setState(() {
                                  if(samagradata.items?.meterPhoto != null){
                                    samagradata.items!.meterPhoto!.isNotEmpty
                                        ? samagradata.items!.meterPhoto = imageUrl
                                        : // Update the image URL
                                    meterPhotoUrl = imageUrl;
                                    print('meterPhotoUrl:: $meterPhotoUrl');
                                  }

                                });
                              },
                            ),

 //***************************************************Add-Memebers-************************************
                            // constSizedbox(context),
                            // constSizedbox(context),
                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text(
                            //     'Family Member',
                            //     textAlign: TextAlign.left,
                            //   ),
                            // ),
                            // constSizedbox(context),
                            // // Dynamically Add Family Member Fields
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   itemCount: familyMembers.length,
                            //   itemBuilder: (context, index) {
                            //     return Column(
                            //       children: [
                            //         SizedBox(
                            //           height: displayHeight(context) * 0.02,
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.only(right: 15),
                            //           child: CustomTextFormField(
                            //             width: displayWidth(context) * 0.8,
                            //             inerHint: 'Depended Name',
                            //             onValidate: (value) {
                            //               if (value!.trim().isEmpty) {
                            //                 return "Please Enter Depended Name";
                            //               }
                            //               return null;
                            //             },
                            //             controller: familyMembers[index]
                            //             ['dependedName']!,
                            //             textInputAction: TextInputAction.next,
                            //           ),
                            //         ),
                            //         constSizedbox(context),
                            //         Padding(
                            //           padding: const EdgeInsets.only(right: 15),
                            //           child: CustomTextFormField(
                            //             textInputType: TextInputType.number,
                            //             width: displayWidth(context) * 0.8,
                            //             inerHint: 'Age',
                            //             onValidate: (value) {
                            //               if (value!.trim().isEmpty) {
                            //                 return "Please Enter Age";
                            //               }
                            //               return null;
                            //             },
                            //             controller: familyMembers[index]['age']!,
                            //             textInputAction: TextInputAction.next,
                            //           ),
                            //         ),
                            //         constSizedbox(context),
                            //         Padding(
                            //           padding: const EdgeInsets.only(right: 15),
                            //           child: CustomTextFormField(
                            //             width: displayWidth(context) * 0.8,
                            //             inerHint: 'Relation',
                            //             onValidate: (value) {
                            //               if (value!.trim().isEmpty) {
                            //                 return "Please Enter Relation";
                            //               }
                            //               return null;
                            //             },
                            //             controller: familyMembers[index]['relation']!,
                            //             textInputAction: TextInputAction.next,
                            //           ),
                            //         ),
                            //         constSizedbox(context),
                            //         index > 0
                            //             ? Row(
                            //           mainAxisAlignment: MainAxisAlignment.end,
                            //           children: [
                            //             IconButton(
                            //               onPressed: () {
                            //                 setState(() {
                            //                   familyMembers.removeAt(index);
                            //                 });
                            //               },
                            //               icon: Icon(
                            //                   Icons.remove_circle_outline,
                            //                   color: Colors.red),
                            //             ),
                            //           ],
                            //         )
                            //             : SizedBox.shrink()
                            //       ],
                            //     );
                            //   },
                            // ),

                            // constSizedbox(context),
                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   child: ElevatedButton(
                            //       onPressed: () {
                            //         setState(() {
                            //           familyMembers.add({
                            //             'dependedName': TextEditingController(),
                            //             'age': TextEditingController(),
                            //             'relation': TextEditingController(),
                            //           });
                            //         });
                            //       },
                            //       child: Text(
                            //         'Add Member',
                            //         style: AppStyles.whiteText16,
                            //       )),
                            // ),

                             constSizedbox(context),
                            isLoading == true
                                ? const SizedBox(
                              width: 24, // Specify the width
                              height: 24, // Specify the height
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 5,
                                key: ValueKey(
                                    'loading'), // Key for progress indicator
                              ),
                            )
                                : ElevatedButton(
                                onPressed: () async {
                                  //  final pickedImages = ref.watch(imageProvider);

                                  SamagraDetail samagraDetail = SamagraDetail(
                                    samagraFamilyIdNo:
                                    _samagraFamilyIdNoController.text.trim(),
                                    samagraIdHeadName:
                                    _samagraIdHeadNameController.text.trim(),
                                  );
                                  print(
                                      'samgra: ${samagraDetail.samagraFamilyIdNo.toString()}');
                                  print(
                                      'samgraname: ${samagraDetail.samagraIdHeadName.toString()}');
                                  print(
                                      'familyMemberName:  ${familyMembers[0]['dependedName'].toString()}');
                                  print(
                                      'familyMemberAge:  ${familyMembers[0]['age'].toString()}');

                                  print(
                                      'familyMemberRelation:  ${familyMembers[0]['relation'].toString()}');

                                  // Create list of FamilyMember objects
                                  List<FamilyMember> familyMemberList =
                                  familyMembers.map((member) {
                                    return FamilyMember(
                                      name: member['dependedName']?.text.trim(),
                                      age: int.tryParse(
                                          member['age']!.text.trim()) ??
                                          0,
                                      relation: member['relation']?.text.trim(),
                                    );
                                  }).toList();
                                  // Log Family Members
                                  for (var member in familyMemberList) {
                                    print('Family Member: ${member.toJson()}');
                                  }
                                  print(
                                      'familyMemberList:: ${familyMemberList.length}');

                                  print('gasDiaryImageUrl: $gasDiaryImageUrl');
                                  print('sssmIDimageUrl: $sssmIDimageUrl');

                                  print(
                                      'samagraDetail:: ${samagraDetail.samagraFamilyIdNo}');
                                  print(
                                      'samagraIdHeadName:: ${samagraDetail.samagraIdHeadName}');
                                  await ref
                                      .read(samagraSubmitProvider.notifier)
                                      .submitSamagraDetails(
                                      customerId:  widget.customerId,
                                      pdType: 'creditPd',
                                      samagraDetail: samagraDetail,
                                      familyMembers: familyMemberList,
                                      //   imagePaths: imgeUrl,
                                      gasdiaryPhoto:
                                      gasDiaryImageUrl.isNotEmpty
                                          ? gasDiaryImageUrl
                                          : samagradata.items!.gasDiaryPhoto
                                          .toString(),
                                      electPhotot: electrictyUrl
                                          ?? samagradata.items!.electricityBillPhoto!.toString(),
                                      meterPhoto: meterPhotoUrl
                                          ??samagradata.items!.meterPhoto! .toString() ,
                                      sssmPhoto: sssmIDimageUrl.isNotEmpty
                                          ? sssmIDimageUrl
                                          : samagradata.items!.sSSMPhoto.toString(),
                                      context: context);
                                },
                                // onPressed: () => _submitForm,
                                child: Text(
                                  'Save Form',
                                  style: AppStyles.whiteText16,
                                ))
                          ],
                        ),
                      ));
                },
              loading: () => const Center(child: CircularProgressIndicator()),
              // error: (error, stackTrace) => Center(child: Text('Error: $error')),
              error: (error, stackTrace) {
                print('Error: $error');
                return const Center(child: Text('faild to get data please check network'));
              },
            )

          ],


    );
  }

  constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }
}
