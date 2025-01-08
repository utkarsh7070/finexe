import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;

import 'image_picker_service.dart';

class DocsUploader {
  static final _picker = ImagePickerService.instance;

  // final image = await imagePicker.pickImageFromGallery();

  static Future<String?> uploadImage(
      {required Dio dio,required bool isCompressed,required int compressedValue,required bool byCamera}) async {
    final pickedFile;
    if (byCamera) {
      pickedFile = await _picker.pickImageFromCamera();
    } else {
      pickedFile = await _picker.pickImageFromGallery();
    }

    if (pickedFile != null) {
      XFile? imagePath;
      if (isCompressed) {
        imagePath =
            await _compressImage(File(pickedFile.path), compressedValue);
      }

      String? token = speciality.getToken();
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
            isCompressed ? imagePath!.path : pickedFile.path),
      });
      if (kDebugMode) {
        print(imagePath?.path);
      }

      try {
        final response = await dio.post(Api.uploadImageCollection,
            data: formData, options: Options(headers: {"token": token}));
        print(' response data ${response.toString()}');
        if (response.statusCode == 200) {
          VisitUpdateUploadImageResponseModel imageResponseModel =
              VisitUpdateUploadImageResponseModel.fromJson(response.data);
          return imageResponseModel.items.image;
        }
      } catch (e) {
        rethrow;
        // ExceptionHandler().handleError(e);
      }
    }
    return null;
  }

  // compress image
  static Future<XFile?> _compressImage(File file, int qualityValue) async {
    String fileName = path.basename(file.path);
    final String targetPath = '${file.parent.path}/compressed_$fileName';
    final compressedBytes = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, // Source path
      targetPath, // Target path
      quality: qualityValue, // Compression quality (0-100)
    );
    return compressedBytes;
  }
}
