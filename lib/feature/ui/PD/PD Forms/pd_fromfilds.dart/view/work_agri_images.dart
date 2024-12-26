import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/work_agri_v_model.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/image_picker.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/video_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/widget/upload_box.dart';
import '../../../common imagePicker/image_picker.dart';
import '../../../common imagePicker/video_picker.dart';
import '../view_model.dart/work_agri_v_model.dart';
final isExpWorkAgriDetailProvider = StateProvider<bool>((ref) => false);

class WorkAndAgriCultureImages extends ConsumerStatefulWidget {
  // const WorkAndAgriCultureImages({super.key});
  final String customerId;
  WorkAndAgriCultureImages({required this.customerId});
  @override
  ConsumerState<WorkAndAgriCultureImages> createState() =>
      _WorkAndAgriCultureImagesState();
}

class _WorkAndAgriCultureImagesState
    extends ConsumerState<WorkAndAgriCultureImages> {
  String eastImageUrl = '';
  String westImageUrl = '';
  String northImageUrl = '';
  String southImageUrl = '';
  String landmarkImageUrl = '';
  String latLongImageUrl = '';
  String videoUrl = '';
  List<String> workPhotosList = [];
  @override
  Widget build(BuildContext context) {
    print('workPhotosList:: ${workPhotosList.length}');
    // final images = ref.watch(workagriimageUploadProvider);
    final appState = ref.watch(pdsubmitWorkAndAgriImages);

    final _isExpanded = ref.watch(isExpWorkAgriDetailProvider);
    final getAgriFormData = ref.watch(getWorkAndImagesProvider(widget.customerId));
    final imageNotifier = ref.read(workagriimageUploadProvider.notifier);

    return  ExpansionTile(
          title: Text('Work and Agriculture Images'),
          onExpansionChanged: (expanded) {
            ref.read(isExpWorkAgriDetailProvider.notifier).state = expanded;
            if (expanded) {
              // Trigger data fetch when the tile is expanded
              ref.refresh(getWorkAndImagesProvider(widget.customerId));
            }
          },
          initiallyExpanded: _isExpanded,
          children: [
            getAgriFormData.when(
                data: (agriAndWorkImages) {
                  print(
                      'agriAndWorkImages.videoUpload :: ${agriAndWorkImages.videoUpload}');
                  return  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      children: [

                        constSizedbox(context),
                        Text('Landmark Photo'),
                        CommonImagePicker(
                          applicantImage: agriAndWorkImages.landmarkPhoto ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              agriAndWorkImages.landmarkPhoto!.isNotEmpty
                                  ? agriAndWorkImages.landmarkPhoto = imageUrl
                                  : // Update the image URL
                              landmarkImageUrl = imageUrl;
                              print('landmarkImageUrl:: $landmarkImageUrl');
                            });
                          },
                        ),
                        constSizedbox(context),
                        Text('Lat Long Photo'),
                        CommonImagePicker(
                          applicantImage: agriAndWorkImages.latLongPhoto ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              agriAndWorkImages.latLongPhoto!.isNotEmpty
                                  ? agriAndWorkImages.latLongPhoto = imageUrl
                                  : // Update the image URL
                              latLongImageUrl = imageUrl;
                              print('latLongImageUrl:: $latLongImageUrl');
                            });
                          },
                        ),
                        constSizedbox(context),
                        Text(
                          'Four Boundary Photos (East, West, North, South)',
                          style: AppStyles.blackText16,
                        ),
                        constSizedbox(context),
                        Text('East Boundary'),
                        if (agriAndWorkImages.fourBoundaryPhotos != null &&
                            agriAndWorkImages.fourBoundaryPhotos!.length > 0)
                          if (agriAndWorkImages.fourBoundaryPhotos![0] != null)
                            CommonImagePicker(
                              applicantImage:
                              agriAndWorkImages.fourBoundaryPhotos![0],
                              onImageUploaded: (imageUrl) {
                                setState(() {
                                  agriAndWorkImages.fourBoundaryPhotos![0].isNotEmpty
                                      ? agriAndWorkImages.fourBoundaryPhotos![0] =
                                      imageUrl
                                      : // Update the image URL
                                  eastImageUrl = imageUrl;
                                  print('eastImageUrl:: $eastImageUrl');
                                });
                              },
                            ),
                        constSizedbox(context),
                        Text('West Boundary'),
                        if (agriAndWorkImages.fourBoundaryPhotos != null &&
                            agriAndWorkImages.fourBoundaryPhotos!.length > 1)
                          CommonImagePicker(
                            applicantImage: agriAndWorkImages.fourBoundaryPhotos![1],
                            onImageUploaded: (imageUrl) {
                              setState(() {
                                agriAndWorkImages.fourBoundaryPhotos![1].isNotEmpty
                                    ? agriAndWorkImages.fourBoundaryPhotos![1] =
                                    imageUrl
                                    : // Update the image URL
                                westImageUrl = imageUrl;
                                print('westImageUrl:: $westImageUrl');
                              });
                            },
                          ),
                        constSizedbox(context),
                        Text('North Boundary'),
                        if (agriAndWorkImages.fourBoundaryPhotos != null &&
                            agriAndWorkImages.fourBoundaryPhotos!.length > 2)
                          CommonImagePicker(
                            applicantImage: agriAndWorkImages.fourBoundaryPhotos![2],
                            onImageUploaded: (imageUrl) {
                              setState(() {
                                agriAndWorkImages.fourBoundaryPhotos![2].isNotEmpty
                                    ? agriAndWorkImages.fourBoundaryPhotos![2] =
                                    imageUrl
                                    : // Update the image URL
                                northImageUrl = imageUrl;
                                print('northImageUrl:: $northImageUrl');
                              });
                            },
                          ),
                        constSizedbox(context),
                        Text('South Boundary'),
                        if (agriAndWorkImages.fourBoundaryPhotos != null &&
                            agriAndWorkImages.fourBoundaryPhotos!.length > 3)
                          CommonImagePicker(
                            applicantImage: agriAndWorkImages.fourBoundaryPhotos![3],
                            onImageUploaded: (imageUrl) {
                              setState(() {
                                agriAndWorkImages.fourBoundaryPhotos![3].isNotEmpty
                                    ? agriAndWorkImages.fourBoundaryPhotos![3] =
                                    imageUrl
                                    : // Update the image URL
                                southImageUrl = imageUrl;
                                print('southImageUrl:: $southImageUrl');
                              });
                            },
                          ),
                        constSizedbox(context),
                        Text('Work Photos'),
                        // if(agriAndWorkImages.workPhotos!=null)
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   // itemCount: workPhotosList.length,
                        //   itemCount: agriAndWorkImages.workPhotos!.length,
                        //   itemBuilder: (context, index) {
                        //     return
                        //     //  CommonImagePicker(
                        //     //   applicantImage: '',
                        //     //   onImageUploaded: (imageUrl) {
                        //     //     setState(() {
                        //     //       // agriAndWorkImages.fourBoundaryPhotos![3].isNotEmpty
                        //     //       //     ? agriAndWorkImages.fourBoundaryPhotos![3] =
                        //     //       //         imageUrl
                        //     //       // : // Update the image URL
                        //     //       southImageUrl = imageUrl;
                        //     //       workPhotosList.add(imageUrl);
                        //     //       print('workPhotosList:: ${workPhotosList.length}');
                        //     //       print('southImageUrl:: $southImageUrl');
                        //     //     });
                        //     //   },
                        //     // );

                        //   },
                        // ),

                        ...agriAndWorkImages.workPhotos!.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final String image = entry.value;
                          print(
                              'workPhotosList from server:: ${agriAndWorkImages.workPhotos!.length}');
                          print('image:: $image');
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15, top: 12),

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),

                                  child: CachedNetworkImage(
                                    imageUrl:
                                    //  workPhotosList.length == 0
                                    //     ? '${Api.baseUrl}${agriAndWorkImages.workPhotos![index]}':
                                    '${Api.baseUrl}${image}',
                                    height: displayHeight(context) * 0.16,
                                    width: displayWidth(context) * 0.91,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Image.asset(
                                      'assets/images/no_internet.jpg',
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      agriAndWorkImages.workPhotos!.removeAt(index);
                                      print(
                                          'workPhotosList:: ${agriAndWorkImages.workPhotos!.length}');
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/images/remove.png',
                                    height: 25,
                                    width: 25,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),




                        constSizedbox(context),
                        GestureDetector(
                          // onTap: () => imageNotifier.pickImage(),
                          onTap: () {
                            imageNotifier.pickImage().then(
                                  (value) {
                                imageNotifier.uploadImage(value).then(
                                      (value) {
                                    setState(() {
                                      // print('workphotoUrl: $value');
                                      // workPhotosList.add(value);
                                      agriAndWorkImages.workPhotos?.add(value);
                                      // print(
                                      //     'workPhotosList url length:: ${workPhotosList.length}');
                                      print(
                                          'workPhotosList:: ${agriAndWorkImages.workPhotos?.length}');
                                    });
                                  },
                                );
                              },
                            );
                          },
                          // child: Container(
                          //   height: MediaQuery.of(context).size.height * 0.2,
                          //   width: MediaQuery.of(context).size.width * 0.8,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(12),
                          //     border: Border.all(
                          //       color: Colors.grey,
                          //       width: 1,
                          //     ),
                          //   ),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: const [
                          //       Icon(Icons.upload),
                          //       Text('Drop your file here'),
                          //     ],
                          //   ),
                          // ),
                          child:  Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: UploadBox(
                              isImage: true,
                              height: displayHeight(context) * 0.16,
                              width: displayWidth(context) * 0.91,
                              color: AppColors.buttonBorderGray,
                              iconData: Icons.file_upload_outlined,
                              textColor: AppColors.gray5,
                              subTextColor: AppColors.primary,
                              title: 'Support: JPG, PNG',
                              subTitle: 'Click Image',
                            ),
                          ),
                        ),
                        constSizedbox(context),
                        Text('Upload 360° Home Video'),
                        CommonVideoPicker(
                          gettingVideoUrlFromServer:
                          agriAndWorkImages.videoUpload ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              agriAndWorkImages.videoUpload!.isNotEmpty
                                  ? agriAndWorkImages.videoUpload = imageUrl
                                  : // Update the image URL
                              videoUrl = imageUrl;
                              print('videoUrl:: $videoUrl');
                            });
                          },
                        ),
                        constSizedbox(context),
                        ElevatedButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //         backgroundColor: AppColors.green,
                            //         content: Text(
                            //           'Form submitted successfully!',
                            //           style: AppStyles.whiteText16,
                            //         )),
                            //   );
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //         backgroundColor: AppColors.red,
                            //         content: Text(
                            //           'Please fill all requred details!',
                            //           style: AppStyles.whiteText16,
                            //         )),
                            //   );
                            // }
                            ref
                                .read(pdsubmitWorkAndAgriImages.notifier)
                                .submitpdBankDetailsForm(
                                customerId: widget.customerId,
                                pdType: 'creditPd',
                                eastBoundaryImage: eastImageUrl ??
                                    agriAndWorkImages.fourBoundaryPhotos![0]
                                        .toString(),
                                westBoundaryImage: westImageUrl ??
                                    agriAndWorkImages.fourBoundaryPhotos![1]
                                        .toString(),
                                northBoundaryImage: northImageUrl ??
                                    agriAndWorkImages.fourBoundaryPhotos![2]
                                        .toString(),
                                southBoundaryImage: southImageUrl ??
                                    agriAndWorkImages.fourBoundaryPhotos![3]
                                        .toString(),
                                landmarkImageUrl: landmarkImageUrl ??
                                    agriAndWorkImages.landmarkPhoto,
                                latlongImageUrl: latLongImageUrl ??
                                    agriAndWorkImages.latLongPhoto,
                                videourl:
                                videoUrl ?? agriAndWorkImages.videoUpload,
                                // workPhoto: workPhotosList.isEmpty
                                //     ? agriAndWorkImages
                                //         .workPhotos //workPhotosList
                                //     : workPhotosList
                                workPhoto: agriAndWorkImages.workPhotos)
                                .then(
                                  (value) {
                                if (value) {
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
                                          'Faild to submit the form please try again.',
                                          style: AppStyles.whiteText16,
                                        )),
                                  );
                                }
                              },
                            );
                          },
                          child: appState.isLoading == true
                              ? const SizedBox(
                            width: 24, // Specify the width
                            height: 24, // Specify the height
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 3,
                              key: ValueKey(
                                  'loading'), // Key for progress indicator
                            ),
                          )
                              : Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  );
                },
              loading: () => const Center(child: CircularProgressIndicator()),
              // error: (error, stackTrace) => Center(child: Text('Error: $error')),
              error: (error, stackTrace) {
                print('Error: $error');
                return Center(child: Text('faild to get data please check network'));
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
