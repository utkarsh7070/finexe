//ignore: unused_import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class speciality {
  static SharedPreferences? _sharedPreferences ;

  speciality() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    debugPrint('SharedPreference Initialized');
  }


  ///will clear all the data stored in preference
  static void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  //set themeData
  static Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  static String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }
  // token 
   static String? getToken() {
    print('get token called ');
    return _sharedPreferences!.getString('token');
  }

 static Future<void> setToken(String token) async {
    _sharedPreferences!.setString('token', token);
  }

  //set Role

  static Future<void> setRole(List<String>? role) async {
    _sharedPreferences!.setStringList('roleName', role??[] );
  }

  static List<String>? getRole() {
    return _sharedPreferences!.getStringList('roleName') ;
  }
  //set employee data 
    // Set employee data
  static Future<void> setAllEmployeeData({
    required String employeeId,
    required String name,
    required String email,
    required String roamId,
    required String trakingMode,
  }) async {
    await _sharedPreferences!.setString('employeId', employeeId);
    await _sharedPreferences!.setString('name', name);
    await _sharedPreferences!.setString('email', email);
    await _sharedPreferences!.setString('roamId', roamId);
    await _sharedPreferences!.setString('trackingMode', trakingMode);
  }

  // get employee data 
  static String? getUserEmail() {
    return _sharedPreferences!.getString('email');
  }
  static String? getEmployeId() {
    return _sharedPreferences!.getString('employeId');
  }
   static String? getName() {
    return _sharedPreferences!.getString('name');
  }
   static String? getRoamId() {
    return _sharedPreferences!.getString('roamId');
  }
    static String? getTrackingMode() {
    return _sharedPreferences!.getString('trackingMode');
  }

  // set session data 

  static Future<void> customerIdSave({
    String? customerId,
  }) async {
  
    _sharedPreferences!.setString('customerId', customerId!);
  }

  static Future<void> punchStatus({
    String? message,
  }) async {
    _sharedPreferences!.setString('message', message!);
  }

  static Future<void> punchStatusNavigate({bool? punchStatus}) async {
    _sharedPreferences!.setBool('punchStatus', punchStatus!);
  }

  



 

 

  //set user Email
  // static Future<void> setUseEmail(String email) async {
  //   _sharedPreferences!.setString('email', email);
  // }

  // static String getUserEmail() {
  //   return _sharedPreferences!.getString('email') ?? '';
  // }

  // set user id
  // static Future<void> setUserID(String id) async {
  //   _sharedPreferences!.setString('userId', id);
  // }

  // static String getUserID() {
  //   return _sharedPreferences!.getString('userId') ?? '';
  // }

  // set user name
  // static Future<void> setUserName(String name) async {
  //   _sharedPreferences!.setString('userName', name);
  // }

  // static String getUserName() {
  //   return _sharedPreferences!.getString('userName') ?? '';
  // }

// set speciality
  // static Future<void> setUserSpeciality(String name) async {
  //   _sharedPreferences!.setString('speciality', name);
  // }

  // static String getUserSpeciality() {
  //   return _sharedPreferences!.getString('speciality') ?? '';
  // }

  //save local lag
  // static Future<void> setLang(String lang) async {
  //   _sharedPreferences!.setString('language', lang);
  // }

  // static String getLang() {
  //   return _sharedPreferences!.getString('language') ?? 'en';
  // }

  // static Future<void> setLat(double lat) async {
  //   _sharedPreferences!.setDouble('lat', lat);
  // }

  // static Future<void> setLng(double lng) async {
  //   _sharedPreferences!.setDouble('lng', lng);
  // }

  // static double getLat() {
  //   return _sharedPreferences!.getDouble('lat') ?? 0.0;
  // }

  // static double getLng() {
  //   return _sharedPreferences!.getDouble('lng') ?? 0.0;
  // }

  // // verified driver status save
  // static Future<void> setstatus(String isverified) async {
  //   _sharedPreferences!.setString('isverified', isverified);
  // }

  // static String getstatus() {
  //   return _sharedPreferences!.getString('isverified') ?? 'no';
  // }
}