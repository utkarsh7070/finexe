


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/api/api.dart';

import '../../../../base/api/dio.dart';
import '../../../../base/service/session_service.dart';
import '../model/VisitItemCallingModelData.dart';
import '../model/VisitItemClosureModelData.dart';
import '../model/VisitItemCollectionModelData.dart';
import '../model/VisitItemDetailModelData.dart';
import '../model/VisitItemNoticeModelData.dart';


final fetchVisitDetailsProvider = FutureProvider.autoDispose.family<List<VisitItemDetail>,String>((ref,ldNumber) async {
  String? token = await SessionService.getToken();
  final dio = ref.watch(dioProvider);
 /* final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
*/

  final response = await dio.get(
    Api.getVisitDetail,
    queryParameters: {'LD': ldNumber},
    options: Options(headers: {"token": token}),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.data}');

  if (response.statusCode == 200) {
    final List items = response.data['items'];
    return items.map((item) => VisitItemDetail.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load visit details');
  }
});

final fetchVisitCollectionProvider = FutureProvider.autoDispose.family<List<VisitItemCollection>,String>((ref,ldNumber) async {
final dio = ref.watch(dioProvider);
  String? token = await SessionService.getToken();
  /*final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
*/

  final response = await dio.get(
    Api.getVisitCollection,
    queryParameters: {'LD': ldNumber},
    options: Options(headers: {"token": token}),
  );

  print('Response collection status: ${response.statusCode}');
  print('Response collection body: ${response.data}');

  if (response.statusCode == 200) {
    final List items = response.data['items'];
    return items.map((item) => VisitItemCollection.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load visit details');
  }
});


final fetchVisitCallingProvider = FutureProvider.autoDispose.family<List<VisitItemCalling>,String>((ref,ldNumber) async {
  String? token = await SessionService.getToken();
  final dio = ref.watch(dioProvider);
  /*final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
*/
  final response = await dio.get(
    Api.getVisitCalling,
    queryParameters: {'LD': ldNumber},
    options: Options(headers: {"token": token}),
  );

  print('Response Calling status: ${response.statusCode}');
  print('Response Calling body: ${response.data}');

  if (response.statusCode == 200) {
    final List items = response.data['items'];
    return items.map((item) => VisitItemCalling.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load visit Calling');
  }
});

final fetchVisitClosureProvider = FutureProvider.autoDispose.family<List<VisitItemClosure>,String>((ref,ldNumber) async {
  String? token = await SessionService.getToken();
  final dio = ref.watch(dioProvider);
  /*final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
*/

  final response = await dio.get(
    Api.getVisitClosure,
    queryParameters: {'LD': ldNumber},
    options: Options(headers: {"token": token}),
  );


  print('Response Closure status: ${response.statusCode}');
  print('Response Closure body: ${response.data}');


  if (response.statusCode == 200) {
    final List items = response.data['items'];
    return items.map((item) => VisitItemClosure.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load visit details');
  }

});

final fetchVisitNoticeProvider = FutureProvider.autoDispose.family<List<VisitItemNotice>,String>((ref,ldNumber) async {

  print('this is notice');
  String? token = await SessionService.getToken();
  final dio = ref.watch(dioProvider);
  /*final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
*/
  final response = await dio.get(
    Api.getVisitNotice,
    queryParameters: {'LD': ldNumber},
    options: Options(headers: {"token": token}),
  );

  print('Response Notice status: ${response.statusCode}');
  print('Response Notice body: ${response.data}');

  if (response.statusCode == 200) {
    final List items = response.data['items'];
    return items.map((item) => VisitItemNotice.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load visit details');
  }

});