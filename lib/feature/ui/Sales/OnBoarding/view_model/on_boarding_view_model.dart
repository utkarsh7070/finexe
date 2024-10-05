import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authenticate/view_model/login_view_model.dart';

final gridItem= StateProvider<List<GridItem>>((ref) {
return <GridItem>[
  GridItem(title: 'All Cases',subTitle: '1500+',icon: 'assets/images/job.png' ),
  GridItem(title: 'Approved',subTitle: '1500+',icon: 'assets/images/check.png' ),
  GridItem(title: 'Pending',subTitle: '1500+',icon: 'assets/images/pending.png' ),
  GridItem(title: 'Rejected',subTitle: '1500+',icon: 'assets/images/reject.png' )
];
},);

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

class GridItem{
  final String icon;
  final String title;
  final String subTitle;
  GridItem({required this.icon, required this.title, required this.subTitle});

}
enum Roles { All, Approved, Pending,Rejected,Incomplete }