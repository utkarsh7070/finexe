import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> options;
  final TextEditingController controller;
  final String labelText;

  const MultiSelectDropdown({
    Key? key,
    required this.options,
    required this.controller,
    this.labelText = 'Select Options',
  }) : super(key: key);

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> selectedOptions = [];
  bool isOtherSelected = false;
  final TextEditingController otherTextController = TextEditingController();
  final TextEditingController textInput1 = TextEditingController();
  final TextEditingController textInput2 = TextEditingController();
  final TextEditingController textInput3 = TextEditingController();

  void toggleOption(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
      isOtherSelected = selectedOptions.contains("Other");
    });

    // Update the controller value
    widget.controller.text = selectedOptions.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown label
        Text(
          widget.labelText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        // Dropdown container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.options.map((option) {
              return CheckboxListTile(
                value: selectedOptions.contains(option),
                onChanged: (_) => toggleOption(option),
                title: Text(option),
                controlAffinity: ListTileControlAffinity.leading,
              );
            }).toList()
              ..add(
                // 'Other' option
                CheckboxListTile(
                  value: isOtherSelected,
                  onChanged: (_) {
                    toggleOption("Other");
                  },
                  title: const Text("Other"),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
          ),
        ),
        const SizedBox(height: 16),
        // Additional fields for 'Other' option
        if (isOtherSelected)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: textInput1,
                decoration: const InputDecoration(
                  labelText: "Field 1",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: textInput2,
                decoration: const InputDecoration(
                  labelText: "Field 2",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: textInput3,
                decoration: const InputDecoration(
                  labelText: "Field 3",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Add logic for image upload
                  print("Upload Image button clicked");
                },
                child: const Text("Upload Image"),
              ),
            ],
          ),
      ],
    );
  }
}
