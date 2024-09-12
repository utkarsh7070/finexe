import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoardFormList extends ConsumerWidget {
  const DashBoardFormList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SizedBox(
        width: displayWidth(context),
        height: displayHeight(context),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: ListTile(
                leading: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: displayWidth(context) * 0.15,
                  height: displayHeight(context) * 0.07,
                  child:  const Center(child: Text('FP')),
                ),
                title: const Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text('FormPending'),
                    Text('customerid'),
                    Text('status by cibil'),
                    Text('status by pd'),
                  ],
                ),
                 trailing: Text('Resume Form'),
              ),
            );
          },
        ),
      ),
    );
  }
}
