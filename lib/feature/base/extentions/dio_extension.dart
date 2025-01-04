import 'package:dio/dio.dart';

extension DioClientExtension on Dio {
  static Dio client = Dio();
}