import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sessionProvider = FutureProvider<bool>((ref) async {
  // Simulate a delay for the splash screen
  await Future.delayed(Duration(seconds: 3));

  // Fetch the token from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  log('stored token:: ' + token.toString());
  // Return true if token exists (logged in), false otherwise (not logged in)
  return token != null;
});
