import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider = StateNotifierProvider<ImageNotifier, List<XFile?>>((ref) {
  return ImageNotifier();
});

// class ImageNotifier extends StateNotifier<XFile?> {
//   ImageNotifier() : super(null);

//   // Function to pick an image
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     state = image;
//   }
// }
class ImageNotifier extends StateNotifier<List<XFile?>> {
  ImageNotifier() : super([null, null]);

  // Function to pick the first image
  Future<void> pickFirstImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    state = [image, state[1]];
  }

  // Function to pick the second image
  Future<void> pickSecondImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    state = [state[0], image];
  }
}
