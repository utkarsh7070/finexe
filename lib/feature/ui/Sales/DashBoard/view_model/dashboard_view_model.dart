import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/item_model.dart';
import '../model/tab_model.dart';

final stepStageProvider =  StateProvider<String>((ref) {
  return '';
},);

final tabViewModelProvider = StateNotifierProvider<TabViewModel, TabModel>(
      (ref) => TabViewModel(),
);

final itemViewModelProvider =
StateNotifierProvider<ItemViewModel, List<DashBoardDrawerItem>>((ref) {
  return ItemViewModel();
});
class ItemViewModel extends StateNotifier<List<DashBoardDrawerItem>> {
  ItemViewModel() : super(_initialItems());



  // Initial list of items
  static List<DashBoardDrawerItem> _initialItems() {
    return [
     DashBoardDrawerItem(iconData: CupertinoIcons.home, title: 'DashBoard', isExpanded: false),
     DashBoardDrawerItem(iconData: CupertinoIcons.building_2_fill, title: 'Budget/Financial', isExpanded: true),
     DashBoardDrawerItem(iconData: CupertinoIcons.person_2, title: 'Work Place', isExpanded: true),
     DashBoardDrawerItem(iconData: CupertinoIcons.person_2, title: 'DashBoard', isExpanded: false),
     DashBoardDrawerItem(iconData: CupertinoIcons.home, title: 'DashBoard', isExpanded: false),
     DashBoardDrawerItem(iconData: CupertinoIcons.home, title: 'DashBoard', isExpanded: false),
    ];
  }
}

class TabViewModel extends StateNotifier<TabModel> {
  TabViewModel() : super(TabModel(selectedIndex: 0));

  void setTabIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}