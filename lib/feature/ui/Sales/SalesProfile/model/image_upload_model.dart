

class ImageUploadModel {
  final String imageNew;

  ImageUploadModel({
    required this.imageNew,
  });

  Map<String, dynamic> toJson() {
    return {
      "employeePhoto": imageNew,
    };
  }
}