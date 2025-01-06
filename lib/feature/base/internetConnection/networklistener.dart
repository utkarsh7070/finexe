import 'dart:ui';



import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_speed_meter/internet_speed_meter.dart';

import 'package:lottie/lottie.dart';


class NetworkListener extends StatefulWidget {
  BuildContext context;
  final Widget
      child; // The widget tree where you want to listen for connection changes
  NetworkListener({super.key, required this.child, required this.context});

  @override
  State<NetworkListener> createState() => _NetworkListenerState();
}

class _NetworkListenerState extends State<NetworkListener> {
  late final Connectivity _connectivity;
     final InternetSpeedMeter _internetSpeedMeterPlugin = InternetSpeedMeter();
     double   speed = 0; 
 
  bool _isoffline = false;

  @override
  void initState() {
    super.initState();
    // initSpeedMeter();
    
    _connectivity = Connectivity();
   

    _connectivity.onConnectivityChanged.listen((result) {
  

      if (result.contains(ConnectivityResult.none)) {
        if (mounted) {
          setState(() {
            _isoffline = true;
          });
        }

        // _showNoConnectionDialog();
      } else if (!result.contains(ConnectivityResult.none)) {
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _isoffline = false;
              });
              // Dismiss the dialog when connection is restored
            }
          });
        }
      }
    });
  }

    void initSpeedMeter() async {
    try {
      _internetSpeedMeterPlugin.getCurrentInternetSpeed().listen((event) {
           if (mounted) {
            double internetspeed=
_parseSpeedToKbps(event);


        setState(() {
          speed = internetspeed;
          print('${speed.toString()}');
        });}
        // Since we're using Riverpod, we can update the speed provider here.
        // ref.read(internetSpeed.notifier).state = event;
      });
    } on PlatformException {
      if (mounted) {
        setState(() {
          speed = 0;
        });}
//       

      // Handle any errors related to the speed meter
      // ref.read(internetSpeed.notifier).state = 'Error: Unable to measure speed';
    }
  }

  double _parseSpeedToKbps(String speed) {
  // Assuming the speed is in the format of "xxx.xxkbps"
  final regex = RegExp(r'(\d+(\.\d+)?)'); // Match numbers with optional decimal
  final match = regex.firstMatch(speed);

  if (match != null) {
    // Parse the matched number (e.g., "193.41" as a double)
    return double.tryParse(match.group(0) ?? '0') ?? 0;
  }
  
  // Return 0 if the speed format is invalid
  return 0;
}

   

  // void _dismissNoConnectionDialog() {
  //   if (!mounted) return; // Check if the widget is still mounted
  //   Navigator.of(context).pop(); // Dismiss the dialog
  //   _isDialogOpen = false;
  // }

  // Future<void> _onConnectivityChanged(ConnectivityResult result) async {}

  // void _showNoConnectionDialog() {
  //   if (!mounted) return;
  //   _isDialogOpen = true;
  //   showDialog(
  //     context: context,
  //     barrierDismissible:
  //         false, // Prevent dismissing the dialog without restoring connection
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text("No Internet Connection"),
  //         content:
  //             Text("You are offline. Please check your internet connection."),
  //         actions: [
  //           // TextButton(
  //           //   onPressed: () {
  //           //     Navigator.of(context).pop(); // Dismiss the dialog
  //           //     _isDialogOpen = false;
  //           //   },
  //           //   child: const Text("OK"),
  //           // ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        //  Visibility(
        //     visible: speed<50,
        //     child: Center(
        //       child: BackdropFilter(
        //         filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
        //         child: Container(
        //           alignment: Alignment.center,
        //           decoration: BoxDecoration(
        //             color: const Color.fromARGB(255, 0, 0, 0)
        //                 .withOpacity(0.3),
        //           ),
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        //           child: Directionality(
        //             textDirection: TextDirection.ltr,
        //             child: SizedBox(
        //               height: displayHeight(context) ,
        //               width: displayWidth(context) ,
        //               child:Column(children: [Text('${speed.toString()}'), Lottie.asset('assets/lottie/noInternet2.json',
        //                   fit: BoxFit.contain),])
                     
        //             ),
        //           ),
        //         ),
        //       ),
        //     )),
        Visibility(
            visible: _isoffline,
            child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0)
                        .withOpacity(0.3),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: SizedBox(
                      height: displayHeight(context) ,
                      width: displayWidth(context) ,
                      child: Lottie.asset('assets/lottie/noInternet2.json',
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
            ))
      ],
    ); // Pass the child widget tree
  }
}



Future<String> getCurrentInternetSpeed() async {
  final InternetSpeedMeter _internetSpeedMeterPlugin = InternetSpeedMeter();
  
  try {
    // Fetch the current internet speed and listen to it
    final speedStream = await _internetSpeedMeterPlugin.getCurrentInternetSpeed();
    
    // Return the first speed reading if available
    final speed = await speedStream.first;
    print(speed.toString());
    
    // You can choose to return this speed value
    return speed;
  } on PlatformException catch (e) {
    // Handle errors related to the speed meter
    print('Error: Unable to measure speed - ${e.message}');
    return 'Error'; // Return an error value or handle it accordingly
  }
}

// void initSpeedMeter() async {
//      final InternetSpeedMeter _internetSpeedMeterPlugin = InternetSpeedMeter();

//     try {
//       _internetSpeedMeterPlugin.getCurrentInternetSpeed().listen((event) {
//            if (mounted) { 
       
//         // Since we're using Riverpod, we can update the speed provider here.
//         ref.read(internetSpeed.notifier).state = event;}
//       });
//     } on PlatformException {
//       if (mounted) {
  
        
//         }
// //       

//       // Handle any errors related to the speed meter
//       // ref.read(internetSpeed.notifier).state = 'Error: Unable to measure speed';
//     }
//   }