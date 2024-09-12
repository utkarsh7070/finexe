import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authenticate/view_model/login_view_model.dart';



final radiosProvider = StateNotifierProvider<RadiosNotifier, Roles>((ref) {
  return RadiosNotifier();
});

class RadiosNotifier extends StateNotifier<Roles> {
  RadiosNotifier() : super(Roles.All); // Default value for the radio buttons

  // Method to update the selected value
  void select(Roles value) {
    state = value;
  }
}
enum Roles { All, Approved, Pending,Rejected,Incomplete }