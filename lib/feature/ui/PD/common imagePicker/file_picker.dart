import 'dart:io';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';

import 'pdf_viewer.dart'; // Custom screen to preview the uploaded PDF

class CommonFilePicker extends StatefulWidget {
  final String
  applicantFile; // Current applicant file URL (response URL after uploading to the database)
  final Function(String fileUrl)
  onFileUploaded; // Callback to pass uploaded file URL

  const CommonFilePicker({
    super.key,
    required this.applicantFile,
    required this.onFileUploaded,
  });

  @override
  _CommonFilePickerState createState() => _CommonFilePickerState();
}

class _CommonFilePickerState extends State<CommonFilePicker> {
  File? _selectedFile;
  String _uploadedFileUrl = '';
  bool _isLoading = false; // Track loading state

  Future<void> pickFile() async {
    // Use file_picker to select PDF
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDF files
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _isLoading = true; // Start loading when a file is selected
        _selectedFile = File(result.files.single.path!);
        print('_selectedFile:: $_selectedFile');
      });
      await uploadFile(_selectedFile!.path);
    }
  }

  Future<void> uploadFile(String filePath) async {
    String? token = speciality.getToken();

    final dio = Dio();

    try {
      setState(() {
        _isLoading = true;
      });

      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });

      final response = await dio.post(
        Api.uploadImageCollection, // Replace with your API endpoint
        data: formData,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        final uploadedUrl = response.data['items']['image'];

        widget.onFileUploaded(uploadedUrl);
        setState(() {
          _uploadedFileUrl = uploadedUrl;
          _isLoading = false;
        });
      } else {
        showCustomSnackBar(context, 'Failed to upload file.', AppColors.red);

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showCustomSnackBar(
          context, 'Faild to upload the pdf try again', AppColors.red);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {// _uploadedFileUrl
    print(' widget.applicantFile:: ${ widget.applicantFile}');
    print(' _uploadedFileUrl::  $_uploadedFileUrl ');

    return _isLoading
        ? SizedBox(
           height: displayHeight(context) * 0.16,
           width: displayWidth(context) * 0.91,
           child: const Center(child: CircularProgressIndicator()),
        )
        : widget.applicantFile.isEmpty && _uploadedFileUrl.isEmpty
        ? GestureDetector(
         onTap: pickFile,
         child: UploadBox(
        isImage: false, // Indicating it's not an image
        height: displayHeight(context) * 0.16,
        width: displayWidth(context) * 0.91,
        color: AppColors.buttonBorderGray,
        iconData: Icons.file_upload_outlined,
        textColor: AppColors.gray5,
        subTextColor: AppColors.primary,
        title: 'Support: PDF',
        subTitle: 'Click to upload file',
              ),
            )
        : Stack(
          children: [
          Padding(
          padding: const EdgeInsets.only(right: 15, top: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PDFViewerWidget(
                //       fileUrl: _uploadedFileUrl.isEmpty
                //           ? '${Api.baseUrl}${widget.applicantFile}'
                //           : '${Api.baseUrl}${_uploadedFileUrl}',
                //     ),
                //   ),
                // );
                final pdfUrl = widget.applicantFile.isNotEmpty
                    ? '${Api.baseUrl}${widget.applicantFile}' // Prepend base URL
                    :  '${Api.baseUrl}$_uploadedFileUrl';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFViewerFromUrl(
                        pdfUrl: pdfUrl),
                  ),
                );

              },
              child: Container(
                height: displayHeight(context) * 0.16,
                width: displayWidth(context) * 0.91,
                color: AppColors.gray,
                child: const Center(
                  child: Icon(
                    Icons.picture_as_pdf,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 3,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedFile = null;
                _uploadedFileUrl = '';
              });
              widget.onFileUploaded(''); // Clear the uploaded file URL
            },
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
              child: const Center(
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
