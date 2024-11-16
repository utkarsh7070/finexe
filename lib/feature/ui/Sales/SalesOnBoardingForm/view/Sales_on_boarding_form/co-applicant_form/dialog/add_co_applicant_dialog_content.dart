import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../base/routes/routes.dart';
import '../../../../view_model/co_applicant_form_view_model.dart';

class AddCoApplicantDialog extends ConsumerWidget {
  const AddCoApplicantDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexAdd = ref.watch(listIndex.notifier);
    final coApplicationFormViewModel =
    ref.read(coApplicantViewModelProvider.notifier);
    final formNotifierController = ref.read(coApplicantController.notifier);
    final coApplicationFormState = ref.watch(coApplicantViewModelProvider);
    final index = ref.watch(listIndex);
    return Container(
        child: Row(
      children: [
        AppButton(
          onTap: () {
            indexAdd.state = index + 1;
            coApplicationFormViewModel.addForm();
            formNotifierController.addFormData();
            // coAddressRadioViewModel
            //     .selectAddress(CoApplicantOptionRole.NON);
            if (kDebugMode) {
              print(coApplicationFormState.length);
            }
            if (kDebugMode) {
              print(coApplicationFormState.toList());
            }
            ref
                .read(pageViewModelProvider.notifier)
                .setTabIndex(0);
          },
          label: 'Yes',
        ),
        AppButton(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.saleGuarantorForm1);
          },
          label: 'No',
        )
      ],
    ));
  }
}
