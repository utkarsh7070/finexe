import 'dart:developer';
import 'dart:ui';



import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';

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
  bool _isoffline = false;

  @override
  void initState() {
    super.initState();
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