import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../Common Widgets/common_textfield.dart';

class Salaryincomedetail extends ConsumerWidget {
   Salaryincomedetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController SalaryincomeForm_CompanyName = TextEditingController();

    TextEditingController SalaryincomeForm_AddressSalayProvider = TextEditingController();

    TextEditingController SalaryincomeForm_MobileNo = TextEditingController();

    TextEditingController SalaryincomeForm_FromNumberYear = TextEditingController();

    TextEditingController SalaryincomeForm_SalaryPaid = TextEditingController();

    TextEditingController SalaryincomeForm_MonthlySalary = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return  SingleChildScrollView(
          child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Company Name',
                  onValidate: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: SalaryincomeForm_CompanyName,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Address of salary provider',
                  onValidate: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: SalaryincomeForm_AddressSalayProvider,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Mobile no. of salary provider',
                  onValidate: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: SalaryincomeForm_MobileNo,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Doing from no. years',
                  onValidate: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: SalaryincomeForm_FromNumberYear,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Salary Paid Through',
                  onValidate: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: SalaryincomeForm_SalaryPaid,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              sizedBoxWithContext(context, 0.03),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Monthly net salary',
                  onValidate: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: SalaryincomeForm_MonthlySalary,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
              ),

              sizedBoxWithContext(context, 0.03),
            Text('Last three months of salary slip',
            style: AppStyles.blackText16
            ),



            ],
          ),
        ),
      );
  }

   SizedBox sizedBoxWithContext(BuildContext context, double heightFactor) {
     return SizedBox(
       height: MediaQuery.of(context).size.height * heightFactor,
     );
   }


}
