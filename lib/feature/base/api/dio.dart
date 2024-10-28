
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api.dart';


final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: Api.baseUrl, // Change to your base URL
    connectTimeout:  Api.connectionTimeout,  // 5 seconds timeout
    receiveTimeout: Api.receiveTimeout,  // 3 seconds timeout
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_api_token',  // Optional: You can dynamically update this
    },
  ));
  return dio;
});
