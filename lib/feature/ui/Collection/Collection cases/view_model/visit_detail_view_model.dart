


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/api/api.dart';
import '../model/CloserDetailItem.dart';
import '../model/VisitItemCollection.dart';
import '../model/VisitItemDetail.dart';

final fetchVisitDetailsProvider = FutureProvider.family<List<VisitItemDetail>,String>((ref,ldNumber) async {
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";

  final response = await Dio().get(
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

final fetchVisitCollectionProvider = FutureProvider.family<List<VisitItemCollection>,String>((ref,ldNumber) async {
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";

  final response = await Dio().get(
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

final fetchVisitClosureProvider = FutureProvider.family<List<VisitItemClosure>,String>((ref,ldNumber) async {
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";

  final response = await Dio().get(
    Api.getVisitClosure,
    queryParameters: {'LD': ldNumber},
    options: Options(headers: {"token": token}),
  );

  print('Response collection status: ${response.statusCode}');
  print('Response collection body: ${response.data}');

  if (response.statusCode == 200) {
    final List items = response.data['items'];
    return items.map((item) => VisitItemClosure.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load visit details');
  }
});