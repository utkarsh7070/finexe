import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roam_flutter/roam_flutter.dart';

import 'feature/app/app.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // initialiseRoamSdk();
  runApp(const ProviderScope(child: MyApp()));
}

