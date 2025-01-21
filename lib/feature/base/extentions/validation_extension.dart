extension ValidationExtension on String {
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(this);
  }

  bool isValidPassword() {
    final passwordRegex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegex.hasMatch(this);
  }

  bool isValidPhoneNumber() {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegex.hasMatch(this);
  }

   bool isValidString() {
    return isNotEmpty && trim().isNotEmpty;
  }

  bool isValidAadharNumber() {
    final aadharRegex = RegExp(r'^[0-9]{12}$');
    return aadharRegex.hasMatch(this);
  }

  bool isValidPanNo() {
    final panRegex = RegExp(r'^[A-Za-z]{5}[0-9]{4}[A-Za-z]$');
    return panRegex.hasMatch(this);
  }

  bool isValidUsername() {
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_-]{4,15}$');
    return usernameRegex.hasMatch(this);
  }
}