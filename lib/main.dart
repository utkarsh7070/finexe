import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roam_flutter/roam_flutter.dart';
import 'feature/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Roam.initialize(publishKey: "79978e933ef4e5cdfb8410e66005d7d5dafa7a0171e7bc81aea9db4224781908");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
  // runApp(const ProviderScope(child: MyApp()));
}
