import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';

class CustomDropdownWithCross extends StatefulWidget {
  final List<String> items;
  final List<String> initialSelectedItems;

  final String placeholder;
  final Function(List<String>) onSelectionChanged;

  const CustomDropdownWithCross({
    Key? key,
    required this.items,
    this.initialSelectedItems = const [], // Defaul
    required this.onSelectionChanged,
    this.placeholder = 'Select Items',
  }) : super(key: key);

  @override
  _CustomDropdownWithCrossState createState() =>
      _CustomDropdownWithCrossState();
}

class _CustomDropdownWithCrossState extends State<CustomDropdownWithCross> {
  List<String> selectedItems = [];
  bool isDropdownOpen = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItems = widget.initialSelectedItems;
  }

  void toggleItemSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
    widget.onSelectionChanged(selectedItems); // Notify parent widget
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: displayWidth(context),
            // height: displayHeight(context)*0.06,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: selectedItems.isNotEmpty
                  ? selectedItems.map((item) {
                return Chip(
                  label: Text(item),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () => toggleItemSelection(item),
                );
              }).toList()
                  : [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.placeholder,
                        style: const TextStyle(color: Colors.grey)),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: widget.items.map((item) {
                return CheckboxListTile(
                  title: Text(item),
                  value: selectedItems.contains(item),
                  onChanged: (_) => toggleItemSelection(item),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
