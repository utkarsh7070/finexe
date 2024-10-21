import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../view_model/sales_on_boarding_form.dart';
import 'Sales_on_boarding_form/applicant_form/appliction_form.dart';
import 'widget/stepper_content.dart';

class SalesOnBoardingForm extends ConsumerWidget {
  const SalesOnBoardingForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child:ApplicationDetails()
      ),
    );
  }
}
