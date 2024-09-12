import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/sales_on_boarding_form.dart';
import 'widget/stepper_content.dart';

class SalesOnBoardingForm extends ConsumerWidget {
  const SalesOnBoardingForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currStep = ref.watch(stepperProvider);
    List<Step> step = [
      Step(
          title: const Text('Co-Applicant Detail\'s'),
          content: StepperContentOne(),
          isActive: currStep == 0),
      Step(
          title: const Text('Co-Applicant Detail\'s'),
          content: StepperContentOne(),
          isActive: currStep == 1)
    ];
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: displayWidth(context),
          height: displayHeight(context),
          child: Stepper(
            physics: const BouncingScrollPhysics(),
            type: StepperType.horizontal,
            steps: step,
            currentStep: currStep,
            controlsBuilder: (context, details) {
              return Row(
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(stepperProvider.notifier).nextStep(step.length);
                    },
                    child: Text(
                      'CONTINUE',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(stepperProvider.notifier).previousStep();
                    },
                    child: Text(
                      'CANCEL',
                    ),
                  )
                ],
              );
            },

            onStepTapped: (step) {
              ref.read(stepperProvider.notifier).setStep(step);
            },
          ),
        ),
      ),
    );
  }
}
