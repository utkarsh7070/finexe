
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/simple_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/widget/custom_snackbar.dart';
import '../../../common imagePicker/coapp_imagepicker.dart';
import '../model/Submit Data Models/coapplicant_model.dart';
import '../view_model.dart/co_applicant_viewmodel.dart';
final isExpCoappProvider = StateProvider<bool>((ref) => false);

class CoApplicantForm extends ConsumerStatefulWidget {
  // final CoApplicant? data;

  // const CoApplicantForm({super.key,});
  final String customerId;
  const CoApplicantForm({super.key, required this.customerId});

  @override
  _CoApplicantFormState createState() => _CoApplicantFormState();
}

class _CoApplicantFormState extends ConsumerState<CoApplicantForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController coaaplicantform1_applicantTypeController =
      TextEditingController();
  final TextEditingController coaaplicantform1_businessTypeController =
      TextEditingController();
  final TextEditingController coaaplicantform1_occupationController =
      TextEditingController();
  final TextEditingController coaaplicantform1_nationalityController =
      TextEditingController();
  final TextEditingController coaaplicantform1_religionController =
      TextEditingController();
  final TextEditingController coaaplicantform1_casteController =
      TextEditingController();
  final TextEditingController coaaplicantform1_categoryController =
      TextEditingController();
  final TextEditingController coaaplicantform1_alternateMobileController =
      TextEditingController();
  final TextEditingController coaaplicantform1_houseLandmarkController =
      TextEditingController();
  final TextEditingController coaaplicantform1_emailController =
      TextEditingController();
  final TextEditingController coaaplicantform1_educationalDetailsController =
      TextEditingController();
  final TextEditingController coaaplicantform1_dependentsController =
      TextEditingController();
  final TextEditingController coaaplicantform1_residenceTypeController =
      TextEditingController();
  //----------------------------form 02-----------------------------------------
   final TextEditingController coaaplicantform02_applicantTypeController =
      TextEditingController();
  final TextEditingController coaaplicantform02_businessTypeController =
      TextEditingController();
  final TextEditingController coaaplicantform02_occupationController =
      TextEditingController();
  final TextEditingController coaaplicantform02_nationalityController =
      TextEditingController();
  final TextEditingController coaaplicantform02_religionController =
      TextEditingController();
  final TextEditingController coaaplicantform02_casteController =
      TextEditingController();
  final TextEditingController coaaplicantform02_categoryController =
      TextEditingController();
  final TextEditingController coaaplicantform02_alternateMobileController =
      TextEditingController();
  final TextEditingController coaaplicantform02_houseLandmarkController =
      TextEditingController();
  final TextEditingController coaaplicantform02_emailController =
      TextEditingController();
  final TextEditingController coaaplicantform02_educationalDetailsController =
      TextEditingController();
  final TextEditingController coaaplicantform02_dependentsController =
      TextEditingController();
  final TextEditingController coaaplicantform02_residenceTypeController =
      TextEditingController();

  @override
  void dispose() {
    coaaplicantform1_applicantTypeController.dispose();
    coaaplicantform1_businessTypeController.dispose();
    coaaplicantform1_occupationController.dispose();
    coaaplicantform1_nationalityController.dispose();
    coaaplicantform1_religionController.dispose();
    coaaplicantform1_casteController.dispose();
    coaaplicantform1_categoryController.dispose();
    coaaplicantform1_alternateMobileController.dispose();
    coaaplicantform1_houseLandmarkController.dispose();
    coaaplicantform1_emailController.dispose();
    coaaplicantform1_educationalDetailsController.dispose();
    coaaplicantform1_dependentsController.dispose();
    coaaplicantform1_residenceTypeController.dispose();
    //***********************form-02**********************************************
    coaaplicantform02_applicantTypeController.dispose();
    coaaplicantform02_businessTypeController.dispose();
    coaaplicantform02_occupationController.dispose();
    coaaplicantform02_nationalityController.dispose();
    coaaplicantform02_religionController.dispose();
    coaaplicantform02_casteController.dispose();
    coaaplicantform02_categoryController.dispose();
    coaaplicantform02_alternateMobileController.dispose();
    coaaplicantform02_houseLandmarkController.dispose();
    coaaplicantform02_emailController.dispose();
    coaaplicantform02_educationalDetailsController.dispose();
    coaaplicantform02_dependentsController.dispose();
    coaaplicantform02_residenceTypeController.dispose();
    super.dispose();
  }

  String coApplicantImageUrl = '';
  String coApplicantImageUrl02 = '';
  @override
  Widget build(BuildContext context) {

    print('customerId in coapp:: ${widget.customerId}');
    // final coapplicantDetails = ref.watch(coApplicantDetailsProvider(0));
    // final coapplicantDetails = ref.watch(
    //   coApplicantDetailsProvider(widget.customerId),
    // );
    final coappState = ref.watch(pdCoapplicantViewModelProvider);
    final isExpanded = ref.watch(isExpCoappProvider);
    // final imageNotifier = ref.read(coAppliocantimageUploadProvider.notifier);
    final coapplicantDetails = ref.watch(
      coApplicantDetailsProvider(widget.customerId),
    );
        return
          Form(
          key: _formKey,
          child: ExpansionTile(
            onExpansionChanged: (expanded) {
              ref.read(isExpCoappProvider.notifier).state = expanded;
              if (expanded) {
                // Trigger data fetch when the tile is expanded
                print('expanded:: $expanded');
                ref.refresh(coApplicantDetailsProvider(widget.customerId));
              }
            },
            initiallyExpanded: isExpanded,
            childrenPadding: const EdgeInsets.only(left: 16, bottom: 0,right: 20),
            shape: const Border(
              bottom: BorderSide(color: AppColors.dividerColor),
            ),
            title: const Text('Co-Applicant Details'),
            children: <Widget>[
              coapplicantDetails.when(
                  data: (coapplicantData) {
                    String? coApplicantImages = '';
                    String coApplicantImage02 = '';
                    CoApplicant? coApplicantItems;
                    CoApplicant? coApplicantItems02;

                    print('Data fetched: ${coapplicantData?.toJson()}');

                    // Check if coApplicant is not null and has at least one item
                    if (coapplicantData?.items?.coApplicant != null ) {
                      print('second 1');

                      coApplicantItems = coapplicantData?.items?.coApplicant?[0] ?? CoApplicant.fromJson({}) ;

                      // Check if coApplicant has a second item
                      if ((coapplicantData?.items?.coApplicant?.length ?? 0) > 1) {
                        coApplicantItems02 = coapplicantData?.items?.coApplicant?[1];
                      }
                    }

                    // Check if coApplicantImage is not null and has at least one item
                    if (coapplicantData?.items?.coApplicantImage != null ) {
                      coApplicantImages = coapplicantData?.items?.coApplicantImage?[0] ?? '';

                      // Check if coApplicantImage has a second item
                      if ((coapplicantData?.items?.coApplicantImage?.length?? 0) > 1) {

                        coApplicantImage02 = coapplicantData?.items?.coApplicantImage?[1]?? '';

                      }
                    }

                    if (coaaplicantform1_occupationController.text.isEmpty && coApplicantItems != null) {
                      coaaplicantform1_applicantTypeController.text = coApplicantItems.coApplicantType ?? '';
                      coaaplicantform1_businessTypeController.text = coApplicantItems.businessType ?? '';
                      coaaplicantform1_occupationController.text = coApplicantItems.occupation ?? '';
                      coaaplicantform1_nationalityController.text = coApplicantItems.nationality ?? '';
                      coaaplicantform1_religionController.text = coApplicantItems.religion ?? '';
                      coaaplicantform1_casteController.text = coApplicantItems.caste ?? '';
                      coaaplicantform1_categoryController.text = coApplicantItems.category ?? '';
                      coaaplicantform1_alternateMobileController.text = coApplicantItems.alternateMobileNo ?? '';
                      coaaplicantform1_houseLandmarkController.text = coApplicantItems.houseLandMark ?? '';
                      coaaplicantform1_emailController.text = coApplicantItems.emailId ?? '';
                      coaaplicantform1_educationalDetailsController.text = coApplicantItems.educationalDetails ?? '';
                      coaaplicantform1_residenceTypeController.text = coApplicantItems.residenceType ?? '';

                      if (coApplicantItems02 != null) {
                        coaaplicantform02_applicantTypeController.text = coApplicantItems02.coApplicantType ?? '';
                        coaaplicantform02_businessTypeController.text = coApplicantItems02.businessType ?? '';
                        coaaplicantform02_occupationController.text = coApplicantItems02.occupation ?? '';
                        coaaplicantform02_nationalityController.text = coApplicantItems02.nationality ?? '';
                        coaaplicantform02_religionController.text = coApplicantItems02.religion ?? '';
                        coaaplicantform02_casteController.text = coApplicantItems02.caste ?? '';
                        coaaplicantform02_categoryController.text = coApplicantItems02.category ?? '';
                        coaaplicantform02_alternateMobileController.text = coApplicantItems02.alternateMobileNo ?? '';
                        coaaplicantform02_houseLandmarkController.text = coApplicantItems02.houseLandMark ?? '';
                        coaaplicantform02_emailController.text = coApplicantItems02.emailId ?? '';
                        coaaplicantform02_educationalDetailsController.text = coApplicantItems02.educationalDetails ?? '';
                        coaaplicantform02_residenceTypeController.text = coApplicantItems02.residenceType ?? '';
                      }
                    }
                    print('coApplicantImage: $coApplicantImages');
                    print('coApplicantImage02: $coApplicantImage02');
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'CoAppliocant Form 01',
                            textAlign: TextAlign.left,
                            style: AppStyles.blackText16,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Personal Information',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        constSizedbox(context),

                        const Text(
                          'CoApplicant Image',
                          // textAlign: TextAlign.left,
                        ),
                        // coapplicantData.coApplicantImage==null ?
                        CoApplicantImagePicker(
                          applicantImage: coApplicantImages ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                               if(coApplicantImages !=null){
                                 coApplicantImages!.isNotEmpty
                                     ? coApplicantImages = imageUrl
                                     : // Update the image URL
                                 coApplicantImageUrl = imageUrl;
                                 print('coApplicantImageUrl 01:: $coApplicantImageUrl');
                               }

                            });
                          },
                          onRemoveImage: () {
                            setState(() {

                              if(coApplicantImages !=null){
                                // coApplicantImages = ''; // Clear the image
                                coApplicantImages= coApplicantImageUrl;
                                coApplicantImageUrl='';
                                print('Image removed for CoApplicant 01: $coApplicantImageUrl');
                              }

                            });
                          },
                        ),
                        // ...coapplicantData.coApplicantImage!.asMap().entries.map((entry) {
                        //   final int index = entry.key;
                        //   final String image = entry.value;
                        //   print(
                        //       'fourBoundaryPhotos from server:: ${coapplicantData.coApplicantImage!.length}');
                        //   print('image:: $image');
                        //   return Column(
                        //     children: [
                        //       constSizedbox(context),
                        //       // if(index==0)
                        //       //   Text(''),
                        //       // if(index==1)
                        //       //   Text('West'),
                        //       // if(index==2)
                        //       //   Text('North'),
                        //       // if(index==3)
                        //       //   Text('Siuth'),
                        //       Stack(
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.only(right: 15, top: 12),
                        //
                        //             child: ClipRRect(
                        //               borderRadius: BorderRadius.circular(12),
                        //
                        //               child: CachedNetworkImage(
                        //                 imageUrl:
                        //                 //  workPhotosList.length == 0
                        //                 //     ? '${Api.baseUrl}${agriAndWorkImages.workPhotos![index]}':
                        //                 '${Api.baseUrl}${image}',
                        //                 height: displayHeight(context) * 0.16,
                        //                 width: displayWidth(context) * 0.91,
                        //                 fit: BoxFit.contain,
                        //                 placeholder: (context, url) =>
                        //                     Center(child: CircularProgressIndicator()),
                        //                 errorWidget: (context, url, error) => Image.asset(
                        //                   'assets/images/no_internet.jpg',
                        //                   height: 150,
                        //                   width: double.infinity,
                        //                   fit: BoxFit.contain,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           Positioned(
                        //             right: 10,
                        //             top: 0,
                        //             child: GestureDetector(
                        //               onTap: () {
                        //                 setState(() {
                        //                   coapplicantData.coApplicantImage?.removeAt(index);
                        //                   print(
                        //                       'coApplicantImage:: ${coapplicantData.coApplicantImage?.length}');
                        //                 });
                        //               },
                        //               child: Image.asset(
                        //                 'assets/images/remove.png',
                        //                 height: 25,
                        //                 width: 25,
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   );
                        // }).toList(),
                        // constSizedbox(context),
                        // coapplicantData.coApplicantImage!.length > 0 ?
                        // SizedBox.shrink():
                        // GestureDetector(
                        //   // onTap: () => imageNotifier.pickImage(),
                        //   onTap: () {
                        //     imageNotifier.pickImage().then(
                        //           (value) {
                        //         imageNotifier.uploadImage(value).then(
                        //               (value) {
                        //             setState(() {
                        //               // print('workphotoUrl: $value');
                        //               // workPhotosList.add(value);
                        //               print('coApplicant ImageUrl :: $value');
                        //               coapplicantData.coApplicantImage?.add(value);
                        //               coApplicantImageUrl=value;
                        //               print('coApplicantImageUrl:: $coApplicantImageUrl');
                        //               // print(
                        //               //     'workPhotosList url length:: ${workPhotosList.length}');
                        //               print(
                        //                   'coApplicantImage:: ${coapplicantData.coApplicantImage?.length}');
                        //             });
                        //           },
                        //         );
                        //       },
                        //     );
                        //   },
                        //   child:  Padding(
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
                        //       subTitle: 'Click Image',
                        //     ),
                        //   ),
                        // ),
                        constSizedbox(context),

                        CustomDropDownTextField(
                          labelText: 'Applicant Type',
                          controller: coaaplicantform1_applicantTypeController,
                          items: const [
                            DropDownValueModel(name: "Individual", value: "Individual"),
                            DropDownValueModel(
                                name: "Non Individual", value: "Non Individual"),
                          ],
                        ),
                        constSizedbox(context),

                        // Business Type

                        CustomDropDownTextField(
                          labelText: 'Business Type',
                          controller: coaaplicantform1_businessTypeController,
                          items: const [
                            DropDownValueModel(
                                name: "Self Employed Proffessional",
                                value: "Self Employed Proffessional"),
                            DropDownValueModel(
                                name: "Self Emplyed Non Proffessional",
                                value: "Self Emplyed Non Proffessional"),
                            DropDownValueModel(
                                name: "Agriculture Business",
                                value: "Agriculture Business"),
                            DropDownValueModel(name: "House Wife", value: "House Wife"),
                            DropDownValueModel(name: "Retired", value: "Retired"),
                            DropDownValueModel(name: "Salaried", value: "Salaried"),
                            DropDownValueModel(name: "Other", value: "Other"),
                          ],
                        ),
                        constSizedbox(context),

                        CustomTextFormField(
                          controller: coaaplicantform1_occupationController,
                          width: displayWidth(context),
                          inerHint: 'Occupation',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Occupation is required';
                            }
                            return null;
                          },
                        ),

                        constSizedbox(context),

                        // Nationality and Religion in a row
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: CustomTextFormField(
                                  controller: coaaplicantform1_nationalityController,
                                  inerHint: 'Nationality',
                                  onValidate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nationality is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child:  Padding(
                                padding: const EdgeInsets.only(right: 20),

                                child: CustomTextFormField(
                                  controller: coaaplicantform1_religionController,
                                  inerHint: 'Religion',
                                  onValidate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Religion is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        constSizedbox(context),

                        // Caste and Category in a row
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: CustomTextFormField(
                                  controller: coaaplicantform1_casteController,
                                  width: displayWidth(context) * 0.4,
                                  inerHint: 'Caste',
                                  onValidate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Caste is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),

                                child: CustomTextFormField(
                                  controller: coaaplicantform1_categoryController,
                                  width: displayWidth(context) * 0.4,
                                  inerHint: 'Category',
                                  onValidate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Category is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        constSizedbox(context),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Contact Information',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        constSizedbox(context),

                        // House Landmark
                        CustomTextFormField(
                          controller: coaaplicantform1_houseLandmarkController,
                          width: displayWidth(context),
                          inerHint: 'House Landmark',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'House Landmark is required';
                            }
                            return null;
                          },
                        ),
                        constSizedbox(context),

                        // Alternate Mobile No
                        CustomTextFormField(
                          length: 10,
                          textInputType: TextInputType.number,
                          controller: coaaplicantform1_alternateMobileController,
                          width: displayWidth(context),
                          inerHint: 'Alternate Mobile No',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Alternate Mobile No is required';
                            }else if(value.length<10){
                              return 'Mobile Number Must Be Exactly 10 Numeric Digits';
                            }
                            if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                        ),

                        constSizedbox(context),

                        // Residence Type
                        CustomDropDownTextField(
                          labelText: 'Residence Type',
                          controller: coaaplicantform1_residenceTypeController,
                          items: const [
                            DropDownValueModel(name: "Owned", value: "Owned"),
                            DropDownValueModel(name: "Rented", value: "Rented"),
                            DropDownValueModel(name: "Leased", value: "Leased"),
                          ],
                        ),
                        constSizedbox(context),
                        //*****************************************coApplicant-Form-02***************
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'CoAppliocant Form 02',
                            textAlign: TextAlign.left,
                            style: AppStyles.blackText16,
                          ),
                        ),
                        // constSizedbox(context),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Personal Information',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        constSizedbox(context),

                        const Text(
                          'CoApplicant Image',
                          // textAlign: TextAlign.left,
                        ),

                        CoApplicantImagePicker(
                          applicantImage: coApplicantImage02 ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              coApplicantImage02.isNotEmpty
                                  ? coApplicantImages = imageUrl
                                  : // Update the image URL
                              coApplicantImageUrl02 = imageUrl;
                              print('coApplicantImageUrl02:: $coApplicantImageUrl02');
                            });
                          },
                          onRemoveImage: () {
                            // setState(() {
                              if(coApplicantImage02.isNotEmpty){
                                coApplicantImage02 = ''; // Clear the image
                                // coApplicantImage02= coApplicantImageUrl02;
                                // coApplicantImageUrl02='';
                                print('Image removed for CoApplicant 02: $coApplicantImageUrl02');
                              }

                            // });
                          },
                        ),


                        constSizedbox(context),

                        CustomDropDownTextField(
                          labelText: 'Applicant Type',
                          controller: coaaplicantform02_applicantTypeController,
                          items: const [
                            DropDownValueModel(name: "Individual", value: "Individual"),
                            DropDownValueModel(
                                name: "Non Individual", value: "Non Individual"),
                          ],
                        ),
                        constSizedbox(context),

                        // Business Type

                        CustomDropDownTextField(
                          labelText: 'Business Type',
                          controller: coaaplicantform02_businessTypeController,
                          items: const [
                            DropDownValueModel(
                                name: "Self Employed Proffessional",
                                value: "Self Employed Proffessional"),
                            DropDownValueModel(
                                name: "Self Emplyed Non Proffessional",
                                value: "Self Emplyed Non Proffessional"),
                            DropDownValueModel(
                                name: "Agriculture Business",
                                value: "Agriculture Business"),
                            DropDownValueModel(name: "House Wife", value: "House Wife"),
                            DropDownValueModel(name: "Retired", value: "Retired"),
                            DropDownValueModel(name: "Salaried", value: "Salaried"),
                            DropDownValueModel(name: "Other", value: "Other"),
                          ],
                        ),
                        constSizedbox(context),

                        CustomTextFormField(
                          controller: coaaplicantform02_occupationController,
                          width: displayWidth(context),
                          inerHint: 'Occupation',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Occupation is required';
                            }
                            return null;
                          },
                        ),

                        constSizedbox(context),

                        // Nationality and Religion in a row
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),

                                child: CustomTextFormField(
                                  controller: coaaplicantform02_nationalityController,
                                  inerHint: 'Nationality',
                                  onValidate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nationality is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child:  Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: CustomTextFormField(
                                  controller: coaaplicantform02_religionController,
                                  inerHint: 'Religion',
                                  onValidate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Religion is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        constSizedbox(context),

                        // Caste and Category in a row
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),

                                child: CustomTextFormField(
                                  controller: coaaplicantform02_casteController,
                                  width: displayWidth(context) * 0.4,
                                  inerHint: 'Caste',
                                  onValidate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Caste is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),

                                child: CustomTextFormField(
                                  controller: coaaplicantform02_categoryController,
                                  width: displayWidth(context) * 0.4,
                                  inerHint: 'Category',
                                  onValidate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Category is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        constSizedbox(context),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Contact Information',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        constSizedbox(context),

                        // House Landmark
                        CustomTextFormField(
                          controller: coaaplicantform02_houseLandmarkController,
                          width: displayWidth(context),
                          inerHint: 'House Landmark',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'House Landmark is required';
                            }
                            return null;
                          },
                        ),
                        constSizedbox(context),

                        // Alternate Mobile No
                        CustomTextFormField(
                          length: 10,
                          textInputType: TextInputType.number,
                          controller: coaaplicantform02_alternateMobileController,
                          width: displayWidth(context),
                          inerHint: 'Alternate Mobile No',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Alternate Mobile No is required';
                            }else if(value.length<10){
                              return 'Mobile Number Must Be Exactly 10 Numeric Digits';
                            }
                            if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                        ),

                        constSizedbox(context),

                        // Residence Type
                        CustomDropDownTextField(
                          labelText: 'Residence Type',
                          controller: coaaplicantform02_residenceTypeController,
                          items: const [
                            DropDownValueModel(name: "Owned", value: "Owned"),
                            DropDownValueModel(name: "Rented", value: "Rented"),
                            DropDownValueModel(name: "Leased", value: "Leased"),
                          ],
                        ),
                        constSizedbox(context),

                        ElevatedButton(
                          onPressed: () {
                            final coapplicantFirstFormdata = CoApplicant(
                              coApplicantType:
                              coaaplicantform1_applicantTypeController.text,
                              businessType: coaaplicantform1_businessTypeController.text,
                              occupation: coaaplicantform1_occupationController.text,
                              // dOB: coaaplicantform02_dob,
                              // emailId: email,
                              houseLandMark:
                              coaaplicantform1_houseLandmarkController.text,
                              alternateMobileNo:
                              coaaplicantform1_alternateMobileController.text,
                              // noOfyearsAtCurrentAddress:  coaaplicantform02.text,
                              // gender:  coaaplicantform02_.text,
                              religion: coaaplicantform1_religionController.text,
                              nationality: coaaplicantform1_nationalityController.text,
                              category: coaaplicantform1_categoryController.text,
                              caste: coaaplicantform1_casteController.text,
                              // maritalStatus:  coaaplicantform02_m.text,
                              educationalDetails:
                              coaaplicantform1_educationalDetailsController.text,
                              residenceType:
                              coaaplicantform1_residenceTypeController.text,
                            );
                            final coapplicantSecondFormdata02 = CoApplicant(
                              coApplicantType:
                              coaaplicantform02_applicantTypeController.text,
                              businessType: coaaplicantform02_businessTypeController.text,
                              occupation: coaaplicantform02_occupationController.text,
                              // dOB: coaaplicantform02_dob,
                              // emailId: email,
                              houseLandMark:
                              coaaplicantform02_houseLandmarkController.text,
                              alternateMobileNo:
                              coaaplicantform02_alternateMobileController.text,
                              // noOfyearsAtCurrentAddress:  coaaplicantform02.text,
                              // gender:  coaaplicantform02_.text,
                              religion: coaaplicantform02_religionController.text,
                              nationality: coaaplicantform02_nationalityController.text,
                              category: coaaplicantform02_categoryController.text,
                              caste: coaaplicantform02_casteController.text,
                              // maritalStatus:  coaaplicantform02_m.text,
                              educationalDetails:
                              coaaplicantform02_educationalDetailsController.text,
                              residenceType:
                              coaaplicantform02_residenceTypeController.text,
                            );
                            // if (_formKey.currentState!.validate()) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       backgroundColor: AppColors.green,
                            //       content: Text(
                            //         'Form submitted successfully!',
                            //         style: AppStyles.whiteText16,
                            //       ),
                            //     ),
                            //   );
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       backgroundColor: AppColors.red,
                            //       content: Text(
                            //         'Please fill all required details!',
                            //         style: AppStyles.whiteText16,
                            //       ),
                            //     ),
                            //   );
                            // }
                            ref
                                .read(pdCoapplicantViewModelProvider.notifier)
                                .submitpdCoApplicantForm(
                                context:  context,
                                customerId:  widget.customerId,
                                pdType: 'creditPd',
                                // coApplicant: coapplicantSecondFormdata,
                                // coApplicatFirstData: coapplicantFirstFormdata,
                                coApplicantUsers: [
                                  coapplicantFirstFormdata,
                                  coapplicantSecondFormdata02
                                ],
                                coapplicantImages: [
                                  // coApplicantImages.isNotEmpty? coApplicantImages:coApplicantImageUrl.isNotEmpty? coApplicantImageUrl? ''

                                  coApplicantImageUrl.isNotEmpty
                                      ? coApplicantImageUrl
                                      : (coApplicantImages!.isNotEmpty
                                      ? coApplicantImages
                                      : ''),
                                  coApplicantImageUrl02.isNotEmpty
                                      ? coApplicantImageUrl02
                                      : (coApplicantImage02.isNotEmpty
                                      ? coApplicantImage02
                                      : ''),
                                  // coApplicantImageUrl.isNotEmpty
                                  //     ? coApplicantImageUrl: '',


                                ]
                              // coapplicantImages: coapplicantData.coApplicantImage ?? ['','']
                            ).then(
                                  (value) {
                                if (value) {
                                  showCustomSnackBar(
                                      context,'Form Saved successfully!', Colors.green);
                                }

                              },
                            );
                          },
                          child: coappState.isLoading == true
                              ? const SizedBox(
                            width: 24, // Specify the width
                            height: 24, // Specify the height
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 3,
                              key:
                              ValueKey('loading'), // Key for progress indicator
                            ),
                          )
                              : const Text(
                            'Save Form',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text('Error: $error')),
              )


            ],
          ),
        );

      // loading: () => const Center(child: CircularProgressIndicator()),


  }
}

Widget constSizedbox(BuildContext context) {
  return SizedBox(height: displayHeight(context) * 0.03);
}
