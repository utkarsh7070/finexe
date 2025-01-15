import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/utils/general/pref_utils.dart';
import '../PD Forms/pd_fromfilds.dart/model/Submit Data Models/pd_response_model.dart';

// class SegmentNotifier extends StateNotifier<int> {
//   SegmentNotifier() : super(1); // Default to "Existing Data"
//
//   void updateSegment(int value) {
//     state = value;
//   }
// }
//
// // Provide the notifier
// final segmentProvider = StateNotifierProvider.autoDispose<SegmentNotifier, int>(
//       (ref) => SegmentNotifier(),
// );


final segmentProvider = StateProvider<int>((ref) {
  return 1;
},);


