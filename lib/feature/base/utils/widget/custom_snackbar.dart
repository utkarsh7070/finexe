import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Color snackColor;

  const CustomSnackBar(
      {Key? key, required this.message, required this.snackColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          // color: Color.fromARGB(255, 88, 216, 29).withOpacity(0.8),
          color: snackColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

void showCustomSnackBar(
    BuildContext context, String message, Color snackcolor) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top:
          MediaQuery.of(context).padding.top + 10, // Top position with a margin
      left: 10,
      right: 10,
      child: CustomSnackBar(
        message: message,
        snackColor: snackcolor,
      ),
    ),
  );

  // Insert the overlay entry
  overlay?.insert(overlayEntry);

  // Remove the overlay after a duration
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}



// Global key to access ScaffoldMessenger from anywhere in the app

// class CustomSnackBar2 {
//   // Method to show the SnackBar without needing context as a parameter
//   static void show(String message,{Color snackColor = Colors.black87}) {
//     // Use the global ScaffoldMessengerKey to show the SnackBar
//     scaffoldMessengerKey.currentContext(
     
//       SnackBar(
        
//         content: Text(message),
//         backgroundColor: snackColor,
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }

