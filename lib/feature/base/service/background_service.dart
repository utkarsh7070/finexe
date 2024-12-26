import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/service/socket_io_service.dart';

import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

// class BackgroundService{
//
//   void startBackgroundService() async {
//     final isRunning = await FlutterBackgroundService().isRunning();
//     if (!isRunning) {
//       FlutterBackgroundService().startService();
//     } else {
//       print("Service already running.");
//     }
//   }
//
// void stopBackgroundService() {
//   final service = FlutterBackgroundService();
//   service.invoke("stop");
// }
//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//
//   await service.configure(
//     iosConfiguration: IosConfiguration(
//       autoStart: true,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//     androidConfiguration: AndroidConfiguration(
//       autoStart: true,
//       onStart: onStart,
//       isForegroundMode: false,
//       autoStartOnBoot: true,
//     ),
//   );
// }
//
// @pragma('vm:entry-point')
// static  Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//
//   return true;
// }
//
// @pragma('vm:entry-point')
// static void onStart(ServiceInstance service) async {
//   final socket = IO.io(
//     'https://stageapi.fincooper.in', // Replace with your server URL
//     IO.OptionBuilder()
//         .setTransports(['websocket']) // Specify transport protocol
//         .disableAutoConnect() // Disable auto-connect if you prefer manual connect
//         .setTimeout(10000)
//         .build(),
//   );
//   // Connect to the server
//   socket.connect();
//   // Listen for connection events
//   socket.onConnect((_) {
//     print("Connected to server");
//   });
//   // Listen to incoming messages
//   socket.on('event', (data) {
//     print("Data received: $data");
//   });
//   // Handle connection errors
//   socket.onConnectError((data) => print("Connect Error: $data"));
//   socket.onError((data) => print("Error: $data"));
//
//   service.on("stop").listen((event) {
//     service.stopSelf();
//     print("background process is now stopped");
//   });
//
//   service.on("start").listen((event) {});
//
//   Timer.periodic(const Duration(seconds: 1), (timer) {
//     socket.emit("event-name", "your-message");
//     print("service is successfully running ${DateTime
//         .now()
//         .second}");
//   });
// }}

class BackgroundService {
  static AppLifecycleState? states;
  // static IO.Socket? socket;
  static AndroidServiceInstance? services;
  static ServiceInstance? mService;
  static SwitchService staticValue = SwitchService.start;
  static String? serviceSatus;

  Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'my_foreground', // id
      'MY FOREGROUND SERVICE', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.low, // importance must be at low or higher level
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        // onDidReceiveNotificationResponse: (details) async {
        //   if (kDebugMode) {
        //     print(details.actionId.toString());
        //   }
        //   if (details.id != null) {
        //     await NotificationDialog()
        //         .notificationDialog(
        //       context: Get.context!,
        //       function: () {
        //         if (kDebugMode) {
        //           print('object');
        //         }
        //       },
        //     )
        //         .then((value) async {
        //       if (value!) {
        //         SharedPreferences preferences =
        //         await SessionService.getSession();
        //         service.invoke('stopService');
        //         preferences.setString('status', 'Stop');
        //       }
        //       if (kDebugMode) {
        //         print('bool value $value');
        //       }
        //     });
        //     if (kDebugMode) {
        //       print('details.id.toString() ${details.id.toString()}');
        //     }
        //   }
        // },

        // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        InitializationSettings(
          iOS: DarwinInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true,
              onDidReceiveLocalNotification:
                  (int id, String? title, String? body, String? payload) async {
                if (kDebugMode) {
                  print('object $payload');
                }
              },
              notificationCategories: [
                DarwinNotificationCategory(
                  'stop_service',
                  actions: <DarwinNotificationAction>[
                    DarwinNotificationAction.plain(
                        'stop_service', 'Stop Service')
                  ],
                ),
              ]),
          android: const AndroidInitializationSettings('ic_bg_service_small'),
        ),
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await service.configure(
        iosConfiguration: IosConfiguration(
            autoStart: true,
            onBackground: onIosBackground,
            onForeground: onStart),
        androidConfiguration: AndroidConfiguration(
          autoStart: true,
          onStart: onStart,
          isForegroundMode: true,
          notificationChannelId: 'my_foreground',
          initialNotificationTitle: 'Finexe',
          initialNotificationContent: 'Initializing',
          foregroundServiceNotificationId: 888,
        ));

    // getDataBaseData();
    // voskServiceInitialize();
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    mService = service;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();
//---------------------------------------
    //-----------------------------------
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
        if (kDebugMode) {
          print('in backgroundService Start ');
        }
      });
    }
    service.on('stopService').listen((event) {
      SocketService().disconnect();
      service.stopSelf();
    });

    // Initialize Socket.IO connection
    // initializeSocket();
    IO.Socket socket = IO.io(
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

    // bring to foreground
    // SharedPreferences preferences = await SessionService.getSession();
    // preferences.setBool('ios', true);
    // if (!(preferences.containsKey('status'))) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (service is AndroidServiceInstance) {
        // ignore: unrelated_type_equality_checks
        if (await service.isForegroundService()) {
          if (kDebugMode) {
            print('isForegroundService >>>>>');
          }
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          String? userId = sharedPreferences.getString('employeId');
          // String? userId = speciality.getEmployeId();
        

          //-------------------start tracking ---------------------------------
          // startTracking(userId!);
          if (socket.connected) {
             if (kDebugMode) {
            print('socket is connected and start tracking');}
            // await Geolocator.requestPermission();
            Geolocator.getPositionStream(
                    locationSettings: const LocationSettings(
                        accuracy: LocationAccuracy.high, distanceFilter: 1))
                .listen((Position position) {
              print(
                  "Sending Location: ${position.latitude}, ${position.longitude}");
              // Conditionally include userId in the emitted data
              Map<String, dynamic> locationData = {
                'lat': position.latitude,
                'long': position.longitude,
              };

   
              if (userId != null) {
                locationData['userId'] = userId;
              }

             
              socket.emit('send_location', locationData);
              // socket.emit('send_location', {
              //   'lat': position.latitude,
              //   'long': position.longitude,
              //   'userId': userId
              // });
            });
          } else {
            print("Socket not initialized or not connected");
          }
          // ---------------------------------------------------------------------
          flutterLocalNotificationsPlugin.show(
            payload: 'stop_service',
            888,
            'Finexe',
            'Finexe is tracking...',
            const NotificationDetails(
              android: AndroidNotificationDetails(
                // category: AndroidNotificationCategory.message,
                'my_foreground',
                'MY FOREGROUND SERVICE',
                icon: 'ic_bg_service_small',
                ongoing: true,
                priority: Priority.high,
                // ticker: 'ticker',
                actions: [
                  // AndroidNotificationAction(
                  //   '1',
                  //   'Stop Service',
                  //   showsUserInterface: true,
                  // )
                ],
              ),
            ),
          );
        } else {
          service.stopSelf();
        }
        service.invoke('update');
      } else if (service is IOSServiceInstance) {
        if (kDebugMode) {
          // print('service.reactive.status.isSuccess ${service.reactive.status.isSuccess}');
        }
        // if (!preferences.containsKey('ios')) {
        //   preferences.setBool('ios', true );
        //   flutterLocalNotificationsPlugin.show(
        //     payload: 'stop_service',
        //     888,
        //     'FlikPro',
        //     'FlikPro is listening...',
        //     const NotificationDetails(
        //       iOS: DarwinNotificationDetails(
        //           categoryIdentifier: 'stop_service',
        //           presentBanner: true,
        //           presentList: true),
        //     ),
        //   );
        // }
      }
      if (kDebugMode) {
        print(
            'FLUTTER BACKGROUND SERVICE: ${DateTime.now()} instance $service');
      }
    });
    // }
  }

  Future<void> onSelectNotification(String? payload, service) async {
    // var ser= service;
    if (payload == 'stop_service') {
      // service.stopSelf();
      // await NotificationDialog().notificationDialog(
      //   context: Get.context!,
      //   function: () {
      //     service.invoke('stopService');
      //     if (kDebugMode) {
      //       print('object');
      //     }
      //   },
      // );
      // Fluttertoast.showToast(
      //     msg: 'Accepted',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: AppColors.primary,
      //     textColor: AppColors.white,
      //     fontSize: 16.0);
      // Stop the background service here
      if (kDebugMode) {
        print('Stopping background service...');
      }
      staticValue = SwitchService.stop;
      if (kDebugMode) {
        print(staticValue);
      }
    }
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // ignore: avoid_print
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     // ignore: avoid_print
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }

  static void initializeSocket() {
    SocketService().connectSocket();
    //  socket = IO.io(
    //   'https://stageapi.fincooper.in', // Replace with your server URL
    //   IO.OptionBuilder()
    //       .setTransports(['websocket']) // Specify transport protocol
    //       .disableAutoConnect() // Disable auto-connect if you prefer manual connect
    //       .setTimeout(10000)
    //       .build(),
    // );
    // // Connect to the server
    // socket?.connect();
    // // Listen for connection events
    // socket?.onConnect((_) {
    //   print("Connected to server");
    // });
    // // Listen to incoming messages
    // socket?.on('event', (data) {
    //   print("Data received: $data");
    // });
    // // Handle connection errors
    // socket?.onConnectError((data) => print("Connect Error: $data"));
    // socket?.onError((data) => print("Error: $data"));
  }

  static void startTracking(String userId) async {
    SocketService().startTracking(userId);
    // print('startTracking fun');
    // if (socket != null && socket!.connected) {
    //   print('socket is connected and start tracking');
    //   await Geolocator.requestPermission();
    //   Geolocator.getPositionStream(
    //       locationSettings: const LocationSettings(
    //           accuracy: LocationAccuracy.high, distanceFilter: 1))
    //       .listen((Position position) {
    //     print("Sending Location: ${position.latitude}, ${position.longitude}");
    //     socket!.emit('send_location', {
    //       'lat': position.latitude,
    //       'long': position.longitude,
    //       'userId': userId
    //     });
    //   });
    // } else {
    //   print("Socket not initialized or not connected");
    // }
  }
}

enum SwitchService { stop, start }
