import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static Future<void> createSession(
      {String? accessToken,
      String? employeeId,
      String? name,
      String? email}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', accessToken!);
    preferences.setString('employeId', employeeId!);
    preferences.setString('name', name ?? '');
    preferences.setString('email', email ?? '');
  }

  static Future<void> customerIdSave({
    String? customerId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('customerId', customerId!);
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

  static Future<SharedPreferences> getSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static Future<bool> deleteSession() async {
    SharedPreferences preferences = await getSession();
    // await preferences.remove('token');
    await preferences.clear();
    return true;
  }
}
