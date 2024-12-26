import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/Sales/OnBoarding/view_model/on_boarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widget/list_of_form.dart';

class OnBoardingScreen extends ConsumerWidget{
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: displayHeight(context),
      width: displayWidth(context),
      child: DashBoardFormList(),
    );
  }

}


