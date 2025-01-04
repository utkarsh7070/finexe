import 'package:flutter/material.dart';

class CustomList_Dropdown extends StatefulWidget {
  final List<String> availableOptions; // List of available options
  final String selectedOption; // The currently selected option
  final Function(String) onSelectionChanged; // Callback when selection changes
  final String label;

  const CustomList_Dropdown({super.key, 
    required this.availableOptions,
    required this.selectedOption,
    required this.onSelectionChanged,
    required this.label,
  });

  @override
  _CustomList_DropdownState createState() => _CustomList_DropdownState();
}

class _CustomList_DropdownState extends State<CustomList_Dropdown> {
  bool isDropdownOpen = false; // Tracks whether the dropdown is open or closed

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        const SizedBox(height: 5),
        // Dropdown display with selected option
        InkWell(
          onTap: () => setState(() {
            isDropdownOpen = !isDropdownOpen; // Toggle dropdown visibility
          }),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedOption.isNotEmpty
                      ? widget.selectedOption // Display selected option
                      : "Select an option", // Placeholder
                  style: TextStyle(
                    color: widget.selectedOption.isEmpty
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
                Icon(
                  isDropdownOpen
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),

        // Dropdown options
        if (isDropdownOpen) ...[
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: widget.availableOptions.map((option) {
                return InkWell(
                  onTap: () {
                    // Update the selected option and close dropdown
                    widget.onSelectionChanged(option);
                    setState(() {
                      isDropdownOpen = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        Text(option),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
