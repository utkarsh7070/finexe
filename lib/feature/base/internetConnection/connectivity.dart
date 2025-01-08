import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityBuilder extends ConsumerStatefulWidget {
  final Widget Function(BuildContext context, List<ConnectivityResult> result,
      )
  builder;
  const ConnectivityBuilder({super.key, required this.builder,});

  @override
  _ConnectivityBuilderState createState() => _ConnectivityBuilderState();
}

class _ConnectivityBuilderState extends ConsumerState<ConnectivityBuilder> {

  List<ConnectivityResult> _connectivityresult = [ConnectivityResult.none];
  //  final InternetSpeedMeter _internetSpeedMeterPlugin = InternetSpeedMeter();
  //  String speed='';
  @override
  void initState() {


    super.initState();
    // initSpeedMeter();
    _initializeConectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      if (mounted) {
        setState(() {
          _connectivityresult = result;
        });
      }
    });
  }


//   void initSpeedMeter() async {
//     try {
//       _internetSpeedMeterPlugin.getCurrentInternetSpeed().listen((event) {
//            if (mounted) {
//         setState(() {
//           speed = event;
//         });}
//         // Since we're using Riverpod, we can update the speed provider here.
//         // ref.read(internetSpeed.notifier).state = event;
//       });
//     } on PlatformException {
//       if (mounted) {
//         setState(() {
//           speed = 'Not find';
//         });}
// //       

//       // Handle any errors related to the speed meter
//       // ref.read(internetSpeed.notifier).state = 'Error: Unable to measure speed';
//     }
//   }





//   void initSpeedMeter() async {
//     try {
//       _internetSpeedMeterPlugin.getCurrentInternetSpeed().listen((event) {
//            if (mounted) {
//         setState(() {
//           speed = event;
//         });}
//         // Since we're using Riverpod, we can update the speed provider here.
//         // ref.read(internetSpeed.notifier).state = event;
//       });
//     } on PlatformException {
//       if (mounted) {
//         setState(() {
//           speed = 'Not find';
//         });}
// //


//       // Handle any errors related to the speed meter
//       // ref.read(internetSpeed.notifier).state = 'Error: Unable to measure speed';
//     }
//   }






  Future<void> _initializeConectivity() async {
    _connectivityresult = await Connectivity().checkConnectivity();
    if (mounted) {
      setState(() {});}
  }


  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _connectivityresult);
  }
}


// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:internet_speed_meter/internet_speed_meter.dart';

// class ConnectivityBuilder extends StatefulWidget {
//   final Widget Function(BuildContext context, ConnectivityResult connectivityResult, String currentSpeed) builder;
//   const ConnectivityBuilder({super.key, required this.builder});

//   @override
//   _ConnectivityBuilderState createState() => _ConnectivityBuilderState();
// }

// class _ConnectivityBuilderState extends State<ConnectivityBuilder> {
//   ConnectivityResult _connectivityResult = ConnectivityResult.none;
//   late String _currentSpeed;
//   final InternetSpeedMeter _internetSpeedMeterPlugin = InternetSpeedMeter();

//   @override
//   void initState() {
//     super.initState();
//     _currentSpeed = '';

//     // Initialize connectivity
//     _initializeConnectivity();

//     // Listen for connectivity changes
//     Connectivity().onConnectivityChanged.listen((result) {
//       setState(() {
//         _connectivityResult = result;
//       });
//     });

//     // Initialize speed meter plugin
//     initSpeedMeter();
//   }

//   Future<void> _initializeConnectivity() async {
//     _connectivityResult = await Connectivity().checkConnectivity();
//     setState(() {});
//   }


// void initSpeedMeter() async {
//   try {
//     _internetSpeedMeterPlugin.getCurrentInternetSpeed().listen((event) {
//       setState(() {
//         _currentSpeed = event;
//       });
//       print('Speed Event: $event');
//     });
//   } on PlatformException {
//     setState(() {
//       _currentSpeed = 'Failed to get currentSpeed.';
//     });
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context, _connectivityResult, _currentSpeed);
//   }
// }