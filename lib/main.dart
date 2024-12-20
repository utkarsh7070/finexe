// import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:finexe/feature/base/service/background_service.dart';
import 'package:finexe/feature/base/service/socket_io_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roam_flutter/roam_flutter.dart';

import 'feature/app/app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   // SocketService().connectSocket();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
  // runApp(const ProviderScope(child: MyApp()));
}

// void _connectSocket() {
//   final Io.Socket socket =
//   socket = IO.io(
//       'http://localhost:5000',
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .build());
//   socket!.connect();
//   socket!.onConnect((_) {
//     print('Connected to Server');
//   });
// }
//
// void _startTracking() async {
//   LocationPermission permission = await Geolocator.requestPermission();
//   Geolocator.getPositionStream(
//           locationSettings: LocationSettings(accuracy: LocationAccuracy.high))
//       .listen((Position position) {
//     print("Sending Location: ${position.latitude}, ${position.longitude}");
//     socket!.emit('send_location', {
//       'lat': position.latitude,
//       'long': position.longitude,
//     });
//   });
// }
