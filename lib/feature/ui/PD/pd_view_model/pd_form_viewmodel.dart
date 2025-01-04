import 'package:flutter_riverpod/flutter_riverpod.dart';

class SegmentNotifier extends StateNotifier<int> {
  SegmentNotifier() : super(1); // Default to "Existing Data"

  void updateSegment(int value) {
    state = value;
  }
}

// Provide the notifier
final segmentProvider = StateNotifierProvider.autoDispose<SegmentNotifier, int>(
      (ref) => SegmentNotifier(),
);
