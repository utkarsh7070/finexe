import 'package:flutter/material.dart';

class CustomRadioButtonScreen extends StatefulWidget {
  final String heading;
  final List<String> options;
  final Function(String) onSelect; // Callback to pass selected value

  CustomRadioButtonScreen({
    required this.heading,
    required this.options,
    required this.onSelect,
  });

  @override
  _CustomRadioButtonScreenState createState() =>
      _CustomRadioButtonScreenState();
}

class _CustomRadioButtonScreenState extends State<CustomRadioButtonScreen> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom Heading
        Text(
          widget.heading,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        SizedBox(height: 13),

        // Radio buttons
        Wrap(
          spacing: 8,
          crossAxisAlignment:WrapCrossAlignment.start,
          children: widget.options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: option,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                    widget.onSelect(value!); // Pass selected value to parent
                  },
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
