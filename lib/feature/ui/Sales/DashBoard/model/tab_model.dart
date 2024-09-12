class TabModel {
  final int selectedIndex;

  TabModel({required this.selectedIndex});

  TabModel copyWith({int? selectedIndex}) {
    return TabModel(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}