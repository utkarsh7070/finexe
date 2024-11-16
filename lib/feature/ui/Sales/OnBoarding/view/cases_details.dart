import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';

class CasesDetails extends ConsumerWidget{
  const CasesDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 70),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Text('Kamal Dhakad'),
                  SizedBox(width: displayWidth(context)*0.06,)
                ],
              ),
              Expanded(child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                return SizedBox(
                  height: displayHeight(context)*0.07,
                  child: Card(
                    elevation: 1,

                    color: AppColors.tintGreen,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.check_circle_rounded,color: Colors.green,),
                    SizedBox(width: displayWidth(context)*0.04,),
                    Text('Cibil')
                  ],

                  ),),
                );
              },))
            ],
          ),
        ),
      ),
    );
  }

}