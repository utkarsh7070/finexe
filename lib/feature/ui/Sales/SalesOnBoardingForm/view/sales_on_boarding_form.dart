import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Sales_on_boarding_form/applicant_form/appliction_form.dart';

class SalesOnBoardingForm extends ConsumerWidget {
  const SalesOnBoardingForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(
        child:ApplicationDetails({})
      ),
    );
  }
}
