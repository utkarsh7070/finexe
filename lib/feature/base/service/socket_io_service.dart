import 'package:finexe/feature/base/api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  // Singleton pattern
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

   late IO.Socket socket;

  SocketService._internal();

  void connectSocket() {
    socket = IO.io(
      Api.baseUrl, // Replace with your server URL
      IO.OptionBuilder()
          .setTransports(['websocket']) // Specify transport protocol
          .disableAutoConnect() // Disable auto-connect if you prefer manual connect
          .setTimeout(10000)
          .build(),
    );
    // Connect to the server
    socket.connect();
    // Listen for connection events
    socket.onConnect((_) {
      print("Connected to server");
    });
    // Listen to incoming messages
    socket.on('event', (data) {
      print("Data received: $data");
    });
    // Handle connection errors
    socket.onConnectError((data) => print("Connect Error: $data"));
    socket.onError((data) => print("Error: $data"));

    // Handle disconnection
    // socket.onDisconnect((_) => print("Disconnected"));
  }

  void sendMessage(String event, dynamic data) {
    socket.emit(event, data);
  }

  void disconnect() {
    socket.disconnect();
  }

  void startTracking(String userId) async {
    print('startTracking fun');
    if (socket.connected) {
      print('socket is connected and start tracking');
      await Geolocator.requestPermission();
      Geolocator.getPositionStream(
              locationSettings: const LocationSettings(
                  accuracy: LocationAccuracy.high, distanceFilter: 1))
          .listen((Position position) {
        print("Sending Location: ${position.latitude}, ${position.longitude}");
        socket.emit('send_location', {
          'lat': position.latitude,
          'long': position.longitude,
          'userId': userId
        });
      });
    } else {
      print("Socket not initialized or not connected");
    }
  }

  /// Stop tracking
  void stopTracking(String userId) {
    if (socket.connected) {
      socket.emit('stopTracking', {'userId': userId});
      if (kDebugMode) {
        print("Tracking stopped for $userId");
      }
    } else {
      print("Socket not connected");
    }
  }

  //------------------------Background Service----------------------------------
  // Future<void> initializeBackgroundService() async {
  //   final service = FlutterBackgroundService();
  //
  //   await service.configure(
  //     androidConfiguration: AndroidConfiguration(
  //       onStart: onStart,
  //       autoStart: true,
  //       isForegroundMode: true,
  //       notificationChannelId: 'location_channel',
  //       initialNotificationTitle: 'Tracking Active',
  //       initialNotificationContent: 'Tracking user location...',
  //     ),
  //     iosConfiguration: IosConfiguration(
  //         autoStart: true,
  //         onBackground: onIosBackground,
  //         onForeground: onStart),
  //   );
  //
  //   service.startService();
  // }
  //
  // @pragma('vm:entry-point')
  // static void onStart(ServiceInstance service) async {
  //   // Location location = Location();
  //
  //     DartPluginRegistrant.ensureInitialized();
  //
  //     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  //     // Only available for flutter 3.0.0 and later
  //     DartPluginRegistrant.ensureInitialized();
  //     if (service is AndroidServiceInstance) {
  //       service.on('setAsForeground').listen((event) {
  //         service.setAsForegroundService();
  //       });
  //
  //       service.on('setAsBackground').listen((event) {
  //         service.setAsBackgroundService();
  //         if (kDebugMode) {
  //           print('in backgroundService Start ');
  //         }
  //       });
  //     }
  //     service.on('stopService').listen((event) {
  //       service.stopSelf();
  //     });
  //
  //
  //     // bring to foreground
  //     Timer.periodic(const Duration(seconds: 1), (timer) async {
  //       if (service is AndroidServiceInstance) {
  //         if (await service.isForegroundService()) {
  //           flutterLocalNotificationsPlugin.show(
  //             888,
  //             "Location Update",
  //             'Awesome ${DateTime.now()}',
  //             const NotificationDetails(
  //               android: AndroidNotificationDetails(
  //                 'my_foreground',
  //                 'MY FOREGROUND SERVICE',
  //                 icon: 'ic_bg_service_small',
  //                 ongoing: true,
  //                 priority: Priority.high,
  //               ),
  //             ),
  //           );
  //         }
  //       }
  //     });
  //     socket = IO.io(
  //         'http://your-server-url',
  //         IO.OptionBuilder()
  //             .setTransports(['websocket'])
  //             .enableAutoConnect()
  //             .build());
  //     socket!.connect();
  //
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? userId = preferences.getString('employeId');
  //
  //     if (socket != null && socket!.connected) {
  //       print('socket is connected and start tracking');
  //       await Geolocator.requestPermission();
  //       Geolocator.getPositionStream(
  //           locationSettings: const LocationSettings(
  //               accuracy: LocationAccuracy.high, distanceFilter: 1))
  //           .listen((Position position) {
  //         print("Sending Location: ${position.latitude}, ${position.longitude}");
  //         socket!.emit('send_location', {
  //           'lat': position.latitude,
  //           'long': position.longitude,
  //           'userId': userId
  //         });
  //       });
  //
  //     // Update notification
  //     //   service.setNotificationInfo(
  //     //     title: "Location Update",
  //     //     content: "Lat: ${locationData.latitude}, Lng: ${locationData.longitude}",
  //     //   );
  //     // });
  //   }
  //
  //   //-----------------------------------------------------------------------------
  // }
  //
  // @pragma('vm:entry-point')
  // Future<bool> onIosBackground(ServiceInstance service) async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   DartPluginRegistrant.ensureInitialized();
  //   return true;
  // }
}
