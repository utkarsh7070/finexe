import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadNotifier extends StateNotifier<List<File>> {
  ImageUploadNotifier() : super([]);

  // Add an image to the state
  void addImage(File image) {
    state = [...state, image];
  }

  void removeImage(int index) {
    state = List.from(state)..removeAt(index); // Creates a new list without the selected image
  }

  // Pick an image from the gallery and add it to the state
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      addImage(File(pickedImage.path)); // Add the image to the state
    }
  }
}

final imageUploadProvider = StateNotifierProvider<ImageUploadNotifier, List<File>>(
      (ref) => ImageUploadNotifier(),
);
