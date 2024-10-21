import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../base/utils/namespase/app_colors.dart';

class ReviewScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: displayWidth(context),
        height: displayHeight(context),
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child:  SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const BackButton(),
                       const Text(
                        textAlign: TextAlign.center,
                        'Review Form',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: displayWidth(context) * 0.10,
                      ),
                      const Expanded(
                        child: Wrap(children: [

                        ],),
                      )
                    ],
                  ),
                ],
              )),
        )
    );
  }
}