import 'dart:io';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

import 'image_view.dart';

class CoApplicantImagePicker extends StatefulWidget {
  final String
  applicantImage; // Current applicant image URL //giving response url getting after uploading image in database
  final Function(String imageUrl)
  onImageUploaded; // Callback to pass uploaded image URL // getting url from uploadimage api
  final VoidCallback? onRemoveImage;
  const CoApplicantImagePicker({
    Key? key,
    // this.applicantImage,
    required this.applicantImage,
    required this.onImageUploaded,
    this.onRemoveImage,
  }) : super(key: key);

  @override
  _CoApplicantImagePickerState createState() => _CoApplicantImagePickerState();
}

class _CoApplicantImagePickerState extends State<CoApplicantImagePicker> {
  XFile? _selectedImage;
  String _uploadedImageUrl = '';
  bool _isLoading = false; // Track loading state

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _isLoading = true; // Start loading when image is picked
        _selectedImage = image;
      });
      await uploadImage(image.path);
    }
  }

  Future<void> uploadImage(String imagePath) async {
    String? token = speciality.getToken();

    // String token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Replace with your token logic or pass it as a parameter
    final dio = Dio();

    try {
      setState(() {
        _isLoading = true; // Stop loading on failure
        print('_isLoading true');
      });
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath,
            filename: imagePath.split('/').last),
      });

      final response = await dio.post(
        Api.uploadImageCollection, // Replace with your API endpoint
        data: formData,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        final uploadedUrl = response.data['items']['image'];

        widget.onImageUploaded(uploadedUrl);
        setState(() {
          _uploadedImageUrl = uploadedUrl;
          _isLoading = false;
        });
      } else {
        // _showSnackBar('Failed to upload image.');
        showCustomSnackBar(context, 'Failed to upload image.', AppColors.red);

        setState(() {
          _isLoading = false; // Stop loading on failure
          print('_isLoading false');
        });
      }
    } catch (e) {
      // _showSnackBar('An error occurred while uploading the image.');
      showCustomSnackBar(context,
          'An error occurred while uploading the image.', AppColors.red);

      setState(() {
        _isLoading = false; // Stop loading on failure
        print('_isLoading false');
      });
    }
  }

  // void _showSnackBar(String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    return
      _isLoading
          ? Container(
        height: displayHeight(context) * 0.16,
        width: displayWidth(context) * 0.91,

        // color: Colors.black.withOpacity(0.5),
        child: const Center(child: CircularProgressIndicator()),
      )
          :
      widget.applicantImage.isEmpty && _uploadedImageUrl.isEmpty
          ? GestureDetector(
        onTap: pickImage,
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
      )
          : Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ZoomableImageWidget(
                          ImageUrl: _uploadedImageUrl.isEmpty
                              ? '${Api.baseUrl}${widget.applicantImage}'
                              : '${Api.baseUrl}${_uploadedImageUrl}',
                        ),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: _uploadedImageUrl.isEmpty
                        ? '${Api.baseUrl}${widget.applicantImage}'
                        : '${Api.baseUrl}${_uploadedImageUrl}',
                    height: displayHeight(context) * 0.16,
                    width: displayWidth(context) * 0.91,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/no_internet.jpg',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              // ),
            ),
          ),
          Positioned(
            right: 10,
            top: 3,
            child: GestureDetector(
              // onTap: () {
              //   setState(() {
              //     _selectedImage = null;
              //     _uploadedImageUrl = '';
              //   });
              //   widget.onImageUploaded(''); // Clear the uploaded image URL
              // },
              onTap:widget. onRemoveImage,
              child: Image.asset(
                'assets/images/remove.png',
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),
            ),
        ],
      );
  }
}
