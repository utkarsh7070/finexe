import 'package:flutter/material.dart';


class CustomPopup extends StatelessWidget {
  final String title;
  final String message;
  final String imagePath;
  final String buttonName;
  final VoidCallback? onReject;
  final VoidCallback? onCancel;
  final Color buttonColor; // New parameter for button color
  final String rejectText; // New parameter for reject button text
  final Color rejectTextColor; // New parameter for reject text color


  const CustomPopup({
    Key? key,
    required this.title,
    required this.message,
    required this.imagePath,
    required this.buttonName,
    this.onReject,
    this.onCancel,
    this.buttonColor = Colors.blue, // Default button color
    this.rejectText = "Reject", // Default reject button text
    this.rejectTextColor = Colors.red, // Default reject text color
  }) : super(key: key);


  static void showPopup({
    required BuildContext context,
    required String title,
    required String message,
    required String imagePath,
    required String buttonName,
    VoidCallback? onReject,
    VoidCallback? onCancel,
    Color buttonColor = Colors.blue,
    String rejectText = "Reject",
    Color rejectTextColor = Colors.red,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: title,
          message: message,
          imagePath: imagePath,
          buttonName: buttonName,
          onReject: onReject,
          onCancel: onCancel,
          buttonColor: buttonColor,
          rejectText: rejectText,
          rejectTextColor: rejectTextColor,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 345,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Image.asset(
                imagePath,
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 345,
                child: ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    buttonName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: onReject,
                child: Text(
                  rejectText,
                  style: TextStyle(
                    color: rejectTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}