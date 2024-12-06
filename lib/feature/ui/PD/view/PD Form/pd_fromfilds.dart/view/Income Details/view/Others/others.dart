import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../Common Widgets/common_textfield.dart';
class Others extends ConsumerWidget {
  Others({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController other_nature_business = TextEditingController();
    TextEditingController other_monthly_income = TextEditingController();
    TextEditingController other_yearly_income = TextEditingController();
    TextEditingController other_desc_business = TextEditingController();
    TextEditingController other_business_since = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nature of Business
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CustomTextFormField(
                inerHint: 'Nature of Business',
                onValidate: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "This is a required field";
                  }
                  return null;
                },
                controller: other_nature_business,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
              ),
            ),

            sizedBoxWithContext(context, 0.03),

            // Monthly Income
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CustomTextFormField(
                inerHint: 'Monthly Income',
                onValidate: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "This is a required field";
                  }
                  return null;
                },
                controller: other_monthly_income,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.number,
              ),
            ),

            sizedBoxWithContext(context, 0.03),

            // Yearly Income
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CustomTextFormField(
                inerHint: 'Yearly Income',
                onValidate: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "This is a required field";
                  }
                  return null;
                },
                controller: other_yearly_income,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.number,
              ),
            ),

            sizedBoxWithContext(context, 0.03),

            // Description of Business
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CustomTextFormField(
                inerHint: 'Description of Business',
                onValidate: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "This is a required field";
                  }
                  return null;
                },
                controller: other_desc_business,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
              ),
            ),

            sizedBoxWithContext(context, 0.03),

            // Business Since
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CustomTextFormField(
                inerHint: 'Business Since',
                onValidate: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "This is a required field";
                  }
                  return null;
                },
                controller: other_business_since,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
              ),
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
