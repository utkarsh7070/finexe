import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/pd_fromfilds.dart/Common%20Dropdown/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class CustomDropDownTextField extends ConsumerWidget {
  final List<DropDownValueModel> items;
  final String labelText;

  const CustomDropDownTextField({
    Key? key,
    required this.items,
    this.labelText = 'Select an option',
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the selected value from the provider
    final selectedValue = ref.watch(selectedValueProvider);

    return SizedBox(
      height: displayHeight(context) * 0.07,
      child: DropDownTextField(
        clearOption: false,

        // listSpace: 20,
        // listPadding: ListPadding(top: 20),
        enableSearch: false,
        dropDownList: items,
        textFieldDecoration: InputDecoration(
          label: Text(
            labelText,
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // filled: true,
          // fillColor: AppColors.gray,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          // labelText: hintText,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          // ),
        ),
        initialValue: selectedValue?.name,
      ),
    );
  }
}
