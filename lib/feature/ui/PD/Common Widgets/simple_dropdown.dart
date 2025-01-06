import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class CustomDropDownTextField extends StatelessWidget {
  final List<DropDownValueModel> items;
  final String labelText;
  final TextEditingController controller; // Use TextEditingController

  const CustomDropDownTextField({
    super.key,
    required this.items,
    this.labelText = 'Select an option',
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:
          MainAxisSize.min, // Ensures the Column takes up only necessary space
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          child: DropDownTextField(

            clearOption: false,
            enableSearch: false,
            dropDownList: items,
            textFieldDecoration: InputDecoration(
                label: Text(labelText),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelStyle: AppStyles.subHeading),
            textStyle: AppStyles.headingTextStyle,
            initialValue: controller.text, // Set initial value from controller
            onChanged: (value) {
              controller.text =
                  value?.value ?? ''; // Update controller on change
            },
          ),
        ),
      ],
    );
  }
}
