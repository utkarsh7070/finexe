// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'dart:io';
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
      'https://stageapi.fincooper.in', // Replace with your server URL
      IO.OptionBuilder()
          .setTransports(['websocket'])  // Specify transport protocol
          .disableAutoConnect() // Disable auto-connect if you prefer manual connect
          .setTimeout(10000)
          .build(),
    );
    // socket = IO.io( 'https://stageapi.fincooper.in',  <String, dynamic>{
    //   'autoConnect': false,
    //   'transports': ['websocket'],
    // });
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

  void startTracking() async {
    print('startTracking fun');
    if (socket != null && socket.connected) {
      print('socket is connected and start tracking');
      await Geolocator.requestPermission();
      Geolocator.getPositionStream(
              locationSettings:
                  const LocationSettings(accuracy: LocationAccuracy.high))
          .listen((Position position) {
        print("Sending Location: ${position.latitude}, ${position.longitude}");
        socket!.emit('send_location', {
          'lat': position.latitude,
          'long': position.longitude,
        });
      });

    }else{
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
}
