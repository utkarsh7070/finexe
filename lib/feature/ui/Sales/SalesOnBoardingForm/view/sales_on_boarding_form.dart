import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
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
          content: const StepperContentOne(),
          isActive: currStep == 0),
      Step(
          title: const Text('Co-Applicant Detail\'s'),
          content: Container(),
          isActive: currStep == 1),
      Step(
          title: const Text('Co-Applicant Detail\'s'),
          content: Container(),
          isActive: currStep == 2)
    ];
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stepper(
          physics: const BouncingScrollPhysics(),
          type: StepperType.horizontal,
          steps: step,
          currentStep: currStep,
          controlsBuilder: (context, details) {
            return Column(
              children: [
                currStep == 0? Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(color: AppColors.boxBagGray,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        height: displayHeight(context)*0.05,
                        width: displayWidth(context)*0.10,
                        child: IconButton(
                          color:AppColors.primery,

                            onPressed: () {

                        }, icon: const Icon(Icons.add)),
                      ),
                      // SizedBox(
                      //   child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(backgroundColor: AppColors.gray,
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius:
                      //                   BorderRadius.all(Radius.circular(10)))),
                      //       onPressed: () {},
                      //       child: const Icon(Icons.add)),
                      // // ),
                      SizedBox(width: displayWidth(context)*0.02,),
                      const Text('Add More Co-Applicant')
                    ],
                  ),
                ):const SizedBox(),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        ref
                            .read(stepperProvider.notifier)
                            .nextStep(step.length);
                      },
                      child: const Text(
                        'CONTINUE',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(stepperProvider.notifier).previousStep();
                      },
                      child: const Text(
                        'CANCEL',
                      ),
                    )
                  ],
                ),
              ],
            );
          },
          onStepTapped: (step) {
            ref.read(stepperProvider.notifier).setStep(step);
          },
        ),
      ),
    );
  }
}
