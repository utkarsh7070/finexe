import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../../../../../../base/utils/namespase/app_colors.dart';
// import '../../../../../../../../../../base/utils/namespase/display_size.dart';
import '../../view_model/income_form_viewmodel.dart';
import '../Others/others.dart';
import '../Salary Income/salary_income.dart';
import '../Agriculutre/agriculture_form.dart';
import '../Milk Form/milk_form.dart'; // Import the provider created above

class IncomeDetailForm extends ConsumerWidget {
  // const IncomeDetailForm({super.key});
  final String customerId;
  IncomeDetailForm({required this.customerId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomeState = ref.watch(incomeFormProvider);
    final incomeNotifier = ref.read(incomeFormProvider.notifier);

    final SingleValueDropDownController _controller =
        SingleValueDropDownController();

    // Set initial dropdown value
    if (incomeState.selectedIncomeSource != null) {
      _controller.setDropDown(incomeState.selectedIncomeSource!);
    }

    return SingleChildScrollView(
      child: ExpansionTile(
        // childrenPadding: const EdgeInsets.only(left: 16, bottom: 0),
        shape: const Border(
          bottom: BorderSide(color: AppColors.dividerColor),
        ),
        title: const Text('Income Details Form'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown for Income Source Type
                SizedBox(
                  height: displayHeight(context) * 0.07,
                  child: DropDownTextField(
                    controller: _controller,
                    clearOption: false,
                    enableSearch: false,
                    dropDownList: [
                      DropDownValueModel(name: 'Select Type', value: '1'),
                      DropDownValueModel(
                          name: 'Agriculture Business Income', value: '2'),
                      DropDownValueModel(name: 'Milk Business', value: '3'),
                      DropDownValueModel(name: 'Salary Income', value: '4'),
                      DropDownValueModel(name: 'Others', value: '5'),
                    ],
                    textFieldDecoration: InputDecoration(
                      label: const Text('Income Source Type'),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gray, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onChanged: (value) {
                      if (value is DropDownValueModel) {
                        // Update the provider state
                        incomeNotifier.updateSelectedIncome(value);

                        // Close the dropdown
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Dynamic TextField based on Income Type
                if (incomeState.selectedIncomeSource?.value == '2') ...[
                  AgricultureIncomeDetail(customerId: customerId)
                ] else if (incomeState.selectedIncomeSource?.value == '3') ...[
                  MilkForm(customerId: customerId)
                ] else if (incomeState.selectedIncomeSource?.value == '4') ...[
                  Salaryincomedetail(customerId: customerId)
                ] else if (incomeState.selectedIncomeSource?.value == '5') ...[
                  Others(customerId: customerId)
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
