import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static Future<void> createSession(
      {String? accessToken,
      String? employeeId,
      String? name,
      String? email,
      String? romId,
      String? trakingMode,
      List<String>? role}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    speciality.setToken( accessToken!);
    speciality.setAllEmployeeData(email:email??'',employeeId: employeeId??'',name:  name ?? '',roamId: romId ?? '',trakingMode: trakingMode ?? '');
    // preferences.setString('employeId', employeeId!);
    // preferences.setString('name', name ?? '');
    // preferences.setString('email', email ?? '');
    // preferences.setString('roamId', romId ?? '');
    // preferences.setString('trackingMode', trakingMode ?? '');
    speciality.setRole(role);
    // preferences.setStringList('roleName', role ?? []);

    print(
        'session values ${speciality.getToken()}  ${preferences.getString('employeId')}   ${preferences.getString('name')}   ${preferences.getString('email')}  ${preferences.getStringList('roleName')}');
  }

// // Method to retrieve the token
//   static Future<String?> getToken() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     return preferences.getString('token');
//   }

  static Future<void> customerIdSave({
    String? customerId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('customerId', customerId!);
  }

  static Future<String?> paymentMode({
    String? paymentMode,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('paymentMode', paymentMode!);
  }

  // Method to retrieve the token
  static Future<String?> getPaymentMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('paymentMode');
  }

  static Future<void> punchStatus({
    String? message,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('message', message!);
  }

  static Future<void> punchStatusNavigate({bool? punchStatus}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('punchStatus', punchStatus!);
  }

  // static Future<SharedPreferences> getSession() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return preferences;
  // }

//   static Future<bool> deleteSession() async {
//     SharedPreferences preferences = await getSession();
// // await preferences.remove('token');
//     await preferences.clear();
//     return true;
//   }
}
