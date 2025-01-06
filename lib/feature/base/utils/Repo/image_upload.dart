import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;



class DocsUploader {
   static final ImagePicker _picker = ImagePicker();

 static Future<String?> uploadImage(Dio dio) async {
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
   
     final imagePath = await _compressImage(File(pickedFile.path));

   
   
    

    String? token = speciality.getToken();
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath!.path),
    });
    if (kDebugMode) {
      print(imagePath.path);
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
  static  Future<XFile?> _compressImage(File file) async {
    String fileName = path.basename(file.path);
    final String targetPath = '${file.parent.path}/compressed_$fileName';
    final compressedBytes = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, // Source path
      targetPath, // Target path
      quality: 10, // Compression quality (0-100)
    );
    return compressedBytes;
  }
}
