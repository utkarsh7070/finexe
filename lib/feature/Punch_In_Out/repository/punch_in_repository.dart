// import '../model/response_model.dart';

abstract class PunchInRepository {
  Future<dynamic> punchIn(Map<String, String> token);
  Future<dynamic> punchOut(Map<String, String> token);
  Future<dynamic> checkPunch(
      Map<String, double> queryParam, Map<String, String> token);
}
