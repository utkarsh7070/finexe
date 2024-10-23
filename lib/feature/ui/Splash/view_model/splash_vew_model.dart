import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sessionProvider = FutureProvider<SesstionModel>((ref) async {
  // Simulate a delay for the splash screen
  await Future.delayed(Duration(seconds: 3));

  // Fetch the token from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String? role = prefs.getString('roleName');
  log('stored token:: ' + token.toString());
  log('stored role:: ' + role.toString());

  // Return true if token exists (logged in), false otherwise (not logged in)
  return SesstionModel(token: token != null, role: role);
});

class SesstionModel {
  bool? token;
  String? role;
  SesstionModel({this.token = false, this.role = ''});
}
