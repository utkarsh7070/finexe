class TextFieldModel {
  String value;
  bool isValid;
  String? errorMessage;

  TextFieldModel({
    required this.value,
    this.isValid = true,
    this.errorMessage,
  });
}