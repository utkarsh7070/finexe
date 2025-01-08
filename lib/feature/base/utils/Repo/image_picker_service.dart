import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // Private constructor
  ImagePickerService._privateConstructor();

  // The singleton instance
  static final ImagePickerService _instance =
      ImagePickerService._privateConstructor();

  // Getter to access the singleton instance
  static ImagePickerService get instance => _instance;

  // ImagePicker instance
  final ImagePicker _imagePicker = ImagePicker();

  // Method to pick an image from the gallery
  Future<XFile?> pickImageFromGallery() async {
    return await _imagePicker.pickImage(source: ImageSource.gallery);
  }

  // Method to pick an image from the camera
  Future<XFile?> pickImageFromCamera() async {
    return await _imagePicker.pickImage(source: ImageSource.camera);
  }
}
