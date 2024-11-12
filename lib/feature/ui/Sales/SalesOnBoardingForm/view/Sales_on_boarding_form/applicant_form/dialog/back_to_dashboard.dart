import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../NewLone/view_model/new_loan_view_model.dart';

class ConfirmBackToDashBoard extends ConsumerWidget {
  const ConfirmBackToDashBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: displayWidth(context),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () {
                ref.invalidate(personalDetailViewModelProvider);
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard, (route) => false,);
              },
              child: const Text(
                'Yes',
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(
            width: displayWidth(context),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(side: BorderSide(color: AppColors.gray),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
                style: const TextStyle(color: AppColors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
